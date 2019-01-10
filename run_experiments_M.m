%% Generates Figure S3
% Need to comment out lines 10 in Extended_KF_k.m
%%%%%%%%%%%%%%%%%%%%%%
beta = 0.5; delta = 0.4;
noise_levels = 0.001; % level of measurement noise
dims_noise = size(noise_levels);
k_levels = 3; % level of distancing in the ground truth model
k_prior_mean_levels = 1;
dims_k = size(k_prior_mean_levels);
k_prior_var_levels = 0.5;
dims_var_levels = size(k_prior_var_levels);
sample_times = 1; % sample per week and prediction horizon
dims_sample = size(sample_times);
I_init_mean = 0.005;
repeats = 20;
M_vals = [5 10 20 50 100];
dims_M = size(M_vals);
% M = 20; % ensemble size
T= 40; % epidemic horizon weeks
explore_var = 0.0005; inflate =1;
dt = 0.001;
pred_error_store = zeros(dims_M(2),T,repeats);
% indices initialize
kk = 1;
seed = rng;
rng('default');
% k_prior_var = k_prior_var_levels;
noise_var = noise_levels;
k = k_levels;
k_prior_var = k_prior_var_levels;
k_prior_mean = k_prior_mean_levels;
sample = sample_times;
kk =1;
for M = M_vals
    for repeat =1:repeats
        x = [0.995, 0.005,0.5,0.4,k]; %S_init,I_init,beta, delta, k
        %                 k_pred_model = k; % prediction with correct model
        Extended_KF_k
        %                 pred_error_store(repeat,nn,kk) = norm(100*mean_pred_store-100*true_vals)*sample/norm(100*true_vals);
        for time = 1:T
            pred_error_store(kk,time,repeat) = norm(trajectory(:,time)-x_true.I');
        end
    end
    kk = kk+1
end
%%
pred_error_store_mean = zeros(5,T);
for tt = 1:T
        for kk=1:5
            pred_error_store_mean(kk,tt) = mean(pred_error_store(kk,tt,:,1));
        end
end
%% Generate Figure S3
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
legend boxoff
set(lll, 'FontSize',16)
set(gca,'FontSize',16)