A=rand(100);

for i=1:100
    A(:,i)=A(:,i)+0.1*randn(100,1);
end

for i=i:100
    s=A(:,i);
    mi=min(s);
    ma=max(s);
    s=((s-mi)/(ma-mi)*0.9998)+0.0001;
    A(:,i)=s;
end

Frob_A=norm(A,'fro');
[U,S1] = eig(A*A');
[V,S2] = eig(A'*A);
S=sqrt(S1);

%calculating the frobenius norm for top 10 singular values
A_10=U(:,1:10)*S(1:10,1:10)*(V(:,1:10))';
Frob_A_10=norm(A_10,'fro');
Percent_10=Frob_A_10/Frob_A*100;

%calculating the frobenius norm for random 10 singular values
U_r=zeros(100,100);
V_r=zeros(100,100);
S_r=zeros(100,100);
a=randperm(100,10);
for i=1:10
    U_r(:,i)=U(:,a(i));
    V_r(:,i)=V(:,a(i));
    S_r(i,i)=S(a(i),a(i));
end
A_10_rand=U_r*S_r*V_r';
Frob_A_10_rand=norm(A_10_rand,'fro');
Percent_10_rand=Frob_A_10_rand/Frob_A*100;

%Plotting a graph 
P=zeros(1,100);
for i=1:100
    A_i=U(:,1:i)*S(1:i,1:i)*(V(:,1:i))';
    Frob_A_i=norm(A_i,'fro');
    P(1,i)=Frob_A_i/Frob_A*100;
end

sv=1:100;
xx = 0:0.01:100;
yy = spline(sv,P,xx);
plot(xx,yy,'LineWidth',2);
title('Singular vectors versus percentage of data capture','FontSize',20);
xlabel('No. of singular vectors','FontSize',20) ;
ylabel('Percentage of data capture','FontSize',20);