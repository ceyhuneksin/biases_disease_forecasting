% Ensemble Kalman Filter for SEIR
%% Generates Figure S1
% Need to run Extended_KF_k_long_term.m and Extended_KF_long_term.m before
%% Synthetic true dynamics
x = [0.995, 0.005,0.5,0.4,3]; %S_init,I_init,beta, delta, k
beta = 0.5; delta = 0.4; 
dt = 0.001; 
noise_var = 0.001; 
explore_var = 0.0025; 
T= 40; sample = 1; I_init_mean = 0.005;
M = 50; % ensemble size
x_true = sir_dynamics_Euler_integration(1,x,T,dt); % long-term awareness ground truth
%% initialize Kalman filter ensemble

% Create the ensemble of the state
seed = rng;
rng('default');
I_init = I_init_mean + randn(M,1)*0.0005;
while length(find(I_init<0)) > 0
    I_init(find(I_init<0)) = I_init_mean + randn(length(find(I_init<0)),1)*0.0005;
end
E_init_mean = I_init_mean;
E_init = E_init_mean + randn(M,1)*0.0005;
S_init = 1-I_init-E_init;

while length(find(I_init<0)) > 0
    I_init(find(I_init<0)) = 0;
end

while length(find(E_init<0)) > 0
    E_init(find(E_init<0)) = 0;
end

mu_prior_var = 0.2;
mu_prior_mean = 0.75;
mu_init = mu_prior_mean*ones(M,1) + randn(M,1)*mu_prior_var;
while length(find(mu_init<0)) > 0
    mu_init(find(mu_init<0)) = 0;
end

state_init = struct('S',S_init,'I',I_init, 'E', E_init, 'mu',mu_init);
state_pred = struct('S',S_init,'I',I_init, 'E', E_init, 'mu',mu_init);
state_post = struct('S',S_init,'I',I_init, 'E', E_init, 'mu',mu_init);
state_init_S_mean = mean(state_init.S);
%% storage variables
mean_estimate_store_S =  zeros(T/sample,1);
mean_estimate_store_I = zeros(T/sample,1);
mean_estimate_store_E = zeros(T/sample,1);
mean_estimate_store_mu =  zeros(T/sample,1);
max_estimate_store_mu = zeros(T/sample,1);
min_estimate_store_mu = zeros(T/sample,1);

mean_pred_store = zeros(T/sample,1);
store_trajectories = zeros(T/dt,M,T/sample);
store_trajectories_E = zeros(T/dt,M,T/sample);

store_back_trajectories = zeros(T/dt,M,T/sample);
store_mean_trajectories = zeros(T/dt,T/sample);
store_mean_trajectories_E = zeros(T/dt,T/sample);

