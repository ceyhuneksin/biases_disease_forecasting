%% generates data for figure S3 and plots the figure
%% calls Extended_KF_k multiple times
%% note that ground truth parameter initialization, k prior mean and measurement noise have to be commented out in Extended_KF_k
beta = 0.5; delta = 0.4;
noise_levels = [0.001 0.002 0.003]; % level of measurement noise
dims_noise = size(noise_levels);
k_prior_mean_levels = [1 2 3]; % levels of k prior mean
dims_k = size(k_prior_mean_levels);

k = 3; % level of distancing in the ground truth model
k_prior_var = 0.5; % levels of k prior variance
sample = 1; % sample per week and prediction horizon
I_init_mean = 0.005;
repeats = 20; % repeat the same experiment multiple times to get a mean error
M=20; % ensemble size
T= 40; % epidemic horizon weeks
explore_var = 0.0001;
dt = 0.001;
pred_error_store = zeros(dims_k(2),dims_noise(2),T,repeats);
% indices initialize
seed = rng;
rng('default');
kk =1; vv = 1;
for k_prior_mean = k_prior_mean_levels % iterate over k prior mean values
    kk = 1
    for noise_var = noise_levels % iterate over observation noise levels
        for repeat =1:repeats
            x = [0.995, 0.005,0.5,0.4,k]; %S_init,I_init,beta, delta, k % ground truth values 
            Extended_KF_k
            for time = 1:T % compute trajectory error
                pred_error_store(vv,kk,time,repeat) = norm(trajectory(:,time)-x_true.I');
            end
        end
        kk = kk+1
    end
    vv = vv+1
end
%% compute mean error
pred_error_store_mean = zeros(dims_k(2),dims_noise(2),T);
for tt = 1:T
    for vv=1:dims_k(2)
        for kk=1:dims_noise(2)
            pred_error_store_mean(vv,kk,tt) = mean(pred_error_store(vv,kk,tt,:));
        end
    end
end
%% plot figure S3
figure
hold on
% vector_error = reshape(pred_error_store_mean(1,1,:),[T,1]);
% plot(vector_error,'r','LineWidth', 2)
% vector_error = reshape(pred_error_store_mean(1,2,:),[T,1]);
% plot(vector_error,'r-.','LineWidth', 2)
% vector_error = reshape(pred_error_store_mean(1,3,:),[T,1]);
% plot(vector_error,'r--','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(2,1,:),[T,1]);
plot(vector_error,'b','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(2,2,:),[T,1]);
plot(vector_error,'b-.','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(2,3,:),[T,1]);
plot(vector_error,'b--.','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(3,1,:),[T,1]);
plot(vector_error,'k','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(3,2,:),[T,1]);
plot(vector_error,'k-.','LineWidth', 2)
vector_error = reshape(pred_error_store_mean(3,3,:),[T,1]);
plot(vector_error,'k--','LineWidth', 2)
lll = legend('$\bar k =2$, Noise-$0.1$','$\bar k =2$, Noise-$0.2$','$\bar k =2$, Noise-$0.3$','$\bar k =3$, Noise-$0.1$','$\bar k =3$, Noise-$0.2$','$\bar k =3$, Noise-$0.3$');
% lll = legend('$\bar k =1$, Noise-$0.1$','$\bar k =1$, Noise-$0.2$','$\bar k =1$, Noise-$0.3$','$\bar k =2$, Noise-$0.1$','$\bar k =2$, Noise-$0.2$','$\bar k =2$, Noise-$0.3$','$\bar k =3$, Noise-$0.1$','$\bar k =3$, Noise-$0.2$','$\bar k =3$, Noise-$0.3$');

set(lll,'Interpreter','Latex');
set(lll, 'FontSize',16);
set(gca,'FontSize',16);
xlabel('Weeks')
ylabel('Forecast error')