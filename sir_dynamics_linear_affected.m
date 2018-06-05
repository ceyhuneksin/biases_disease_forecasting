%% SIR homogeneous mixing model

function dy = sir_dynamics_linear_affected(t,y,delta)

beta = 0.5;
dy = [- beta* y(1) *y(2)* (y(1)); (-delta)* y(2) + beta* y(1) *y(2) * (y(1)) ];
