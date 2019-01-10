%% Figure 4(a-b) - weekly final size predictions
% Run Extended_KF_long_term.m and Extended_KF_short_term.m 
figure
hold on
plot(0:1:T-1,ones(T,1)*(1-x_true.S(end))*100,'b','LineWidth',2)
plot(0:1:T-1,mean(final_size_estimates(:,:))*100,'r','LineWidth',2)
plot(0:1:T-1,mean(final_size_estimates_behavior(:,:))*100,'k','LineWidth',2)

y2 = max(final_size_estimates_behavior(:,:))*100;
y1 = min(final_size_estimates_behavior(:,:))*100;
x = 0:1:T-1;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

plot(0:1:T-1,mean(final_size_estimates_behavior(:,:))*100,'k','LineWidth',2)

y2 = max(final_size_estimates(:,:))*100;
y1 = min(final_size_estimates(:,:))*100;
x = 0:1:T-1;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [1.0 0.5 0.5])

plot(0:1:T-1,mean(final_size_estimates(:,:))*100,'r','LineWidth',2)

yyy = ylabel('Final Size Predictions');
set(gca,'FontSize',16);

xlabel('Weeks');
set(gca,'FontSize',16);

xlim([0 40])
ylim([5 40])
% ax = gca;
% ax.YTickLabel = {'5','10%','20%','30%', '40%'};
lll = legend('Ground truth','Model w/out behavior','Model w/behavior');
legend boxoff
set(lll,'Interpreter','Latex');
set(lll, 'FontSize',16);