T_raw = readtable('Dataset_2_Team_12.csv');
T_raw.Properties.VariableNames{1} = 'x_1';

T = T_raw(901:4500,:);

%defining tables for each class
T_0 = T(T.Class_label == 0,1:2);
T_1 = T(T.Class_label == 1,1:2);
T_2 = T(T.Class_label == 2,1:2);

%calculation of priors
P_0 = height(T_0)/(height(T_0) + height(T_1) + height(T_2));
P_1 = height(T_1)/(height(T_0) + height(T_1) + height(T_2));
P_2 = height(T_2)/(height(T_0) + height(T_1) + height(T_2));

%calculation of mean vectors for each class
vmean_0 = [mean(T_0.x_1); mean(T_0.x_2)];
vmean_1 = [mean(T_1.x_1); mean(T_1.x_2)];
vmean_2 = [mean(T_2.x_1); mean(T_2.x_2)];

%calculation of covariance matrices different for each class 
C_0 = cov(T_0.x_1,T_0.x_2);
C_1 = cov(T_1.x_1,T_1.x_2);
C_2 = cov(T_2.x_1,T_2.x_2);


%covariance matrix same for all classes
C_same = P_0*C_0 + P_1*C_1 + P_2*C_2;









