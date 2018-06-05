%%
delta = 0.4;
options = odeset('RelTol',1e-4,'AbsTol',[1e-4]);
[T,X] = ode45(@(t,x)sir_dynamics(t,x,delta),[0 200],[0.999;0.001],options);

[N,Y] = ode45(@(n,y)sir_dynamics_linear(n,y,delta),[0 200],[0.999;0.001],options);

[M,Z] = ode45(@(m,z)sir_dynamics_nonlinear(m,z,delta),[0 200],[0.999;0.001],options);


figure 
hold on
plot(T,1-X(:,1)-X(:,2),'k-',N,1-Y(:,1)-Y(:,2),'r-', M,1-Z(:,1)-Z(:,2),'b-')
xlabel('Time');
ylabel('Percentage Affected');
% legend('Recovered')
set(gca,'XTick',[0:40:200]);
set(gca,'YTick',[0:0.08:0.4]);
ax = gca;
ax.XTickLabel = {'0','20','40','60','80','100','\infty'};
ax.YTickLabel = {'0','8%','16%','24%','32%', '40%'};
ylim([0 0.4])

% title('Short-term awareness')


set(gca,'FontSize',18)

%%
figure 
hold on
plot(T,X(:,1),'-o',T,X(:,2),'-o',T,1-X(:,1)-X(:,2),'-o')
xlabel('Time t');
ylabel('Percentage');
legend('Susceptible','Infected','Recovered')
set(gca,'XTick',[0 200]);
set(gca,'YTick',[0:0.2:1]);
ax = gca;
ax.XTickLabel = {'0','\infty','\infty'};
% ax.YTickLabel = {'0','4%','8%','12%','16%', '20%'};
ylim([0 1])

set(gca,'FontSize',16)