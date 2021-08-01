clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data Extraction

R = readtable('Regression_dataset.csv');
R = R{:,:};

[m,n] = size(R); % m = 506, n = 14

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Training Data 'R_train'

perc = 0.8; % data division percentage
R_train = R(1:round(perc*m),:);

Y_train = R_train(:,14); % Output Vector
X_train = [R_train(:,1:13) ones(round(perc*m),1)]'; % Input Matrix

n_train = size(X_train,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test Data 'R_test'

R_test = R(round(perc*m)+1:m,:);

Y_test = R_test(:,14); % Class Label
X_test = [R_test(:,1:13) zeros(m-round(perc*m),1) + 1]'; % Input Matrix

[m_test,n_test] = size(X_test);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ridge Regression on hyperparameter 'alpha'

% Defining Kernel Matrix
d = 2; % Put d = 1 for linear kernel, and d = 2 for polynomial kernel
L = 2; % L > 0, L = 2 gave minimum training error

if d == 1
    K_train = X_train'*X_train; % Linear Kernel
    alpha = pinv(K_train)*Y_train;
else
    K_train = polykernel(X_train,X_train); % Polynomial Kernel
    I = eye(n_train);
    alpha = (K_train + L*I)\Y_train;
end

% Prediction on Training 'H_train'
H_train = K_train*alpha;

% Mean squared Training error ' J_train'
J_train = 1/n_train*(norm(H_train -Y_train))^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Defining Kernel Matrix for Test Data

if d == 1
    K_test = X_test'*X_train;
else
    K_test = polykernel(X_test,X_train);
end

% Prediction on Test 'H_test'
H_test = K_test*alpha; % alpha is trained on 'X' and 'Y'

% Mean squared Training error ' J_train'
J_test = 1/n_test*(norm(H_test - Y_test))^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Refer to file 'polykernel.m' for information about the function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






