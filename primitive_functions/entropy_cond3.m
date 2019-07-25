function [Entropy] = entropy_cond3(parents,j)
% Conditional entropy function which calls up from the 
% joint entropy dictionary 'Dictor4'. This needs to be 
% improved by passing the dictionary in, or at least 
% a string to its location.


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

