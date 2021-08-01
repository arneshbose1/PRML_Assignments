RGB = imread('12.jpg');     %Importing colored image
I = rgb2gray(RGB);          %converting to grayscale
X_raw = double(I);

%defining variables
[N,D] = size(I);
f = 0.1;
M = f*N;

%calculating mean of rows of X_raw
for i = 1:D
    Xmean(i) = mean(X_raw(:,i));
end

for i = 1:N
    XmeanM(i,:) = Xmean;
end

%centering X_raw
X = X_raw - XmeanM;

%finding eigenvectors and eigenvalues of covariance matrix
S = 1/N*X'*X;
[U,L] = eig(S);
L = real(diag(L));

%randomizing matrix U wrt eigenvalues;
U_rand = zeros(D,D);
L_rand = zeros(D,1);
t = randperm(D);
for i = 1:D
    U_rand(:,i) = U(:,t(i));
    L_rand(i) = L(t(i));
end


%calculating reconstructed image matrix
Y = zeros(D,N);
for i = 1:N
    for j = 1:M
        Y(:,i) = Y(:,i) + (X(i,:)*U(:,j))*U(:,j);
    end
end
Y = Y + XmeanM';

%reconstructed image
figure(1)
Ia = uint8(Y');
imshow(Ia);
title(['Reconstructed Image for top N = ',num2str(100*f),'%']);

%corresponding error image
figure(2)
imshow(uint8(I-Ia));
title(['Error Image for top N = ',num2str(100*f),'%']);

%reconstruction error
e0 = norm(X_raw-XmeanM , 'fro');
e = norm(Y'-X_raw , 'fro');

%quality of reconstructed image
quality = norm(Y','fro')/norm(X_raw,'fro'); 


%calculating reconstructed image matrix for random eigenvectors
Y_rand = zeros(D,N);
for i = 1:N
    for j = 1:M
        Y_rand(:,i) = Y_rand(:,i) + (X(i,:)*U_rand(:,j))*U_rand(:,j);
    end
end
Y_rand = Y_rand + XmeanM';

%random reconstructed image
figure(4)
Ia = uint8(Y_rand');
imshow(Ia);
title(['Reconstructed Image for random N = ',num2str(100*f),'%']);

%corresponding error image
figure(5)
imshow(uint8(I-Ia));
title(['Error Image for random N = ',num2str(100*f),'%']);

%quality of the random reconstructed image
quality_rand = norm(Y_rand','fro')/norm(X_raw,'fro'); 
