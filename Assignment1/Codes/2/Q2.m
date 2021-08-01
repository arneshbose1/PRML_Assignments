hold on;
D=table2array(readtable("Dataset_3_Team_12.csv"));
mew_sample=mean(D);
D_c=D-mew_sample;
sigma=(D_c'*D_c)/1500;

%plot for different sample sizes
n=1000;
a=randperm(1500,n);
data=zeros(n,1);
for i=1:n
    data(i,1)=D(a(i),1);
end
mew_0=-1;

%for different ratios of sigmas
ratio=0.1;
sigma_square=sigma*sigma;
sigma_0_square=sigma_square/ratio;
imd=(n/sigma_square)+(1/sigma_0_square);
sigma_n=sqrt(1/imd);
imd2=(sum(data)/sigma_square)+(mew_0/sigma_0_square);
mew_n=sigma_n*sigma_n*imd2;
x = @(t) t;
y = @(t) (1/(sqrt(2*pi)*sigma_n))*exp(-0.5*((t-mew_n)/sigma_n)^2);
fplot(x,y,'LineWidth',2);

ratio=1;
sigma_square=sigma*sigma;
sigma_0_square=sigma_square/ratio;
imd=(n/sigma_square)+(1/sigma_0_square);
sigma_n=sqrt(1/imd);
imd2=(sum(data)/sigma_square)+(mew_0/sigma_0_square);
mew_n=sigma_n*sigma_n*imd2;
x = @(t) t;
y = @(t) (1/(sqrt(2*pi)*sigma_n))*exp(-0.5*((t-mew_n)/sigma_n)^2);
fplot(x,y,'LineWidth',2);

ratio=10;
sigma_square=sigma*sigma;
sigma_0_square=sigma_square/ratio;
imd=(n/sigma_square)+(1/sigma_0_square);
sigma_n=sqrt(1/imd);
imd2=(sum(data)/sigma_square)+(mew_0/sigma_0_square);
mew_n=sigma_n*sigma_n*imd2;
x = @(t) t;
y = @(t) (1/(sqrt(2*pi)*sigma_n))*exp(-0.5*((t-mew_n)/sigma_n)^2);
fplot(x,y,'LineWidth',2);

ratio=100;
sigma_square=sigma*sigma;
sigma_0_square=sigma_square/ratio;
imd=(n/sigma_square)+(1/sigma_0_square);
sigma_n=sqrt(1/imd);
imd2=(sum(data)/sigma_square)+(mew_0/sigma_0_square);
mew_n=sigma_n*sigma_n*imd2;
x = @(t) t;
y = @(t) (1/(sqrt(2*pi)*sigma_n))*exp(-0.5*((t-mew_n)/sigma_n)^2);
fplot(x,y,'LineWidth',2);

title('Plot of posterior densities for sample size of 1000','FontSize',20);
xlabel('data points','FontSize',20) ;
ylabel('Posterior probability density','FontSize',20);
legend({'ratio=0.1','ratio=1','ratio=10','ratio=100'},'FontSize',20);

