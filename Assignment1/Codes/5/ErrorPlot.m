%plotting of reconstruction error
E = zeros(1,N/10);
for k = 1:N
    Y = zeros(D,N);
    for i = 1:N
        for j = 1:k
            Y(:,i) = Y(:,i) + (X(i,:)*U(:,j))*U(:,j);
        end
    end

    Y = Y + XmeanM';

    %reconstruction error
    E(k) = norm(Y'-X_raw,'fro');
    k
end

figure(6)
x = [0:1:260];
y = [e0 E];
plot(x,y,'LineWidth',2);
xlabel('Number of top principal components','FontSize',20);
ylabel('Reconstruction Error','FontSize',20);