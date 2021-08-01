%Plotting Gaussian pdf for Model 5

%defining x1,x2 plane and range
x1 = -700:5:300;
x2 = -300:5:300;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:),X2(:)];

%defining Gaussian pdf for each class
y_0 = mvnpdf(X,transpose(vmean_0),C_0);
q_0 = y_0*P_0
q_0 = reshape(q_0, length(x2),length(x1));

y_1 = mvnpdf(X,transpose(vmean_1),C_1);
q_1 = y_1*P_1
q_1 = reshape(q_1, length(x2),length(x1));

y_2 = mvnpdf(X,transpose(vmean_2),C_2);
q_2 = y_2*P_2
q_2 = reshape(q_2, length(x2),length(x1));

figure(1);
%plotting Gaussian pdf for each class
surf0 = surf(x1,x2,q_0);
hold on;
set(surf0,'edgecolor','red');
surf1 = surf(x1,x2,q_1);
set(surf1,'edgecolor','blue');
surf2 = surf(x1,x2,q_2);
set(surf2,'edgecolor','green');


legend1 = legend('Class 0','Class 1','Class 2');
legend1.FontSize = 14;
title('Gaussian PDFs for each class (Model 5, Dataset 2)','FontSize',20);
xlabel('Input Feature X1','FontSize',20);
ylabel('Input Feature X2','FontSize',20);
zlabel('Probability Denstiy','FontSize',20);
hold off;


syms x y;

w_0 = L(1,2)*exp(G([x;y],vmean_1,C_1,P_1)) + L(1,3)*exp(G([x;y],vmean_2,C_2,P_2));
w_1 = L(2,1)*exp(G([x;y],vmean_0,C_0,P_0)) + L(2,3)*exp(G([x;y],vmean_2,C_2,P_2));
w_2 = L(3,2)*exp(G([x;y],vmean_1,C_1,P_1)) + L(3,1)*exp(G([x;y],vmean_0,C_0,P_0));


figure(2);
%plotting Decision boundaries
fimplicit(w_0 == w_1 , 'LineWidth',2);
hold on;
fimplicit(w_1 == w_2 ,'LineWidth',2);
fimplicit(w_2 == w_0 , 'LineWidth',2);

%plotting training data on 2D
scatter(T_0.x_1,T_0.x_2,[],'b');
scatter(T_1.x_1,T_1.x_2,[],'r');
scatter(T_2.x_1,T_2.x_2,[],'g');
hold off;


legend2 = legend('Boundary 0,1','Boundary 1,2','Boundary 2,0','Class 0','Class 1','Class 2');
legend2.FontSize = 14;
set(legend2,'NumColumns',2);
title('Decision Boundaries (Model 5 , Dataset 1)','FontSize',20);
xlabel('Input Feature X1','FontSize',20);
ylabel('Input Feature X2','FontSize',20);
axis([min(x1) max(x1) min(x2) max(x2)]);


figure(3);
%plotting contour curves
contour(x1,x2,q_0,'-b');
hold on;
contour(x1,x2,q_1,'-r');
contour(x1,x2,q_2,'-g');

[V_0,D_0] = eig(C_0);
[V_1,D_1] = eig(C_1);
[V_2,D_2] = eig(C_2);

%plotting eigenvectors
e0_1 = fimplicit(y-vmean_0(2,1) == (V_0(2,1)/V_0(1,1))*(x-vmean_0(1,1)),'--b');
e0_2 = fimplicit(y-vmean_0(2,1) == (V_0(2,2)/V_0(1,2))*(x-vmean_0(1,1)),'--b');

e1_1 = fimplicit(y-vmean_1(2,1) == (V_1(2,1)/V_1(1,1))*(x-vmean_1(1,1)),'--r');
e1_2 = fimplicit(y-vmean_1(2,1) == (V_1(2,2)/V_1(1,2))*(x-vmean_1(1,1)),'--r');

e2_1 = fimplicit(y-vmean_2(2,1) == (V_2(2,1)/V_2(1,1))*(x-vmean_2(1,1)),'--g');
e2_2 = fimplicit(y-vmean_2(2,1) == (V_2(2,2)/V_2(1,2))*(x-vmean_2(1,1)),'--g');
hold off;


legend3 = legend('Class 0','Class 1','Class 2');
legend3.FontSize = 14;
set(legend3,'NumColumns',1);
title('Contour Curves and Eigenvectors (Model 5 , Dataset 2)', 'FontSize',20);
xlabel('Input Feature X1', 'FontSize',20);
ylabel('Input Feature X2', 'FontSize',20);




function G = G(x,vmean,C,P)
G = diag((-1/2)*transpose(x-vmean)*inv(C)*(x-vmean)+(-1/2)*log(det(C))+log(P))
end

