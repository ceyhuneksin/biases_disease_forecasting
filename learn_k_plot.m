%% learn k plot ( Figure 4 c-d)

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

% plot the line edges
% hb = plot(x, y1, 'k--','LineWidth', 2);
% hc = plot(x, y2, 'k--','LineWidth', 2);

plot(0:sample:T,[mean(k_init) mean_estimate_store_k'], 'ko','LineWidth', 2,'MarkerSize',5)
plot(0:sample:T,[mean(k_init) mean_estimate_store_k'], 'k-','LineWidth', 2)
plot(0:sample:T,ones(T+1,1)*3, 'b-','LineWidth', 2)
% plot(dt:dt:T,k, 'b-','LineWidth', 2)

yyy = ylabel('Behavior ($k$) estimates');
set(yyy,'Interpreter','Latex')
axis([0 T -1 5])
set(gca,'YTick',-1:1:5);
set(gca,'XTick',0:10:T);
xlabel('Weeks');
set(gca,'FontSize',16);

%%

figure
hold on
y2 = [max(k_init) max_estimate_store_beta'];
y1 = [min(k_init) min_estimate_store_beta'];
x = 0:1:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
% hb = plot(x, y1, 'k--','LineWidth', 2);
% hc = plot(x, y2, 'k--','LineWidth', 2);

plot(0:sample:T,[mean(beta_init) mean_estimate_store_beta'], 'ko','LineWidth', 2,'MarkerSize',5)
plot(0:sample:T,[mean(beta_init) mean_estimate_store_beta'], 'k-','LineWidth', 2)
plot(0:sample:T,ones(T+1,1)*3, 'b-','LineWidth', 2)

yyy = ylabel('$\beta$ estimates');
set(yyy,'Interpreter','Latex')
axis([0 T 0 2])
set(gca,'YTick',0:.4:2);
set(gca,'XTick',0:5:T);
xlabel('Weeks');
set(gca,'FontSize',16);

%%
figure
hold on
y2 = [max(k_init) max_estimate_store_delta'];
y1 = [min(k_init) min_estimate_store_delta'];
x = 0:1:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
% hb = plot(x, y1, 'k--','LineWidth', 2);
% hc = plot(x, y2, 'k--','LineWidth', 2);

plot(0:sample:T,[mean(delta_init) mean_estimate_store_delta'], 'ko','LineWidth', 2,'MarkerSize',5)
plot(0:sample:T,[mean(delta_init) mean_estimate_store_delta'], 'k-','LineWidth', 2)
plot(0:sample:T,ones(T+1,1)*3, 'b-','LineWidth', 2)

yyy = ylabel('$\delta$ estimates');
set(yyy,'Interpreter','Latex')
axis([0 T 0 2])
set(gca,'YTick',0:.4:2);
set(gca,'XTick',0:5:T);
xlabel('Weeks');
set(gca,'FontSize',16);