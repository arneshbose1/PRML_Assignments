Test1 = T_raw(1:900,:);

%defining Loss Matrix
L = [0 2 1; 2 0 3; 1 3 0];

%defining x matrix from test dataset
A = [transpose(Test1.x_1) ; transpose(Test1.x_2)];
m = size(A);
n = m(1,2);

%MODEL5
S_0 = C_0;
S_1 = C_1;
S_2 = C_2;

%initialising H_t row vector
H_t = zeros([1 n]);

for i = 1:n
    
    x = A(:,i);
    
    %Deterministic functions
    G_0 = G(x,vmean_0,S_0,P_0);
    G_1 = G(x,vmean_1,S_1,P_1);
    G_2 = G(x,vmean_2,S_2,P_2);

    Q = [exp(G_0); exp(G_1); exp(G_2)];
    B = L*Q
    min_B = min(B)
    for j = 1:3
        if B(j) == min_B
            H_t(i) = j-1;
        end
    end    
   
        
        
end

H = transpose(H_t);

%true class label vector Y
Y = Test1.Class_label;

%Accuracy of prediction
ACC5_test = Acc(H,Y)

%confusion Matrix for best Model
M = zeros(4);
Mr = zeros(4);
for i = 1:length(H)
    M(H(i)+1,Y(i)+1) = M(H(i)+1,Y(i)+1)+1;
end

for i =1:3
    M(i,4) = M(i,i)/(M(i,1) + M(i,2) + M(i,3));
    M(4,i) = M(i,i)/(M(1,i) + M(2,i) + M(3,i));
end
M(4,4) = sum(diag(M));

Mr(1:3,1:3) = M(1:3,1:3)/length(H);
Mr(4,1:3) = M(4,1:3);
Mr(1:3,4) = M(1:3,4);
Mr(4,4) = M(4,4)/length(H);



%defining an accuracy function
function A = Acc(x,y)
T = 0;
F = 0;
for k = 1:length(x)
    if x(k) == y(k)
        T = T+1;
    else
        F = F+1;
    end
end
A = T/(T+F)
end


%Deterministic function
function G = G(x,vmean,C,P)
G = diag((-1/2)*transpose(x-vmean)*inv(C)*(x-vmean)+(-1/2)*log(det(C))+log(P))
end
