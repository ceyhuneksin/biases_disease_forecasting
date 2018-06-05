% run extended KF experiments for k learning
% change distancing constant and sampling frequency
beta = 0.5; delta = 0.4;
noise_levels = [0.001]; % level of measurement noise
dims_noise = size(noise_levels);
k_levels = 3; % level of distancing in the ground truth model
k_prior_mean_levels = [2 3 4];
dims_k = size(k_prior_mean_levels);
k_prior_var_levels = [0.5];
dims_var_levels = size(k_prior_var_levels);
sample_times = 1; % sample per week and prediction horizon
dims_sample = size(sample_times);
I_init_mean = 0.005;
repeats = 1;
M = 20; % ensemble size
T= 40; % epidemic horizon weeks
explore_var = 0.005; inflate =1;
dt = 0.001;
pred_error_store = zeros(repeats,dims_var_levels(2), dims_k(2));
% indices initialize
nn = 1; kk = 1; ss = 1;
seed = rng;
rng('default');
for k_prior_var = k_prior_var_levels
    noise_var = noise_levels;
    k = k_levels;
    sample = sample_times;
    kk = 1;
    for k_prior_mean = k_prior_mean_levels
            for repeat =1:repeats
                x = [0.995, 0.005,0.5,0.4,k]; %S_init,I_init,beta, delta, k
%                 k_pred_model = k; % prediction with correct model
                Extended_KF_k
                pred_error_store(repeat,nn,kk) = norm(100*mean_pred_store-100*true_vals)*sample/norm(100*true_vals);
            end
        kk = kk+1;
    end
    nn = nn+1
end

%% compute mean pred error store
mean_pred_error_store = zeros(dims_var_levels(2), dims_k(2));

for nnn = 1:nn-1
    for kkk = 1:kk-1
            mean_pred_error_store(nnn,kkk) = mean(pred_error_store(:,nnn,kkk));
    end
end

%%
size(mean_pred_error_store)

%%
figure 
hold on
plot(k_prior_var_levels,mean_pred_error_store(:,1),'r')
plot(k_prior_var_levels,mean_pred_error_store(:,2),'b')
plot(k_prior_var_levels,mean_pred_error_store(:,3),'k')
plot(k_prior_var_levels,mean_pred_error_store(:,4),'g')

set(gca,'XTick',k_prior_var_levels);
% set(gca,'YTick',noise_levels);

xlabel('Prior Variance')
ylabel('Normalized mean error')
set(gca,'FontSize',16 )

% axis([0.002 0.012 0 25])

% lll = legend('Weekly - Linear','Weekly - Nonlinear',  'Biweekly - Linear','Biweekly - Nonlinear', 'Monthly - Linear','Monthly - Nonlinear');
% set(lll,'Interpreter','Latex');


%%
% mean_pred_error_store_accurate = mean_pred_error_store;


%%
error_increase = zeros(size(mean_pred_error_store));
for kk = 1:dims_k(2)
    error_increase(:,kk) = (mean_pred_error_store(:,kk)./mean_pred_error_store_accurate(1))-1;
end 

figure 
hold on
plot(k_prior_var_levels,error_increase(:,1),'k-s','LineWidth',2,'MarkerSize',10)
plot(k_prior_var_levels,error_increase(:,2),'k-*','LineWidth',2,'MarkerSize',10)
plot(k_prior_var_levels,error_increase(:,3),'k-o','LineWidth',2,'MarkerSize',10)
% plot(k_prior_var_levels,error_increase(:,4),'k-*','LineWidth',2,'MarkerSize',10)

set(gca,'XTick',k_prior_var_levels);
% set(gca,'YTick',noise_levels);

xlabel('Prior Variance')
ylabel('Relative forecast error')
set(gca,'FontSize',16 )

% lll = legend('$k=1$','$k=2$', '$k=3$');
% set(lll,'Interpreter','Latex');

% lll = legend('$k=1$','$k=2$', '$k=3$');
% set(lll,'Interpreter','Latex');
axis([0.25 1 -0.1 5])

lll = legend('$\bar k = 2$', '$\bar k = 3$','$\bar k = 4$');
set(lll,'Interpreter','Latex');
set(lll,'FontSize',16)
