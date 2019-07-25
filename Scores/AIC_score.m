function [SCORE] = AIC_score(M,datavectors,datanumstates)
Entropy = 0;
for j = 1:size(datavectors,2)
    parents = find(M(:,j))';
 
    Entropy = Entropy + entropy_cond3(parents,j);
    
end
LL = -size(datavectors,1)*Entropy;
SCORE = LL - 2*complexity(M,datanumstates);

end
