%% SIR affected distancing
%% Find the zero crossing points of the function on the left of eq. 10
% no distancing
ll = 0.6:0.01:1; ii = 1;
f = zeros(length(ll),4);
beta = 0.5; delta = 0.4;
for x = ll
    f(ii,1) = x - exp(-beta*(1-x)/delta);
    ii = ii +1;
end

ll = 0.6:0.01:1; 
beta = 0.5; delta = 0.4;
for k = 1:1:3
    ii = 1;
for x = ll
    f(ii,k+1) = x - power((k)*(beta*(1-x)/delta)+1,-1/k);
    ii = ii +1;
end
 
end
%% plot Figure 1
figure 
plot(ll,f(:,1),'k','LineWidth', 1.5)
hold on

plot(ll,f(:,2),'r','LineWidth', 1.5)
plot(ll,f(:,3),'b','LineWidth', 1.5)
plot(ll,f(:,4),'g','LineWidth', 1.5)

lll = xlabel('$S/N$', 'FontSize',18);
set(lll,'Interpreter','Latex');
lll=ylabel('$\frac{S}{N}-[\frac{k \beta }{\delta}  (1-\frac{S}{N})+1]^{-1/k}$','FontSize',18);
set(lll,'Interpreter','Latex');
lll = legend('$k=0$','$k=1$','$k=2$', '$k=3$')
set(lll,'Interpreter','Latex');

legend boxoff
plot(ll,zeros(length(ll),1),'k')

scatter(0.63,0,'ko','Filled', 'LineWidth',2)
scatter(delta/beta,0,'ro','Filled', 'LineWidth',2)
scatter(0.863325,0,'bo','Filled', 'LineWidth',2)
scatter(0.896217,0,'go','Filled', 'LineWidth',2)

% legend('Recovered')
% set(gca,'XTick',[0 200]);
% set(gca,'YTick',[0:0.08:0.4]);
% ax = gca;
% ax.XTickLabel = {'0','\infty','\infty'};
% ax.YTickLabel = {'0','8%','16%','24%','32%', '40%'};
% ylim([0 0.4])

set(gca,'FontSize',18)
