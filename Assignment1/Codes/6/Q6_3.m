hold on;
w_6=polyfit(X_train, Y_train,6);
tf_train=cos(2*pi*X_train')+tanh(2*pi*X_train');
tf_test=cos(2*pi*X_test')+tanh(2*pi*X_test');
train_fit=polyval(w_6,X_train');
test_fit=polyval(w_6,X_test');
scatter(tf_train,train_fit,'o');
scatter(tf_test,test_fit,180,'+');
xlabel('Target Function','FontSize',20);
ylabel('Model Predicted Values','FontSize',20);
title('Scatter plot for test and training data versus target function','FontSize',20);
legend({'Training data','Test data'},'FontSize',20);