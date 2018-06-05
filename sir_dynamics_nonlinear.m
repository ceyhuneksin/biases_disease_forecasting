%% SIR homogeneous mixing model

function dy = sir_dynamics_nonlinear(t,y,delta)

k=3;
beta = 0.5;
dy = [- beta* y(1) *y(2)* (1-y(2))^k; (-delta)* y(2) + beta* y(1) *y(2) * (1-y(2))^k ];
