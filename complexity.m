function [C] = complexity(DAG,states)
%Complexity of a network for the scoring function
%   returns the network complexity, arguments are the DAG and the number of
%   states for each node.
Size = size(DAG,1);
C = 0 ;

for i = 1:Size
     
    A = find(DAG(:,i));
    
    states(A(:));
    numstates = states(A(:));
    numstates;
    qi = prod(numstates);
    ri = states(i);
    
    C = C + qi.*(ri-1);
    
end

end

