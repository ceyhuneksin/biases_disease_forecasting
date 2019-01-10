%% Figure 3
% Run Extended_KF_short_term.m for (a)
% Run Extended_KF_k_short_term.m for (b)
% Run Extended_KF_long_term.m for (c)
% Run Extended_KF_k_long_term.m for (d)

figure
hold on
time = 1;
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(0,mean(I_init)*100,'go','LineWidth',3)
time = 1;
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,1)*100,'k','LineWidth',3);
% lll = legend('Ground truth','Observations', 'Point estimate', 'Past prediction', 'Current prediction');
% set(lll,'Interpreter','Latex');
time = 1;
y2 = max(store_trajectories(1:T/dt+1,:,time)')*100;
y1 = min(store_trajectories(1:T/dt+1,:,time)')*100;
x = 0:dt:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'k--','LineWidth', 2);
hc = plot(x, y2, 'k--','LineWidth', 2);

plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(0,mean(I_init)*100,'go','LineWidth',3)
plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,1)*100,'k','LineWidth',3);

% set(gca,'YTick', []);
% set(gca,'YTickLabels', {});
% axis([0 40 0 4.5])
% set(gca,'YTick',0:0.5:4.5);
% set(gca,'XTick',0:10:T);
ylim([0 3])
ax = gca;
ax.YTickLabel = {'0','1%','2%','3%'};

set(gca,'XTick',0:4:40);
set(gca,'FontSize',16);
% yyy = ylabel('Percentage Infected');
xlabel('Weeks');
%%
figure
hold on
time = 5;
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)
time = 1
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

y2 = max(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
x = (time-sample):dt:(time+4-1);
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'r--','LineWidth', 2);
hc = plot(x, y2, 'r--','LineWidth', 2);


time = 5
plot((time-1)*ones(1,2),[0 y2(end)],'k:','Linewidth',2)

plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

y2 = max(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
x = ((time-sample)):dt:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'k--','LineWidth', 2);
hc = plot(x, y2, 'k--','LineWidth', 2);

plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)
time = 1
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

time = 5
plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

ylim([0 3])
set(gca,'XTick',0:4:T);
set(gca,'FontSize',16);
ax = gca;
ax.YTickLabel = {'0','1%','2%','3%'};
% yyy = ylabel('Percentage Infected');
xlabel('Weeks');

%%
figure
hold on
time = 9;
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)
time = 5

plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

y2 = max(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
x = (time-sample):dt:(time+4-1);
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'r--','LineWidth', 2);
hc = plot(x, y2, 'r--','LineWidth', 2);


time = 9
plot((time-1)*ones(1,2),[0 y2(end)],'k:','Linewidth',2)

plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

y2 = max(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
x = ((time-sample)):dt:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'k--','LineWidth', 2);
hc = plot(x, y2, 'k--','LineWidth', 2);

plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)
time = 5
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

time = 9
plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

ylim([0 3])
set(gca,'XTick',0:4:T);
set(gca,'FontSize',16);
ax = gca;
ax.YTickLabel = {'0','1%','2%','3%'};

% yyy = ylabel('Percentage Infected');
xlabel('Weeks');

%%
figure
hold on
time = 9+4;
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)
time = 5+4
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

y2 = max(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
x = (time-sample):dt:(time+4-1);
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'r--','LineWidth', 2);
hc = plot(x, y2, 'r--','LineWidth', 2);


time = 9+4
plot((time-1)*ones(1,2),[0 y2(end)],'k:','Linewidth',2)

plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

y2 = max(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
x = ((time-sample)):dt:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'k--','LineWidth', 2);
hc = plot(x, y2, 'k--','LineWidth', 2);

plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)
time = 5+4
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

time = 9+4
plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

ylim([0 3])
ax = gca;
ax.YTickLabel = {'0','1%','2%','3%'};

set(gca,'XTick',0:4:T);
set(gca,'FontSize',16);
% yyy = ylabel('Percentage Infected');
xlabel('Weeks');

%%
figure
hold on
time = 9+4+4;
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)
time = 5+4+4
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

y2 = max(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
x = (time-sample):dt:(time+4-1);
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'r--','LineWidth', 2);
hc = plot(x, y2, 'r--','LineWidth', 2);


time = 9+4+4
plot((time-1)*ones(1,2),[0 y2(end)],'k:','Linewidth',2)

plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

y2 = max(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
x = ((time-sample)):dt:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'k--','LineWidth', 2);
hc = plot(x, y2, 'k--','LineWidth', 2);

plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)
time = 5+4+4
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

time = 9+4+4
plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

set(gca,'XTick',0:4:T);
ax = gca;
ax.YTickLabel = {'0','1%','2%','3%'};

set(gca,'FontSize',16);
% yyy = ylabel('Percentage Infected');
xlabel('Weeks');
ylim([0 3])

%%
figure
hold on
time = 9+4+4+4;
zz = zeros(1,5);
zz(1) = plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
zz(2) = plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
zz(3) = scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)

time = 5+4+4+4;
zz(4) = plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);
time = 9+4+4+4;
zz(5) = plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);



y2 = max(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):((time+4-1)*sample/dt+1),:,time)')*100;
x = (time-sample):dt:(time+4-1);
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hb = plot(x, y1, 'r--','LineWidth', 2);
hc = plot(x, y2, 'r--','LineWidth', 2);

time = 9+4+4+4;
hd = plot((time-1)*ones(1,2),[0 y2(end)],'k:','Linewidth',2)
he = plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

y2 = max(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
y1 = min(store_trajectories(((time-sample)/dt+1):T/dt+1,:,time)')*100;
x = ((time-sample)):dt:T;
y = [y1; y2-y1]';

ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')
set(ha(2), 'FaceColor', [0.7 0.7 0.7])

% plot the line edges
hf= plot(x, y1, 'k--','LineWidth', 2);
hg = plot(x, y2, 'k--','LineWidth', 2);



hh = plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
hi = plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
hj = scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)

time = 5+4+4+4;
hk= plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);
time = 9+4+4+4;
hl = plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);

% set(get(get(ha(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hb(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hc(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hd(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(he(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hf(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hg(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hh(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hi(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hj(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hk(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(hl(2),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
lll = legend(zz(1:5),'Ground truth','Observations', 'Point estimate', 'Past prediction', 'Current prediction');
set(lll,'Interpreter','Latex');

ylim([0 3])
ax = gca;
ax.YTickLabel = {'0','1%','2%','3%'};

set(gca,'XTick',0:4:T);
set(gca,'FontSize',16);
% yyy = ylabel('Percentage Infected');
xlabel('Weeks');