function [MIT] = MIT_score(M,datavectors,datanumstates)
MIT = 0;
for j = 1:size(datavectors,2)
    parents = find(M(:,j))'; 
    MIT = MIT + MIT_local(parents,j);  
end


end
