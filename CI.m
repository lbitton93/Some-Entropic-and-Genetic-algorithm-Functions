function [M] = CI(A)

    N = size(A,1);
    max_edges = (N.*(N-1))./2;
    S = zeros(3,max_edges);
    M = zeros(N);
    count = 1;
    
    
    
    
    
    for i = 1:N
        for j = i:N
            S(1,count) = M(i,j);
            S(2,count) = i;
            S(3,count) = j;
            count = count +1;
        end
    end
    
    S(:,S(1,:) == 0) = [];
    S = sortrows(S',1, 'ascend');
    S = S'
    
end
