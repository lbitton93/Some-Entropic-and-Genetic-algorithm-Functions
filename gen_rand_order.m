function [rorder] = gen_rand_order(N)
% takes argument of size N
%   Detailed explanation goes here
M = linspace(1,N,N);
rorder = zeros(1,N);
for i = 1:N
    B = ceil(size(M,2)*rand);
    
    rorder(i) =  M(B);
    M(B) = [];
end
end

