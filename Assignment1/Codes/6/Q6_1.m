%Generatin 100 sample points in (0,1) and apllying the given function
%and adding a gaussian noise

X=rand(100,1);
noise=randn(100,1)*sqrt(0.2);
Y=cos(2*pi*X)+tanh(2*pi*X)+noise;

%Breaking into training and test data

X_train=X(1:80,:);
Y_train=Y(1:80,:);
X_test=X(81:100,:);
Y_test=Y(81:100,:);

% Taking 10 points from the train data

size=10;
X_sample=X_train(1:size);
Y_sample=Y_train(1:size);
w_1=polyfit(X_sample,Y_sample,1);
w_3=polyfit(X_sample,Y_sample,3);
w_6=polyfit(X_sample,Y_sample,6);
w_9=polyfit(X_sample,Y_sample,9);



