function [Score] = MIT_local(parents,j)
%Local entropy
%   Calculates the local MIT score
%
global MIT4;


if size(parents,2) == 0 
    Score= 0;
else
    keyall = num2str([j,sort(parents)]) ; 
    keyall = regexprep(keyall,' +',' ') ;
    Score = MIT4(keyall);
end
end

