% generating the data points
mew1=[0 0 0]';
mew2=[1 5 -3]';
mew3=mew1;
sigma1=diag([3 5 2]);
sigma2=[1 0 0; 0 4 1; 0 1 6];
sigma3=diag([10 10 10]);
D1=(mvnrnd(mew1,sigma1,20))';
D2=(mvnrnd(mew2,sigma2,20))';
D3=(mvnrnd(mew3,sigma3,20))';
D=[D1 D2 D3];

%estimating mean and variances from the data
mew_1=mean(D1,2);
mew_2=mean(D2,2);
mew_3=mean(D3,2);
mew=mean(D,2);

D_1=D1-mew_1;
D_2=D2-mew_2;
D_3=D3-mew_3;
D_=D-mew;

sigma_1=(D_1*D_1')/20;
sigma_2=(D_2*D_2')/20;
sigma_3=(D_3*D_3')/20;
sigma_=(D_*D_')/60;

%finding test erroe as a function fo alpha

a=0:0.01:1;
train_error=zeros(1,101);
c=1;
for i=a
    sigma_1_a=((1-i)*20*sigma_1+i*60*sigma_)/((1-i)*20+60*i);
    sigma_2_a=((1-i)*20*sigma_2+i*60*sigma_)/((1-i)*20+60*i);
    sigma_3_a=((1-i)*20*sigma_3+i*60*sigma_)/((1-i)*20+60*i);
    
    inc=0;
    
    for j=1:20
        s=D_1(:,j);
        class1=exp(-((s'/sigma_1_a)*s)/2)/sqrt(abs(det(sigma_1_a)));
        class2=exp(-((s'/sigma_2_a)*s)/2)/sqrt(abs(det(sigma_2_a)));
        class3=exp(-((s'/sigma_3_a)*s)/2)/sqrt(abs(det(sigma_3_a)));
        
        if(class2>class1 || class3>class1)
            inc=inc+1;
        end
    end
    
    for j=1:20
        s=D_2(:,j);
        class1=exp(-((s'/sigma_1_a)*s)/2)/sqrt(abs(det(sigma_1_a)));
        class2=exp(-((s'/sigma_2_a)*s)/2)/sqrt(abs(det(sigma_2_a)));
        class3=exp(-((s'/sigma_3_a)*s)/2)/sqrt(abs(det(sigma_3_a)));
        
        if(class1>class2 || class3>class2)
            inc=inc+1;
        end
    end
    
    for j=1:20
        s=D_3(:,j);
        class1=exp(-((s'/sigma_1_a)*s)/2)/sqrt(abs(det(sigma_1_a)));
        class2=exp(-((s'/sigma_2_a)*s)/2)/sqrt(abs(det(sigma_2_a)));
        class3=exp(-((s'/sigma_3_a)*s)/2)/sqrt(abs(det(sigma_3_a)));
        
        if(class2>class3 || class1>class3)
            inc=inc+1;
        end
    end
    error=inc/60*100;
    train_error(1,c)=error;
    c=c+1;
end

%test error 
D1_test=(mvnrnd(mew1,sigma1,50))';
D2_test=(mvnrnd(mew2,sigma2,50))';
D3_test=(mvnrnd(mew3,sigma3,50))';

D_1_test=D1_test-mew_1;
D_2_test=D2_test-mew_2;
D_3_test=D3_test-mew_3;

test_error=zeros(1,101);
c=1;
for i=a
    sigma_1_a=((1-i)*50*sigma_1+i*150*sigma_)/((1-i)*50+150*i);
    sigma_2_a=((1-i)*50*sigma_2+i*150*sigma_)/((1-i)*50+150*i);
    sigma_3_a=((1-i)*50*sigma_3+i*150*sigma_)/((1-i)*50+150*i);
    
    inc=0;
    
    for j=1:50
        s=D_1_test(:,j);
        class1=exp(-((s'/sigma_1_a)*s)/2)/sqrt(abs(det(sigma_1_a)));
        class2=exp(-((s'/sigma_2_a)*s)/2)/sqrt(abs(det(sigma_2_a)));
        class3=exp(-((s'/sigma_3_a)*s)/2)/sqrt(abs(det(sigma_3_a)));
        
        if(class2>class1 || class3>class1)
            inc=inc+1;
        end
    end
    
    for j=1:50
        s=D_2_test(:,j);
        class1=exp(-((s'/sigma_1_a)*s)/2)/sqrt(abs(det(sigma_1_a)));
        class2=exp(-((s'/sigma_2_a)*s)/2)/sqrt(abs(det(sigma_2_a)));
        class3=exp(-((s'/sigma_3_a)*s)/2)/sqrt(abs(det(sigma_3_a)));
        
        if(class1>class2 || class3>class2)
            inc=inc+1;
        end
    end
    
    for j=1:50
        s=D_3_test(:,j);
        class1=exp(-((s'/sigma_1_a)*s)/2)/sqrt(abs(det(sigma_1_a)));
        class2=exp(-((s'/sigma_2_a)*s)/2)/sqrt(abs(det(sigma_2_a)));
        class3=exp(-((s'/sigma_3_a)*s)/2)/sqrt(abs(det(sigma_3_a)));
        
        if(class2>class3 || class1>class3)
            inc=inc+1;
        end
    end
    error=inc/150*100;
    test_error(1,c)=error;
    c=c+1;
end
