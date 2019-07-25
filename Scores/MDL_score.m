function [SCORE] = MDL_score(M,datavectors,datanumstates)
% A function to calculate the Minimum Description Length score
% M is our graph's adjacency matrix
% datavectors is 
% datanumstates is

Entropy = 0;
for j = 1:size(datavectors,2)
    parents = find(M(:,j))';
    Entropy = Entropy + entropy_cond3(parents,datavectors,datanumstates,j);  
end
LL = -size(datavectors,1)*Entropy;
SCORE = LL - 0.5*log2(size(datavectors,1))*complexity(M,datanumstates);

end
