%% Run Ensemble KF with or w/o behavior (short-term or long-term awareness)
%% run this code to generate a column of Fig. 3
%% need to adjust ylim accordingly to have the same y axis ranges

figure
hold on
time = 1;
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(0,mean_estimate_store(1)*100,'go','LineWidth',3)
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
scatter(0,mean_estimate_store(1)*100,'go','LineWidth',3)
plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,1)*100,'k','LineWidth',3);

% set(gca,'YTick', []);
% set(gca,'YTickLabels', {});
% axis([0 40 0 4.5])
% set(gca,'YTick',0:0.5:4.5);
% set(gca,'XTick',0:10:T);
ylim([0 3])

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

ylim([0 2.5])
set(gca,'XTick',0:4:T);
set(gca,'FontSize',16);
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

ylim([0 2.5])
set(gca,'XTick',0:4:T);
set(gca,'FontSize',16);
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
set(gca,'FontSize',16);
% yyy = ylabel('Percentage Infected');
xlabel('Weeks');
ylim([0 2.5])

%%
figure
hold on
time = 9+4+4+4;
plot(0:dt:T,x_true.I((1:T/dt+1))*100,'b','LineWidth',3)
plot(sample:sample:T,obs_vals*100,'bx','LineWidth',2)
scatter(time-1,mean_estimate_store(time-1)*100,'go','LineWidth',3)
time = 5+4+4+4;
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

time = 9+4+4+4;
plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);


% lll = legend('Ground truth','Observations', 'Point estimate', 'Past prediction', 'Current prediction');
% set(lll,'Interpreter','Latex');

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
time = 5+4+4+4;
plot((time-1):dt:((time+4-1)),store_mean_trajectories(((time-1)/dt+1):((time+4-1)*sample/dt+1),time)*100,'r','LineWidth',3);

time = 9+4+4+4;
plot((time-1)*sample:dt:T,store_mean_trajectories(((time-1)*sample/dt+1):T/dt+1,time)*100,'k','LineWidth',3);
ylim([0 2.5])
set(gca,'XTick',0:4:T);
set(gca,'FontSize',16);
% yyy = ylabel('Percentage Infected');
xlabel('Weeks');