function [Anorm] = normalise_rows(A)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
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
