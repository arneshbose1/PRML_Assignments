error_1=zeros(1,71);
error_3=zeros(1,71);
error_6=zeros(1,71);
error_9=zeros(1,71);
a=10:80;
for i=a
  size=i;
  X_sample=X_train(1:size);
  Y_sample=Y_train(1:size);
  w_1=polyfit(X_sample,Y_sample,1);
  w_3=polyfit(X_sample,Y_sample,3);
  w_6=polyfit(X_sample,Y_sample,6);
  w_9=polyfit(X_sample,Y_sample,9);
  val_1=polyval(w_1,X_test');
  va=cos(2*pi*X_test')+tanh(2*pi*X_test');
  val_1=val_1-va;
  error_1(1,i-9)=(val_1*val_1')/20;
  
   val_3=polyval(w_3,X_test');
  val_3=val_3-va;
  error_3(1,i-9)=(val_3*val_3')/20;
  
   val_6=polyval(w_6,X_test');
   val_6=val_6-va;
  error_6(1,i-9)=(val_6*val_6')/20;
  
   val_9=polyval(w_9,X_test');
  val_9=val_9-va;
  error_9(1,i-9)=(val_9*val_9')/20;
end

hold on
plot(a,error_1,'LineWidth',1.5);
plot(a,error_3,'LineWidth',1.5);
plot(a,error_6,'LineWidth',1.5);
plot(a,error_9,'LineWidth',1.5);
xlim([10 80]);
ylim([0 1]);
xlabel('Training Sample Size','FontSize',20);
ylabel('Test Error','FontSize',20);
title('Test Error for different sample sizes','FontSize',20);
legend({'degree 1','degree 3','degree 6','degree 9'},'FontSize',20);
