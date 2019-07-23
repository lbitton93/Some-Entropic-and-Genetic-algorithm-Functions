function [M] = MI(D,A,e,SIG)
% Mutual information function:
%
% This function calculates the mutual information of a graph G from the
% data D. It takes input MI(D,G,e,SIG). 
% 
% > G is an adjacency matrix of the edges:
% > D is a 3D data matrix:
%     - rows,  nodes
%     - columns, instances of the data
%     - depth,  unity variable state vector
% > e is the rejection value: 
%     if the MI is below this value, the potential edge is discarded
% > SIG is the symettric information gain:
%     pass a 1 or 0 value depending on wether you wish to divide the
%     mutual information by the joint entropy.

N = size(D,2);
Entries = size(D,1);
M = zeros(N);
count = 0;

for i = 1:N
    for j = (i+1):N
        count = count +1;
        
        depthi = A(i);  % number of states for variable 1
        depthj = A(j);  % number of states for variable 2
        
        
        % we introduce 1's here to allow for the log function to be
        % defined, so slight over - estimation of likelihood.
        
        pxy = ones(depthi,depthj);    % sum to count the probability of each (x,y) state
        px = ones(1,depthi);  % sum to count the probability of each x state
        py = ones(1,depthj);  % sum to count the probability of each y state
        % find MI of this edge
        for i2 = 1:depthi
            for j2 = 1:depthj

                for k = 1:Entries
                   
                    x = D(k,i,i2);
                    y = D(k,j,j2);
                    
                    if (x + y) == 2
                        px(i2) = px(i2) + 1;
                        py(j2) = py(j2) + 1; 
                        pxy(i2,j2) = pxy(i2,j2) +1;     % adds 1 to (x,y)    
                    end
                end
                
            end
        end
        

        pxy = pxy./Entries;
        py = py./Entries;
        px = px./Entries;
        HAB = 0;
        for i2 = 1:depthi
            for j2 = 1:depthj
                M(i,j) = M(i,j) +  pxy(i2,j2).*log2( pxy(i2,j2)./(px(i2).*py(j2)) );
                HAB = HAB - pxy(i2,j2).*log2( pxy(i2,j2) );
            end
        end
        
                if i==1
                j
                 M(i,j)
                HAB 
                end
        
        if SIG == 0   % if ya dont want to dive by sym ent then...
            HAB = 1;
        end
        
        if  M(i,j)>e
            M(i,j) = M(i,j)./HAB;
        else
            M(i,j) = 0;
        end
                       
    end
end
end

