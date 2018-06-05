%% generates data for figure S4 and plots the figure
%% calls Extended_KF_k multiple times
%% note that ground truth parameter initialization, and M value have to be commented out in Extended_KF_k
beta = 0.5; delta = 0.4;
noise_levels = 0.001; % level of measurement noise
k_levels = 3; % level of distancing in the ground truth model
k_prior_mean_levels = 1; % levels of k prior mean
k_prior_var_levels = 0.5; % levels of k prior variance
sample_times = 1; % sample per week and prediction horizon
I_init_mean = 0.005;
repeats = 20; % repeat the same experiment multiple times to get a mean error
M_vals = [5 10 20 50 100]; % ensemble size levels
dims_M = size(M_vals); 
T= 40; % epidemic horizon weeks
explore_var = 0.0005; inflate =1;
dt = 0.001;
pred_error_store = zeros(dims_M(2),T,repeats);
% indices initialize
kk = 1;
seed = rng;
rng('default');
noise_var = noise_levels;
k = k_levels;
k_prior_var = k_prior_var_levels;
k_prior_mean = k_prior_mean_levels;
sample = sample_times;
kk =1;
for M = M_vals % iterate over ensemble size values
    for repeat =1:repeats
        x = [0.995, 0.005,0.5,0.4,k]; %S_init,I_init,beta, delta, k
        Extended_KF_k
        for time = 1:T  % compute trajectory error
            pred_error_store(kk,time,repeat) = norm(trajectory(:,time)-x_true.I');
        end
    end
    kk = kk+1
end
%% compute mean error
pred_error_store_mean = zeros(5,T);
for tt = 1:T
        for kk=1:5 
            pred_error_store_mean(kk,tt) = mean(pred_error_store(kk,tt,:,1));
        end
end
%% plot figure S4
figure
hold on
for kk = 1:5
    vector_error = reshape(pred_error_store_mean(kk,:),[T,1]);
    plot(vector_error,'LineWidth', 2)
end
xlabel('Weeks')
ylabel('Forecast error')
lll = legend('$M=5$','$M=10$','$M=20$','$M=50$','$M=100$');
set(lll,'Interpreter','Latex');
set(lll, 'FontSize',16)
set(gca,'FontSize',16)