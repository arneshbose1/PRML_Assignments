function p = phi(X)
    % X needs to be of dim (d * n), where d is the feature dimension
    m = size(X,2);
    p = [X(1,:).*X(1,:);
         X(2,:).*X(2,:);
         sqrt(2)*X(1,:).*X(2,:);
         sqrt(2)*X(1,:);
         sqrt(2)*X(2,:);
         ones(1,m)];
end