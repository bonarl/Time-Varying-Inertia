function dxdt = equations(t,x)
I_1 = 100;
I_2 = 200;
I_3 = 300;
M_1 = 0.001;
M_2 = 0;
M_3 = 0;

w_1 = x(1);
w_2 = x(2);
w_3 = x(3);
q_1 = x(4);
q_2 = x(5);
q_3 = x(6);
q_4 = x(7);

dxdt = zeros(size(x));
dxdt(1) = (I_2-I_3)/I_1*w_2*w_3+M_1/I_1;
dxdt(2) = (I_3-I_1)/I_2*w_3*w_1+M_2/I_2;
dxdt(3) = (I_1-I_2)/I_3*w_1*w_2+M_3/I_3;
dxdt(4) = 1/2*(-w_1*q_2-w_2*q_3-w_3*q_4);
dxdt(5) = 1/2*(w_1*q_1+w_3*q_3-w_2*q_4);
dxdt(6) = 1/2*(w_2*q_1-w_3*q_2+w_1*q_4);
dxdt(7) = 1/2*(w_3*q_1+w_2*q_2-w_1*q_3);
end
