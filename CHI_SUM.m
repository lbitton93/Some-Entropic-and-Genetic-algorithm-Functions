function [VAL] = CHI_PENALTY(parents,j,states,confidence)

% Calculates the maximum CHI penalty factor for the MIT score
%  Inputs (parents, child, number of states array, chi test confidence)
numnodes = size(parents,2)+1;
parents = sort(parents,'descend');
ri = 1;
BASE = states(j)-1;
DOF = 0;
v(1:numnodes-1) = 0;

% calculates degrees of freedom for each chi term
for i = 1:numnodes-1
    rik = states(parents);
    rik(i) = [];
    
    if i>1
        ri= prod(rik(1:i-1));
    end
    v(i)=BASE*(states(parents(i))-1)*ri;
    DOF = DOF + BASE*(states(parents(i))-1)*ri;    
end
% BISECTION SEARCH FOR OUR MAXIMAL CHI CONSTANT VALUES

CHI2(1:numnodes -1) = 0;
fine = 0.001;
for i = 1:numnodes-1
    step = 100; j = 0;
    while step> fine
        if chi2cdf(j,v(i))> confidence
            j = j-step;
            step = step/10;
        else
            j=j+step;
        end
    end
    CHI2(i)=j-fine;
end

VAL = sum(CHI2);

end

