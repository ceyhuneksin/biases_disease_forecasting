% sir dynamics no response

function x_integrated = sir_dynamics_Euler_backintegration_short_term(N,x,T,dt)
time = 0:dt:T;
horizon = size(time);
Susc = zeros(horizon);
Infec = zeros(horizon);
beta=x(3); delta=x(4); k=x(5);

if T ~=0
    time = 0:dt:T;
    horizon = size(time);
    Susc = zeros(horizon);
    Infec = zeros(horizon);
    Susc(horizon(2))=x(1); Infec(horizon(2))=x(2); beta=x(3); delta=x(4); k=x(5);
    
    for tt = 0:horizon(2)-2
        a = (1-Infec(horizon(2)-tt))^k;
        Susc(horizon(2)-tt-1) = Susc(horizon(2)-tt) - dt*(-beta*Susc(horizon(2)-tt)*Infec(horizon(2)-tt)*a);
        Infec(horizon(2)-tt-1) = Infec(horizon(2)-tt) - dt*((beta*Susc(horizon(2)-tt)*Infec(horizon(2)-tt)*a) - delta*Infec(horizon(2)-tt));
    end
    x_integrated = struct('S',Susc,'I',Infec,'beta',beta,'delta',delta,'k',k);
else
    x_integrated = struct('S',Susc,'I',Infec,'beta',beta,'delta',delta,'k',k);
end