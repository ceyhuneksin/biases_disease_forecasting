% Ensemble Kalman Filter w/o behavior
%% Synthetic true dynamics
x = [0.995, 0.005,0.5,0.4,3]; %S_init,I_init,beta, delta, k
beta = 0.5; delta = 0.4;
dt = 0.001; noise_var = 0.001; explore_var = 0.0000000001; 
T= 40; sample = 1; I_init_mean = 0.005;
M = 20; % ensemble size
k_pred_model = 0;
x_true = sir_dynamics_Euler_integration(1,x,T,dt); % long-term awareness ground truth
% x_true = sir_dynamics_Euler_integration_short_term(1,x,T,dt); % uncomment for short-term awareness gound truth
%% initialize Kalman filter ensemble
seed = rng;
rng('default');
I_init = I_init_mean + randn(M,1)*0.0005;
% makes sure sampled I values are positive
while length(find(I_init<0)) > 0
    I_init(find(I_init<0)) = I_init_mean + randn(length(find(I_init<0)),1)*0.0005;
end
    
S_init = 1-I_init;
state_init = struct('S',S_init,'I',I_init);
state_pred = struct('S',S_init,'I',I_init);
state_post = struct('S',S_init,'I',I_init);
state_init_S_mean = mean(state_init.S);

%% storage variables
mean_estimate_store = zeros(T/sample,1);
mean_estimate_store_S =  zeros(T/sample,1);
mean_pred_store_S = zeros(T/sample,1);
mean_pred_store = zeros(T/sample,1);
store_trajectories = zeros(T/dt,M,T/sample);
store_back_trajectories = zeros(T/dt,M,T/sample);
store_mean_trajectories = zeros(T/dt,T/sample);
store_mean_back_trajectories = zeros(T/dt,T/sample);
obs_vals = zeros(T/sample,1);
true_vals = zeros(T/sample,1);

%% step time and begin updates
for ttt = 1:T/sample
    %% prior
    tt = ttt*sample;
    S_prior = state_init.S;
    I_prior = state_init.I;
    %% predict
    for m = 1:M % iterate over ensemble members
        x = [S_prior(m),I_prior(m),beta,delta,k_pred_model];
%         x_inte = sir_dynamics_Euler_integration(1,x,sample,dt); % propagate sample weeks (long-term awareness)
        x_inte = sir_dynamics_Euler_integration_short_term(1,x,sample,dt); % propagate sample weeks (short-term)
        % predictions
        state_pred.I(m)= x_inte.I(end);
        state_pred.S(m)= x_inte.S(end);
        %% For storage purposes generate full trajectory for every ensemble member
        x_integrate_full = sir_dynamics_Euler_integration_short_term(1,x,T-tt+sample,dt);
        x_integrate_back = sir_dynamics_Euler_backintegration_short_term(1,x,tt-sample,dt);
%         x_integrate_full = sir_dynamics_Euler_integration(1,x,T-tt+sample,dt);
%         x_integrate_back = sir_dynamics_Euler_backintegration(1,x,tt-sample,dt);
        store_trajectories(((tt-sample)/dt+1):T/dt+1,m, ttt) = x_integrate_full.I';
        store_back_trajectories(1:((tt-sample)/dt+1),m,ttt) = x_integrate_back.I';
    end
    % store mean predicted trajectory of the ensemble
    store_mean_trajectories(((tt-sample)/dt+1):T/dt+1,ttt) = mean(store_trajectories(((tt-sample)/dt+1):T/dt+1,:,ttt)')';
    store_mean_back_trajectories(1:(tt-sample)/dt+1,ttt)= mean(store_back_trajectories(1:(tt-sample)/dt+1,:,ttt)')';
    state_pred_mean = [mean(state_pred.S) mean(state_pred.I)];
    mean_pred_store_S(ttt) = state_pred_mean(1); % store infection predictions only
    mean_pred_store(ttt) = state_pred_mean(2); % store infection predictions only
    
    %% predict observations with noise
    obs_pred_mean = state_pred_mean(2);
    obs_pred = state_pred.I+ randn(M,1)*explore_var;
    %% Observe noisy Infected
    obs = x_true.I(tt/dt + 1)+ randn*noise_var;
    obs_vals(ttt) = obs; % store observations
    true_vals(ttt) = x_true.I(tt/dt + 1);
    %% Compute gain
    state_anomaly = ([state_pred.S state_pred.I] - ones(M,1)*state_pred_mean)';
    obs_anomaly = (obs_pred-obs_pred_mean)';
    obs_covariance = obs_anomaly*obs_anomaly'/(M-1);
    innovation_covariance = state_anomaly*obs_anomaly'/(M-1);
    K = innovation_covariance * inv(obs_covariance);
    %% compute posterior ensemble members
    post_estimates = [state_pred.S state_pred.I] +(K* (obs*ones(M,1) - obs_pred)')';
    state_post.S = post_estimates(:,1);
    state_post.I = post_estimates(:,2);   
    % store posterior estimates
    mean_estimate_store(ttt) = mean(state_post.I); % store post estimates
    mean_estimate_store_S(ttt) = mean(state_post.S); % store post estimates
    %% posterior estimate becomes the prior for the next time step
    state_init = state_post;
end