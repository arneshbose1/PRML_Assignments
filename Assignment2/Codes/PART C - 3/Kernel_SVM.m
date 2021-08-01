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

X_train = [R_train(:,1:2)]; % Input Matrix
Y_train = R_train(:,3); % Class Label Vector -1,1

n_train = length(Y_train);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test Data 'R_test'

R_test = R(round(perc*m)+1:m,:);

X_test = [R_test(:,1:2)]; % Input Matrix
Y_test = R_test(:,3); % Class Label Vector -1,1

n_test = length(Y_test);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function that trains an SVM Classifier
type = 'Polynomial'; % Enter 'Linear' or 'Polynomial'
cl = fitcsvm(X_train,Y_train,'KernelFunction',type,'BoxConstraint',Inf);

% Prediction on Training Data 'H_train'
H_train = predict(cl,X_train);

% Training accuracy
trainacc = sum(H_train == Y_train)/n_train*100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prediction on Test Data 'H_test'
H_test = predict(cl,X_test);

% Test accuracy
testacc = sum(H_test == Y_test)/n_test*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data visualization (Training only)

% Predict scores over the grid
d = 0.2;
[x1Grid,x2Grid] = meshgrid(min(X_train(:,1)):d:max(X_train(:,1)),...
    min(X_train(:,2)):d:max(X_train(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
[~,scores] = predict(cl,xGrid);

% Plot the data and the decision boundary
figure(2);

h(1:2) = gscatter(X_train(:,1),X_train(:,2),Y_train,'rb','.');
title(join(['Decision Boundary on Training Data',' (',type,' Kernel)']),...
    'FontSize', 20)
hold on
ezpolar(@(x)1);
h(3) = plot(X_train(cl.IsSupportVector,1),...
    X_train(cl.IsSupportVector,2),'ko');
contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
legend(h,{'Class 0','Class 1','Support Vectors'},'Location','northeast');
axis equal
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Refer to file 'polykernel.m' for information about the function
% Refer to file 'phi.m' for information about the function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









