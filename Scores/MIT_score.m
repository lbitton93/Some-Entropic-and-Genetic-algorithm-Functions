function [MIT] = MIT_score(M,datavectors,datanumstates)
% The total MIT score is composed as the sum of it's local scores
MIT = 0;
for j = 1:size(datavectors,2)
    parents = find(M(:,j))'; 
    MIT = MIT + MIT_local(parents,j);  
end


end
