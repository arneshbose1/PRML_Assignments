w_1=polyfit(X_train,Y_train,1);
w_3=polyfit(X_train,Y_train,3);
w_6=polyfit(X_train,Y_train,6);
w_9=polyfit(X_train,Y_train,9);

train_error=zeros(1,4);
test_error=zeros(1,4);

tf_train=cos(2*pi*X_train')+tanh(2*pi*X_train');
tf_test=cos(2*pi*X_test')+tanh(2*pi*X_test');

train_fit_1=polyval(w_1,X_train')-tf_train;
test_fit_1=polyval(w_1,X_test')-tf_test;
train_error(1,1)=(train_fit_1*train_fit_1')/80;
test_error(1,1)=(test_fit_1*test_fit_1')/20;

train_fit_3=polyval(w_3,X_train')-tf_train;
test_fit_3=polyval(w_3,X_test')-tf_test;
train_error(1,2)=(train_fit_3*train_fit_3')/80;
test_error(1,2)=(test_fit_3*test_fit_3')/20;

train_fit_6=polyval(w_6,X_train')-tf_train;
test_fit_6=polyval(w_6,X_test')-tf_test;
train_error(1,3)=(train_fit_6*train_fit_6')/80;
test_error(1,3)=(test_fit_6*test_fit_6')/20;

train_fit_9=polyval(w_9,X_train')-tf_train;
test_fit_9=polyval(w_9,X_test')-tf_test;
train_error(1,4)=(train_fit_9*train_fit_9')/80;
test_error(1,4)=(test_fit_9*test_fit_9')/20;

p=[1 3 6 9];

hold on
plot(p,train_error,'Linewidth',2);
plot(p,test_error,'Linewidth',2);
xlabel('Degree of Polynomial','FontSize',20);
ylabel('Error','FontSize',20);
title('RMS error for training and test dataset','FontSize',20);
legend({'Training data','Test data'},'FontSize',20);