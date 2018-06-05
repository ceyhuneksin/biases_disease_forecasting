%% SIR homogeneous mixing model

function dy = sir_dynamics(t,y,delta)

beta = 0.5;
dy = [- beta* y(1) *y(2); (-delta)* y(2) + beta* y(1) *y(2) ];
