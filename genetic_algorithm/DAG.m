classdef DAG<handle
    %   DAG
    %   A class to generate and permute DAGs as prospective BN models
    
    properties(GetAccess = public,SetAccess = public)
        dag;
        uag;
        order;
        Size;
        max_parents;
        link_mat;
        density;
        
    end
    
    methods
        function obj = DAG()
            %   Construct an instance of this class
            %   Assigns an order and sizeobj.Size
        end
        
        function [] = init(obj,N,K,M)
            %   Construct an instance of this class
            %   Assigns an order and size
            obj.Size = N;  % N is an int for the n0 nodes
            obj.max_parents = K;  % int limit on each nodes allow n0 parents
            obj.link_mat = M; % matrix of permitted edges
        end
        
        % Generates a random valid DAG
        function [] = replace(obj,MST)
            
        obj.dag = MST;
        % cuts out parents >k cases
        DAGsumz = sum(obj.dag);
        for i = 1:obj.Size
            A = DAGsumz(i) - obj.max_parents;
            
            if A>0
                B = find(obj.dag(:,i) == 1);
                for j = 1:A
                    del = B(randi(size(B,2)));
                    obj.dag(del,i) = 0;
                    B = B(B~=del);
                end
            end
        end
        
        end
        
        % Generates random fresh basic DAG according to the order
        % not necessarily all nodes connected due to k limit
        function [] = basic_dag_generate(obj)
            
            obj.order = gen_rand_order(obj.Size);
            obj.dag = zeros(obj.Size);
            obj.uag = zeros(obj.Size);
            
            for i = 1:obj.Size - 1
                
                j = i + ceil((obj.Size - i)*rand());
                obj.uag(i,j) = 1;
                iloc = find(obj.order == i);
                jloc = find(obj.order == j);
                
                if jloc>iloc
                    if sum(obj.dag(:,j))<obj.max_parents
                        obj.dag(i,j) = 1;
                        
                    end
                else
                    if sum(obj.dag(:,i))<obj.max_parents
                        obj.dag(j,i) = 1;
                        
                    end
                end
            end
            
            obj.density = sum(obj.dag(:) == 1);
        end
        
        function [] = scramble(obj,density)
            
            obj.uag(1:obj.Size,1:obj.Size) = 0;
            obj.dag(1:obj.Size,1:obj.Size) = 0;
            obj.order = gen_rand_order(obj.Size);
            
            ri = randi([1,obj.Size],1,density);
            rj(1:density) = 0;
            for i = 1:density
                if ri(i) < obj.Size
                    rj(i) = randi([ri(i),obj.Size],1,1);
                    obj.uag(ri(i),rj(i)) = 1;
                end
            end
            
            for i = 1:obj.Size - 1
                for j = i+1:obj.Size
                    
                    if obj.uag(i,j) == 1
                        
                        iloc = find(obj.order == i);
                        jloc = find(obj.order == j);
                        
                        if jloc>iloc
                            if sum(obj.dag(:,j))<obj.max_parents
                                obj.dag(i,j) = 1;
                                
                            end
                        else
                            if sum(obj.dag(:,i))<obj.max_parents
                                obj.dag(j,i) = 1;
                                
                            end
                        end
                    end
                end
            end
        end
        
        function [] = birth(obj,UAG,ord,mutate)
            % Generates a child DAG based upon the parent inputs
            obj.order = ord;
            obj.dag = zeros(obj.Size);
            obj.uag = UAG;
            
            for i = 1:size(ord,2)
                if rand<mutate
                    SWAP = randperm(size(ord,2),2);
                    obj.order([SWAP(2),SWAP(1)]) = obj.order([SWAP(1),SWAP(2)]);
                end
            end
            
            for i = 1:obj.Size
                for j = i +1:obj.Size
                    if rand < mutate
                        obj.uag(i,j) = - floor(UAG(i,j)- 0.5);
                    end
                end
            end
            
            for i = 1:obj.Size
                for j = i+1:obj.Size
                    if UAG(i,j) == 1
                        iloc = find(obj.order == i);
                        jloc = find(obj.order == j);
                        
                        if jloc>iloc
                            obj.dag(i,j) = 1;
                        else
                            obj.dag(j,i) = 1;
                        end                       
                    end
                end              
            end
                       
            % this section cuts of in-edges if  > k
            DAGsumz = sum(obj.dag);
            for i = 1:obj.Size
                A = DAGsumz(i) - obj.max_parents;
                
                if A>0
                    B = find(obj.dag(:,i) == 1);
                    for j = 1:A
                        del = B(randi(size(B,2)));
                        obj.dag(del,i) = 0;
                        B = B(B~=del);
                    end
                end
            end
            
        end
        
      
    end
end
