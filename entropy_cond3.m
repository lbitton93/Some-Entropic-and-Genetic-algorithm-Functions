function [Entropy] = entropy_cond3(parents,D,states,j)
%Local entropy
%   Calculates the local entropy of variable i when passed a matrix M and
%   the data D, a correctly ordered vector containing the number of states
%   for each variable, and j, which refers to the particular variable
%
%   Note that there is a slight positive bias in the probability, thus
%   entropy, such that log P results in defined behaviour. It may be worth
%   experimenting with this.
%

global Dictor4;
if size(parents,2) == 0 
    Entropy = 0;
else
    keyall = num2str(sort([j,parents]));
    keypar = num2str(sort(parents));
    
    keyall = regexprep(keyall,' +',' ');
    keypar = regexprep(keypar,' +',' ');
    
    Dictor4(keyall);
    Dictor4(keypar);
    Entropy = Dictor4(keyall)-Dictor4(keypar);
end



end

