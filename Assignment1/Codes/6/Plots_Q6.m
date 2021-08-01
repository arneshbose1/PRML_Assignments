hold on
scatter(X_sample,Y_sample);
X_s=0:0.001:1;
plot(X_s,polyval(w_1,X_s),'LineWidth',1.5);
plot(X_s,polyval(w_3,X_s),'LineWidth',1.5);
plot(X_s,polyval(w_6,X_s),'LineWidth',1.5);
plot(X_s,polyval(w_9,X_s),'LineWidth',1.5);
tf=cos(2*pi*X_s)+tanh(2*pi*X_s);
plot(X_s,tf,'LineWidth',1.5);
xlim([0 1]);
ylim([-10 15]);
xlabel('X values','FontSize',20);
ylabel('value of function','FontSize',20);
title('Regression plot for sample size of 10','FontSize',20);
legend({'Sample Points','degree 1','degree 3','degree 6','degree 9','Target Function'},'FontSize',20);
