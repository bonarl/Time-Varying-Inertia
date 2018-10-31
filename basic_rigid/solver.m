t_0 = 0;
t_end = 200;
n = 10000;
t_range = linspace(t_0,t_end,n);

x_init = [0.001;0.5;0          %%%initial angular velocity vector
    ;1;0;0;0];                 %%%initial orientation quaternion
[t,x] = ode45(@equations_I_varying,t_range,x_init,opts);
w_t = x(:,1:3);
q_t = x(:,4:7);
R_t = quat2rotm(q_t);
e2s = [];
%%%Plotting%%%
for i = 1:size(R_t,3)
    R = R_t(:,:,i);
    e1 = (R*[1;0;0])';
    e2 = (R*[0;1;0])';
    e3 = (R*[0;0;1])';
    e2s=[e2s;e2];
    quiver3(0,0,0,e1(1),e1(2),e1(3));
    hold on
    quiver3(0,0,0,e2(1),e2(2),e2(3));
    hold on
    quiver3(0,0,0,e3(1),e3(2),e3(3));
    hold off
    axis([-1,1,-1,1,-1,1]);
    drawnow
end
scatter3(e2s(:,1),e2s(:,2),e2s(:,3),1,'r','filled')

