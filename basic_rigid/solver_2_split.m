t_0 = 0;
t_end = 2000;
n = 1000;
t_range = linspace(t_0,t_end,n);
norm_steps = 10;

x_init = [0.001;0.1;0          %%%initial angular velocity vector
    ;1;0;0;0];  
opts = odeset('RelTol',1e-8,'AbsTol',1e-8);
w_t = [];
q_t = [];
R_t=[];
t_start = t_0;
while t_start < t_end
    t_start
    t_range = linspace(t_start, t_start+(t_end-t_0)/norm_steps,n/norm_steps);
    [t,x] = ode15s(@equations,t_range,x_init,opts);
    w_t = [w_t;x(:,1:3)];
    q_t = [q_t;x(:,4:7)];
    %%%normalise the last quaternion (this accounts for numerical drift)%%%
    q_t(end,:) = quatnormalize(q_t(end,:));
    t_start = t(end)
    %%%set initial values for next solver step
    x_init = [w_t(end,1);
        w_t(end,2);
        w_t(end,3);
        q_t(end,1);
        q_t(end,2);
        q_t(end,3);
        q_t(end,4)];
end
R_t = quat2rotm(q_t);

for i = 1:size(R_t,3)
    i
    R = R_t(:,:,i);
    e1 = (R*[1;0;0])';
    e2 = (R*[0;1;0])';
    e3 = (R*[0;0;1])';
    origin = zeros(1,3);
    quiver3(0,0,0,e1(1),e1(2),e1(3));
    hold on
    quiver3(0,0,0,e2(1),e2(2),e2(3));
    hold on
    quiver3(0,0,0,e3(1),e3(2),e3(3));
    hold off
    
    axis([-1,1,-1,1,-1,1]);
    drawnow
end