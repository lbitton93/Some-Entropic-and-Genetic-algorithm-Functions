function [genepool] = genepool(poolsize,MI_DAG)
% Create a genepool of Bayesian networks
%   Detailed explanation goes here
N = 23;
k = 4;
    genepool(1:poolsize)= DAG(N,k,MI_DAG);
    for n = 1:poolsize
        genepool(n)= DAG(N,k,MI_DAG);
        genepool(n).basic_dag_generate();
    end
end

