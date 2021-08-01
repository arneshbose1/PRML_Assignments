hold on;
xa=0:0.01:1;
xx = 0:0.0001:1;
yy = spline(xa,test_error,xx);
plot(xx,yy)
title('Plot error on test data as a function of alpha','FontSize',20);
xlabel('0<alpha<1','FontSize',20) ;
ylabel('test error','FontSize',20);