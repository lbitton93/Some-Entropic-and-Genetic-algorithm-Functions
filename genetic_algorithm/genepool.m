classdef genepool < handle
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = public)
        pool = DAG();
        N;
        k;
        MI_DAG;
        poolsize
    end
    
    methods
        function obj = genepool(poolsize,MI_DAG,k)
            % Create a genepool of Bayesian networks
            %   Detailed explanation goes here
            obj.poolsize = poolsize;
            obj.k = k;
            obj.MI_DAG = MI_DAG;
            obj.pool = DAG();
            
            for i = 1:poolsize
                obj.pool(i) = DAG();
                obj.pool(i).init(23,k,MI_DAG);
                obj.pool(i).basic_dag_generate();  
            end

        end
        
        function [] = merge(obj,GP2)
            % Combine gene pools by passing in a pool
            newpool(1:obj.poolsize+size(GP2.pool,2)) = DAG();
            newpool(1:obj.poolsize) = obj.pool(1:obj.poolsize);
            for i = obj.poolsize+1:obj.poolsize+size(GP2.pool,2)
            newpool(i) = GP2.pool(i-(obj.poolsize));
            end
            obj.pool = newpool;
            'size of new genepool = '
            size(newpool,2)
            obj.poolsize=size(newpool,2);
        end
        
        
    end
end

