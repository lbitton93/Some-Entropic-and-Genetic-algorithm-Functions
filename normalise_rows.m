function [Anorm] = normalise_rows(A)
%   Normalizes matrix A along it's rows. Useful for Probabilistic Markov Chains

N = size(A,1);
sumeri= size(N);

for i = 1:N
       rowsum = sum(A(i,:));
    if rowsum
       sumeri(i) = rowsum;
    else  
       sumeri(i) = 1;
    end
end

Anorm = A./sumeri';