store_mean_back_trajectories = zeros(T/dt,T/sample);
obs_vals = zeros(T/sample,1);
true_vals = zeros(T/sample,1);
%% step time and begin updates
for ttt = 1:T/sample
    %prior
    tt = ttt*sample;
    S_prior = state_init.S*inflate;
    E_prior = state_init.E*inflate;
    I_prior = state_init.I*inflate;
    mu_prior = state_init.mu;
    % predict
    for m = 1:M % iterate over ensemble members
        x = [S_prior(m),E_prior(m),I_prior(m),beta,delta,mu_prior(m)];
        x_inte = SEIR_integration(1,x,sample,dt); % propagate sample weeks (long-term awareness)
        % predictions
        state_pred.I(m)= x_inte.I(end);
        state_pred.S(m)= x_inte.S(end);
        state_pred.E(m)= x_inte.E(end);
        %% For storage purposes generate full trajectory for every ensemble member
        x_integrate_full = SEIR_integration(1,x,T-tt+sample,dt); 
        store_trajectories(((tt-sample)/dt+1):T/dt+1,m, ttt) = x_integrate_full.I';
        store_trajectories_E(((tt-sample)/dt+1):T/dt+1,m, ttt) = x_integrate_full.E';
    end
    % store mean predicted trajectory of the ensemble
    store_mean_trajectories(((tt-sample)/dt+1):T/dt+1,ttt) = mean(store_trajectories(((tt-sample)/dt+1):T/dt+1,:,ttt)')';
    store_mean_trajectories_E(((tt-sample)/dt+1):T/dt+1,ttt) = mean(store_trajectories_E(((tt-sample)/dt+1):T/dt+1,:,ttt)')';

    %     store_mean_back_trajectories(1:(tt-sample)/dt+1,ttt)= mean(store_back_trajectories(1:(tt-sample)/dt+1,:,ttt)')';
    state_pred.mu = mu_prior;
    state_pred_mean = [mean(state_pred.S) mean(state_pred.I) mean(state_pred.E) mean(state_pred.mu)];
    mean_pred_store(ttt) = state_pred_mean(2); % store infection predictions only
    
    %% predict observations with noise
    obs_pred_mean = state_pred_mean(2);
    obs_pred = state_pred.I+ randn(M,1)*explore_var;
    %% Observe noisy Infected
    obs = x_true.I(tt/dt + 1)+ randn*noise_var;
    obs_vals(ttt) = obs; % store observations
    true_vals(ttt) = x_true.I(tt/dt + 1);
    %% Compute gain
    state_anomaly = ([state_pred.S state_pred.I state_pred.E state_pred.mu] - ones(M,1)*state_pred_mean)';
    obs_anomaly = (obs_pred-obs_pred_mean)';
    obs_covariance = obs_anomaly*obs_anomaly'/(M-1);
    innovation_covariance = state_anomaly*obs_anomaly'/(M-1);
    K = innovation_covariance * inv(obs_covariance);
    %% compute posterior ensemble members
    post_estimates = [state_pred.S state_pred.I state_pred.E state_pred.mu] +(K* (obs*ones(M,1) - obs_pred)')';
    state_post.S = post_estimates(:,1);
    state_post.I = post_estimates(:,2);
    state_post.E = post_estimates(:,3);
    state_post.mu = post_estimates(:,4);
    % store posterior estimates
    mean_estimate_store_E(ttt) = mean(state_post.E);
    mean_estimate_store_I(ttt) = mean(state_post.I); % store post estimates
    mean_estimate_store_S(ttt) = mean(state_post.S); % store post estimates
    max_estimate_store_mu(ttt) = max(state_post.mu);
    min_estimate_store_mu(ttt) = min(state_post.mu);
    %     state_post.I = state_post_mean + randn(M,1)*explore_var;
    %     state_post.S = 1-state_post.I;
    %% posterior estimate becomes the prior for the next time step
    while length(find(state_post.mu<0)) > 0
        state_post.mu(find(state_post.mu<0)) = randn*explore_var;
    end 
    mean_estimate_store_mu(ttt) = mean(state_post.mu); % store post estimates
    state_init = state_post;
end
%% Merge trajectories
trajectory = zeros(T/dt+1, T/sample);
for time = 1:sample:T
    trajectory(:,time) = [store_mean_back_trajectories(1:(time-sample)/dt,time); store_mean_trajectories(((time-sample)/dt+1):T/dt+1,time)];
end

%%
figure
hold on
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(0,mean(I_init)*100,'go','LineWidth',3)
time = 1;
plot(([mean(I_init) mean_estimate_store_I'])*100,'k','LineWidth',3);
yyy = ylabel('Percentage Infected');
set(gca,'FontSize',16);

xlabel('Weeks');
xlim([0 40])

% plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,1)*100,'r--','LineWidth',3);
%%
figure
hold on
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(0,mean(E_init)*100,'go','LineWidth',3)
time = 1;
plot(([mean(E_init) mean_estimate_store_E'])*100,'k','LineWidth',3);
plot((time-1)*sample:dt:T,store_mean_trajectories_E(((time-1)*sample/dt+1):T/dt+1,1)*100,'r--','LineWidth',3);
%%

figure
hold on
y2 = [max(mu_init) max_estimate_store_mu'];
y1 = [min(mu_init) min_estimate_store_mu'];
x = 0:1:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
% hb = plot(x, y1, 'k--','LineWidth', 2);
% hc = plot(x, y2, 'k--','LineWidth', 2);

plot(0:sample:T,[mean(mu_init) mean_estimate_store_mu'], 'ko','LineWidth', 2,'MarkerSize',5)
plot(0:sample:T,[mean(mu_init) mean_estimate_store_mu'], 'k-','LineWidth', 2)
% plot(0:sample:T,ones(T+1,1)*0, 'b-','LineWidth', 2)
% plot(dt:dt:T,k, 'b-','LineWidth', 2)

yyy = ylabel('$\mu$ estimates');
set(yyy,'Interpreter','Latex')
axis([0 T -1 3])
set(gca,'YTick',-1:1:3);
set(gca,'XTick',0:10:T);
xlabel('Weeks');
set(gca,'FontSize',16);


%% Generate Figure S1
% pred_error_store_SIR = zeros(T,1);
% pred_error_store_SIRb = zeros(T,1);
% pred_error_store_SEIR = zeros(T,1);
for time = 1:T
    pred_error_store_SEIR(time) = norm(trajectory(:,time)-x_true.I');
end
%%
figure
hold on
plot(0:1:T-1,pred_error_store_SIR, 'k','LineWidth', 2,'MarkerSize',2)
plot(0:1:T-1,pred_error_store_SIRb, 'b','LineWidth', 2)
plot(0:1:T-1,pred_error_store_SEIR,'r','LineWidth', 2)
yyy = ylabel('Forecast error');
% set(yyy,'Interpreter','Latex')
axis([0 T 0 3])

set(gca,'YTick',0:1:3);
set(gca,'XTick',0:10:T);
xlabel('Weeks');
lll = legend('SIR w/out behavior','SIR w/behavior','SEIR w/out behavior');
legend boxoff
set(gca,'FontSize',16);

