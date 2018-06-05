%% generates data for figure S1 and plots the figure
%% calls Extended_KF_k multiple times
%% note that ground truth parameter initialization, k_prior_mean have to be commented out in Extended_KF_k
beta = 0.5; delta = 0.4;
noise_levels = 0.001; % value of measurement noise
k_levels = 3; % value of distancing in the ground truth model
k_prior_mean_levels = [1 2 3 4 5]; % levels of k prior mean
dims_k = size(k_prior_mean_levels);
k_prior_var_levels = 0.5; % levels of k prior variance
sample_times = 1; % sample per week and prediction horizon
I_init_mean = 0.005;
repeats = 20; % repeat the same experiment multiple times to get a mean error
M = 20; % ensemble size
T= 40; % epidemic horizon weeks
explore_var = 0.0001; % value of the artificial prediction noise
dt = 0.001;
pred_error_store = zeros(dims_k(2),T,repeats); % to store trajectory error
k_prior_var = k_prior_var_levels;
noise_var = noise_levels;
k = k_levels;
sample = sample_times;
% indices initialize
kk = 1;
seed = rng;
rng('default');
kk = 1;
for k_prior_mean = k_prior_mean_levels % iterate over k prior mean values
    for repeat =1:repeats
        x = [0.995, 0.005,0.5,0.4,k]; %S_init,I_init,beta, delta, k % ground truth values 
        Extended_KF_k
        for time = 1:T % compute trajectory error
            pred_error_store(kk,time,repeat) = norm(trajectory(:,time)-x_true.I');
        end
    end
    kk = kk+1
end
%% compute mean error
pred_error_store_mean = zeros(5,T);
for tt = 1:T
    for kk=1:5
        pred_error_store_mean(kk,tt) = mean(pred_error_store(kk,tt,:));
    end
end
%% plot figure S1
figure
hold on
plot(pred_error_store_mean','LineWidth', 2)

xlabel('Weeks')
ylabel('Forecast error')
set(gca,'FontSize',16 )

% axis([0.25 1 -0.1 5])

lll = legend('$\bar k = 1$', '$\bar k = 2$','$\bar k = 3$', '$\bar k = 4$','$\bar k = 5$');
set(lll,'Interpreter','Latex');
set(lll,'FontSize',16)

