clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data Extraction
dataset = 'Dataset_3_Team_18.csv';

Raw_data = readtable(dataset);
R = Raw_data{:,:};

[m,n] = size(R); % m = 1000, n = 3

% Changing Class Labels to -1, 1.
for i = 1:m
    if R(i,3) == 0
        R(i,3) = -1;
    end
end
% Note: Class labels are now changed to -1, 1 from 0, 1 ,respectively.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Training Data 'R_train'

perc = 0.8; % data division percentage
R_train = R(1:round(perc*m),:);

X_train = [R_train(:,1:2) ones(round(perc*m),1)]'; % Input Matrix
Y_train = R_train(:,3); % Class Label Vector -1,1

n_train = length(Y_train);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test Data 'R_test'

R_test = R(round(perc*m)+1:m,:);

X_test = [R_test(:,1:2) zeros(m-round(perc*m),1) + 1]'; % Input Matrix
Y_test = R_test(:,3); % Class Label Vector -1,1

n_test = length(Y_test);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kernel Perceptron Training on mistake counter 'alpha'

% Defining Kernel Matrix
d = 2; % Put d = 1 for linear kernel, and d = 2 for polynomial kernel

if d == 1
    K_train = X_train'*X_train; % Linear Kernel
    phi_train = X_train;
else
    K_train = polykernel(X_train,X_train); % Polynomial Kernel
    phi_train = phi(X_train);
end


% Kernel Perceptron Update Rule
alpha = zeros(n_train,1); % Zero initialisation

M = 0; % mistake counter to verify convergence bound

% Stopping criteria 'stop_crit'
stop_crit = 0;

% Put  100  for Dataset_1 (Both Kernels)
% Put   50  for Dataset_3 (Linear Kernel)
% Put 98.8  for Dataset_3 (Polynomial Kernel)

if dataset == 'Dataset_1_Team_18.csv'
    stop_crit = 100;
elseif dataset == 'Dataset_3_Team_18.csv'
    if d == 1
        stop_crit = 50;
    elseif d == 2
        stop_crit = 98.8;
    end
end

max_iter = 100000;
T = n_train;
for i = 1:max_iter
    for t = 1:T
        h = sign(sum(alpha.*Y_train.*K_train(:,t)));
        if (h ~= Y_train(t))
            alpha(t) = alpha(t) + 1;
            M = M+1;
        end
    end
    w = phi_train*(alpha.*Y_train); % Weights
    H_train = sign(phi_train'*w); % Prediction
    
    s = sum(H_train == Y_train)/length(H_train)*100;
    if s >= stop_crit
        break;
    end
end


% Training accuracy
trainacc = s;

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

% Test accuracy
testacc = sum(H_test == Y_test)/length(H_test)*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Theoretical Bound and Verification (Only for Dataset 1)

if dataset == 'Dataset_1_Team_18.csv'
    
    % Maximum norm of the feature vector
    r = max(vecnorm(phi_train));
    
    % Minimum distance from the boundary
    p = min((w'*phi_train).*Y_train')/norm(w);
    
    M_upper = r^2/p^2; % Theoretical upper bound
    
    if M < M_upper
        fprintf('Bound holds!')
    else
        fprintf('Bound does not hold!')
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data visualization (Training only)
syms x y;
if d == 1
    b = ' (Linear Kernel)';
    C = dot(w,[x; y; 1]);
else
    b = ' (Polynomial Kernel)';
    C = dot(w,[x^2; y^2; sqrt(2)*x*y; sqrt(2)*x; sqrt(2)*y; 1]);
end


figure (1);
gscatter(X_train(1,:),X_train(2,:),Y_train,'rb','.',15)
title(join(['Decision Boundary on Training Data',b]), 'FontSize', 20)
hold on

% Plotting Decision boundaries 
fimplicit(C == 0 ,'k', 'LineWidth',2);
legend1 = legend('Class 0','Class 1','Location','northeast');
legend1.FontSize = 14;
axis equal
axis([-1.5 1.5 -1.5 1.5])% Only for Dataset 3 
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Refer to file 'polykernel.m' for information about the function
% Refer to file 'phi.m' for information about the function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









