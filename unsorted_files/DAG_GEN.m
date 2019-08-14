function [dag] = DAG_GEN(K,N,O,M)

%    Generates a DAG structure over N nodes, each of which may have up to K
%    parents. An node order array O is passed to the function and permitted
%    edges are accessed from the link matrix M, which may be formed from 
%    prior conditional independence tests.

A=zeros(N);

for i = 1:N
    for j = 1:N
        if i<j
        A(i,j) = 1;
        end
    end
end

dag = inputArg2;
end

