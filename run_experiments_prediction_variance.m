%% generates data for figure S7 and plots the figure
%% calls Extended_KF_k multiple times
%% note that ground truth parameter initialization, and explore vars have to be commented out in Extended_KF_k
beta = 0.5; delta = 0.4;
noise_levels = 0.001; % level of measurement noise
k_levels = 3; % level of distancing in the ground truth model
k_prior_mean_levels = 1; % levels of k prior mean
k_prior_var_levels = 0.5; % levels of k prior variance
sample_times = 1; % sample per week and prediction horizon
I_init_mean = 0.005;
repeats = 5; % repeat the same experiment multiple times to get a mean error
M=20; % ensemble size
T=40; % epidemic horizon weeks
explore_vars = [10^-7 10^-8 10^-9 10^-10 10^-11]; % levels of the artificial prediction noise for Ensemble KF w/o behavior
% explore_vars = [10^-2 10^-3 10^-4 10^-5 10^-6]; % levels of the artificial prediction noise for Ensemble KF with behavior
dims_explore_vars = size(explore_vars);
dt = 0.001;
pred_error_store = zeros(dims_explore_vars(2),T,repeats);
weekly_estimates_store = zeros(T,dims_explore_vars(2),repeats);
noise_var = noise_levels;
k = k_levels;
k_prior_var = k_prior_var_levels;
k_prior_mean = k_prior_mean_levels;
sample = sample_times;
% indices initialize
kk = 1;
seed = rng;
rng('default');
% k_prior_var = k_prior_var_levels;
forecast_error = zeros(dims_explore_vars(2),repeats);

for explore_var = explore_vars % iterate over prediction noise values in the set
    for repeat =1:repeats
        x = [0.995, 0.005,0.5,0.4,k]; %S_init,I_init,beta, delta, k
%         Extended_KF_k % run ensemble KF withs behavior
        Extended_KF % run ensemble KF w/o behavior
        weekly_estimates_store(:,kk,repeat) = mean_estimate_store';
        forecast_error(kk,repeat) = norm(weekly_estimates_store(:,kk,repeat)-true_vals);
        repeat
    end
    kk = kk+1
end
%% plot figures S5 and S6
% If ensemble KF w/o behavior (Extended_KF.m) is run, the result is Fig. S5
% If ensemble KF with behavior (Extended_KF_k.m) is run, the result is Fig. S6
figure
hold on
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3);
plot(sample:sample:T-1,obs_vals(1:T-1)*100,'bx','LineWidth',2,'MarkerSize',10);
%  colorss = zeros(3,1);
mean_estimates = zeros(T,8);
for tt = 1:T
    for kk = 1:5
        mean_estimates(tt,kk) = mean(weekly_estimates_store(tt,kk,:));
        if isnan(mean_estimates(tt,kk))
            mean_estimates(tt,kk) = 0;
        end
    end
end
for kk = 1:5
    scatter(1:sample:T,mean_estimates(:,kk)*100,'LineWidth',3)
%         colorss(:,kk) = get(h,'Color');
end
% plot(0:dt:T,store_mean_trajectories(1:T/dt+1,1)*100,'k','LineWidth',3);
% scatter(1:sample:T,mean_estimate_store*100,'go','LineWidth',3)
% time = 20;
% plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'r','LineWidth',3);
% plot((T-1)*sample:dt:T,store_mean_trajectories(((T-1)*sample/dt+1):T/dt+1,time)*100,'r','LineWidth',3);
lll = legend('Ground truth','Observations', '$\bar x_{t|t}$ -- $\xi^i_t\sim \mathcal{N}(0,10^{-2})$','$\bar x_{t|t}$ -- $\xi^i_t\sim \mathcal{N}(0,10^{-3})$','$\bar x_{t|t}$ -- $\xi^i_t\sim \mathcal{N}(0,10^{-4})$','$\bar x_{t|t}$ -- $\xi^i_t\sim \mathcal{N}(0,10^{-7})$','$\bar x_{t|t}$ -- $\xi^i_t\sim \mathcal{N}(0,10^{-8})$','$\bar x_{t|t}$ -- $\xi^i_t\sim \mathcal{N}(0,10^{-10})$', '$\bar x_{t|t}$ -- $\xi^i_t\sim \mathcal{N}(0,10^{-15})$','$\bar x_{t|t}$ -- $\xi^i_t\sim \mathcal{N}(0,0)$');
set(lll,'Interpreter','Latex');
%  colorss = zeros(3,1);
% for time = 1:5:T/sample
%     h = plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'LineWidth',2);
%     colorss(:,time) = get(h,'Color');
%     %     plot(0:dt:(time-1)*sample,store_mean_back_trajectories(1:((time-1)*sample/dt+1),time)*100,'--','Color',col,'LineWidth',2);
% end
% 
% for time = 2:T/sample
%     plot(0:dt:(time-1)*sample,store_mean_back_trajectories(1:((time-1)*sample/dt+1),time)*100,'Color',colorss(:,time),'LineWidth',2);
% end
% plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3);
% plot(sample:sample:T-1,obs_vals(2:T/sample)*100,'bx','LineWidth',2,'MarkerSize',10);
% plot(0:dt:T,store_mean_trajectories(1:T/dt+1,1)*100,'k','LineWidth',3);
% % time =20;
% % plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'r','LineWidth',3);
% scatter(1:sample:T,mean_estimate_store*100,'go','LineWidth',3)
% plot((T-1)*sample:dt:T,store_mean_trajectories(((T-1)*sample/dt+1):T/dt+1,T)*100,'r','LineWidth',3);
% plot(0:dt:(time-1)*sample,store_mean_back_trajectories(1:((time-1)*sample/dt+1),time)*100,'r','LineWidth',3);
axis([0 40 0 3])
set(gca,'YTick',0:0.5:3);
set(gca,'XTick',0:10:T);
yyy = ylabel('Percentage Infected');
xlabel('Weeks');
set(gca,'FontSize',16);
%% plot figure S7
forecast_error_mean = zeros(5,1);
for kk = 1:5
    forecast_error_mean(kk) = mean(forecast_error(kk,:));
end

figure 
hold on
plot(forecast_error_mean(1:5),'b','LineWidth',3,'MarkerSize',10);
set(gca,'XTick',1:1:5);
set(gca,'XTickLabels',{'10^{-7}','10^{-8}','10^{-9}','10^{-10}','10^{-11}'}); 
yyy = ylabel('Forecast error');
xlabel('Prediction noise variance');
set(gca,'FontSize',15);