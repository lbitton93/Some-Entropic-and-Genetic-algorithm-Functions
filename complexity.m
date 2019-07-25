function [C] = complexity(DAG,datanumstates)
%Complexity of a network for the scoring function
%   returns the network complexity, arguments are the DAG and the number of
%   states for each node.
Size = size(DAG,1);
C = 0 ;

for i = 1:Size
     
    A = find(DAG(:,i));
    
    states(A(:));
    numstates = datanumstates(A(:));
    numstates;
    qi = prod(numstates);
    ri = datanumstates(i);
    
    C = C + qi.*(ri-1);
    
end

end

