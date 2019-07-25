function [genepool] = genepool(poolsize,MI_DAG,N,k)
% Create a genepool of  DAGs
% N is the number of nodes in the graph
% k is the maximum number of parents
    genepool(1:poolsize)= DAG(N,k,MI_DAG);
    for n = 1:poolsize
        genepool(n)= DAG(N,k,MI_DAG);
        genepool(n).basic_dag_generate();
    end
end

