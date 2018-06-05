%% Run Ensemble KF with behavior (short-term or long-term awareness)
%% run this code to generate Fig. 4

figure
hold on
y2 = [max(k_init) max_estimate_store_k'];
y1 = [min(k_init) min_estimate_store_k'];
x = 0:1:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

plot(0:sample:T,[mean(k_init) mean_estimate_store_k'], 'ko','LineWidth', 2,'MarkerSize',5)
plot(0:sample:T,[mean(k_init) mean_estimate_store_k'], 'k-','LineWidth', 2)
plot(0:sample:T,ones(T+1,1)*3, 'b-','LineWidth', 2)

yyy = ylabel('Behavior ($k$) estimates');
set(yyy,'Interpreter','Latex')
axis([0 T 0 4])
set(gca,'YTick',0:1:4);
set(gca,'XTick',0:10:T);
xlabel('Weeks');
set(gca,'FontSize',16);