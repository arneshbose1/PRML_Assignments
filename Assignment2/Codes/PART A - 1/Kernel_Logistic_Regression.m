clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data Extraction

Raw_data = readtable('Dataset_3_Team_18.csv');
R = Raw_data{:,:};

[m,n] = size(R); % m = 1000, n = 3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Training Data 'R_train'

perc = 0.8; % data division percentage
R_train = R(1:round(perc*m),:);

X_train = [R_train(:,1:2) ones(round(perc*m),1)]'; % Input Matrix
Y_train = R_train(:,3); % Class Label Vector 0,1

n_train = length(Y_train);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test Data 'R_test'

R_test = R(round(perc*m)+1:m,:);

X_test = [R_test(:,1:2) ones(m-round(perc*m),1)]'; % Input Matrix
Y_test = R_test(:,3); % Class Label Vector 0,1

n_test = length(Y_test);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kernel Gradient Descent on hyperparameter 'alpha'

% Defining Kernel Matrix
d = 1; % Put d = 1 for linear kernel, and d = 2 for polynomial kernel

if d == 1
    K_train = X_train'*X_train; % Linear Kernel
    phi_train = X_train;
else
    K_train = polykernel(X_train,X_train); % Polynomial Kernel
    phi_train = phi(X_train);
end


% Gradient descent loop
alpha_rand = rand(n_train,1); % Random initialisation
alpha = alpha_rand;

a = 0.001; % learning rate
max_iter = 10000;
for i = 1:max_iter
    Z = K_train*alpha;
    for k = 1:n_train
        Z(k) = 1/(1+exp(-Z(k)));
    end
    G = K_train*(Z-Y_train);
    alpha = alpha - a*G; 
    
    % Stopping criteria 'stop_crit'
    stop_crit = 10^-2;
    if norm(G)/n_train <= stop_crit
        break
    end
end

w = phi_train*alpha; % Weights from 'alpha'

% Prediction on Train 'H_train'
H_train = sign(phi_train'*w);
for j = 1:n_train
    if H_train(j) == -1
        H_train(j) = 0;
    end
end

% Training accuracy
trainacc = sum(H_train == Y_train)/length(H_train)*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Defining Kernel Matrix for Test Data
if d == 1
    K_test = X_test'*X_train; % Linear kernel
    phi_test = X_test;
else
    K_test = polykernel(X_test,X_train); % Polynomial kernel
    phi_test = phi(X_test);
end

% Prediction on Test 'H_test'
H_test = sign(phi_test'*w);
for j = 1:n_test
    if H_test(j) == -1
        H_test(j) = 0;
    end
end

% Test accuracy
testacc = sum(H_test == Y_test)/length(H_test)*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data visualization (Training only)
syms x y;
if d == 1
    type = ' (Linear Kernel)';
    C = dot(w,[x; y; 1]);
else
    type = ' (Polynomial Kernel)';
    C = dot(w,[x^2; y^2; sqrt(2)*x*y; sqrt(2)*x; sqrt(2)*y; 1]);
end


figure (1);
gscatter(X_train(1,:),X_train(2,:),Y_train,'rb','.',15)
title(join(['Decision Boundary on Training Data',type]), 'FontSize', 20)
hold on

% Plotting Decision boundaries 
fimplicit(C == 0 ,'k', 'LineWidth',2);
legend1 = legend('Class 0','Class 1','Location','northeast');
legend1.FontSize = 14;
axis equal
axis([min(X_train(1,:)) max(X_train(1,:)) min(X_train(2,:)) max(X_train(2,:))])
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Refer to file 'polykernel.m' for information about the function
% Refer to file 'phi.m' for information about the function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









