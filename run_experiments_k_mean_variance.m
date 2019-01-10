%%%%%%%%%%%%%%%%%%%
%% Generates Figure S2
% Need to comment out lines 15-16 in Extended_KF_k.m
%%%%%%%%%%%%%%%%%%%%%%
beta = 0.5; delta = 0.4;
noise_levels = 0.001; % level of measurement noise
dims_noise = size(noise_levels);
k_levels = 3; % level of distancing in the ground truth model
k_prior_mean_levels = [2 3 4];
dims_k = size(k_prior_mean_levels);
k_prior_var_levels = [0.1 0.5 0.9];
dims_var_levels = size(k_prior_var_levels);
sample_times = 1; % sample per week and prediction horizon
dims_sample = size(sample_times);
I_init_mean = 0.005;
repeats = 20;
M = 20; % ensemble size
T= 40; % epidemic horizon weeks
explore_var = 0.0005; inflate =1;
dt = 0.001;
pred_error_store = zeros(dims_var_levels(2),dims_k(2),T,repeats);
% indices initialize
kk = 1;
seed = rng;
rng('default');
% k_prior_var = k_prior_var_levels;
noise_var = noise_levels;
k = k_levels;
sample = sample_times;
vv =1;
for k_prior_var = k_prior_var_levels
    kk = 1;
    for k_prior_mean = k_prior_mean_levels
        for repeat =1:repeats
            x = [0.995, 0.005,0.5,0.4,k]; %S_init,I_init,beta, delta, k
            %                 k_pred_model = k; % prediction with correct model
            Extended_KF_k
            %                 pred_error_store(repeat,nn,kk) = norm(100*mean_pred_store-100*true_vals)*sample/norm(100*true_vals);
            for time = 1:T
                pred_error_store(vv,kk,time,repeat) = norm(trajectory(:,time)-x_true.I');
            end
        end
        kk = kk+1
    end
    vv = vv+1
end
%%
pred_error_store_mean = zeros(3,3,T);
for tt = 1:T
    for vv = 1:3
        for kk=1:3
            pred_error_store_mean(vv,kk,tt) = mean(pred_error_store(vv,kk,tt,:));
        end
    end
end
%%
figure
hold on
kk = 1;
vector_error = reshape(pred_error_store_mean(1,kk,:),[T,1]);
plot(vector_error,'k','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(2,kk,:),[T,1]);
plot(vector_error,'r','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(3,kk,:),[T,1]);
plot(vector_error,'b','LineWidth', 2)

xlabel('Weeks')
ylabel('Forecast error')
lll = legend('$\bar k = 2$, $\sigma  = 0.1$','$\bar k = 2$, $\sigma  = 0.5$', '$\bar k = 2$, $\sigma  = 0.9$');
set(lll,'Interpreter','Latex');
set(lll, 'FontSize',18)
set(gca,'FontSize',18)
legend boxoff


figure
hold on
kk = 2;
vector_error = reshape(pred_error_store_mean(1,kk,:),[T,1]);
plot(vector_error,'k','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(2,kk,:),[T,1]);
plot(vector_error,'r','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(3,kk,:),[T,1]);
plot(vector_error,'b','LineWidth', 2)

xlabel('Weeks')
ylabel('Forecast error')
lll = legend('$\bar k = 3$, $\sigma  = 0.1$','$\bar k = 3$, $\sigma  = 0.5$', '$\bar k = 3$, $\sigma  = 0.9$');
set(lll,'Interpreter','Latex');
set(lll, 'FontSize',18)
set(gca,'FontSize',18)
axis([0 40 0 0.5]);
legend boxoff

figure
hold on
kk = 3;
vector_error = reshape(pred_error_store_mean(1,kk,:),[T,1]);
plot(vector_error,'k','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(2,kk,:),[T,1]);
plot(vector_error,'r','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(3,kk,:),[T,1]);
plot(vector_error,'b','LineWidth', 2)

axis([0 40 0 0.5]);
xlabel('Weeks')
ylabel('Forecast error')
lll = legend('$\bar k = 4$, $\sigma  = 0.1$','$\bar k = 4$, $\sigma  = 0.5$', '$\bar k = 4$, $\sigma  = 0.9$');
set(lll,'Interpreter','Latex');
set(lll, 'FontSize',18)
set(gca,'FontSize',18)
legend boxoff

%     vector_error = reshape(pred_error_store_mean(1,2,:),[T,1]);
%     plot(vector_error,'g','LineWidth', 2)
%     vector_error = reshape(pred_error_store_mean(2,2,:),[T,1]);
%     plot(vector_error,'g','LineWidth', 2)
%     vector_error = reshape(pred_error_store_mean(3,2,:),[T,1]);
%     plot(vector_error,'g--','LineWidth', 2)

% xlabel('Weeks')
% ylabel('Forecast error')
% set(gca,'FontSize',16 )
% 
% % axis([0.25 1 -0.1 5])
% lll = legend('$\bar k = 2$, $\sigma  = 0.1$','$\bar k = 4$, $\sigma  = 0.1$', '$\bar k = 2$, $\sigma  = 0.5$', '$\bar k = 4$, $\sigma  = 0.5$', '$\bar k = 2$, $\sigma  = 0.9$', '$\bar k = 4$, $\sigma  = 0.9$');
% % lll = legend('$\bar k = 2$, $\sigma  = 0.25$', '$\bar k = 3$, $\sigma  = 0.25$','$\bar k = 4$, $\sigma  = 0.25$', '$\bar k = 2$, $\sigma  = 0.5$', '$\bar k = 3$, $\sigma  = 0.5$','$\bar k = 4$, $\sigma  = 0.5$', '$\bar k = 2$, $\sigma  = 0.75$', '$\bar k = 3$, $\sigma  = 0.75$','$\bar k = 4$, $\sigma  = 0.75$');
% set(lll,'Interpreter','Latex');
% set(lll,'FontSize',16)
