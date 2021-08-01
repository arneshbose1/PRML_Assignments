function K = polykernel(X,Y)
    % X is ussualy the testing matrix
    % Y is usually the training matrix
    
    m = size(X,2);
    n = size(Y,2);
    
    K = zeros(m,n);
    
    for i = 1:m
        for j = 1:n
            % Note that X and Y have a row of 1's.
            % Hence,'c = 1' is absolved in the dot product
            K(i,j) = (dot(X(:,i),Y(:,j)))^2;
        end
    end
end