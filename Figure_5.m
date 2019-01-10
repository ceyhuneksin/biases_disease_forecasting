%% Figure 5 
% Run Extended_KF_k_long_term.m, 
% Set noise_var = 0.001 for high SNR, noise_var = 0.003 for low SNR, and noise_var = 0.005 for very low SNR, 
figure
hold on
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(0,mean(I_init)*100,'go','LineWidth',3)
time = 1;
plot(([mean(I_init) mean_estimate_store'])*100,'k','LineWidth',3);
yyy = ylabel('Percentage Infected');
set(gca,'FontSize',16);

xlabel('Weeks');
xlim([0 40])
ylim([0 2])