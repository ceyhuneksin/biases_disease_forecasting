% sir dynamics no response

function x_integrated = sir_dynamics_Euler_integration(N,x,T,dt)

% x = [0.99, 0.01,0.5,0.4,1]
time = 0:dt:T;
horizon = size(time);
Susc = zeros(horizon);
Infec = zeros(horizon);

Susc(1)=x(1); Infec(1)=x(2); beta=x(3); delta=x(4); k=x(5);


for tt = 1:horizon(2)-1
    a = (Susc(tt))^k;
    Susc(tt+1) = Susc(tt) + dt*(-beta*Susc(tt)*Infec(tt)*a);
    Infec(tt+1) = Infec(tt) + dt*((beta*Susc(tt)*Infec(tt)*a) - delta*Infec(tt));
end
x_integrated = struct('S',Susc,'I',Infec,'beta',beta,'delta',delta,'k',k);
