function [MDL] = MDL_score(M,datavectors,datanumstates)
Entropy = 0;
for j = 1:size(datavectors,2)
    parents = find(M(:,j))';
    Entropy = Entropy + entropy_cond3(parents,datavectors,datanumstates,j);  
end
LL = -size(datavectors,1)*Entropy;
MDL = LL - 0.5*log2(size(datavectors,1))*complexity(M,datanumstates);

end
