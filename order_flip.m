function [M] = order_flip(A,O)
%   The master matrix A represents a template for the permitted links 
%   (post conditional indep test). Order flip rearranges A in such a
%   way that it outputs a DAG adjacency matrix displaying permitted 
%   potential edges for a given order O. flipped Acan be used to reduce
%   the sample space for DAG structure selection searches.

N = size(O,2);
M = zeros(N);

for i = 1:N
    for j = i:N
           M(i,j) =  A( O(i), O(j));   
    end
end
end

