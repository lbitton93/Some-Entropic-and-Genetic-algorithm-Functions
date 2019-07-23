classdef ADTree
    %   ADTree
    %   A tree structure that stores and indexes information such as
    %   probability, or the conditional entropy for all configurations. We
    %   limit to k, so the ADTree is limited to depth k+1
    
    properties
        depth;
        Prob;
    end
    
    methods
        function obj = ADTree(D,K,states)
            %   Construct an instance of this class
            %   Assigns depth and initiates storage matrices
            N = size(D,2);
            for i = 2:K+1
                obj.Prob{i} = cell(N,i,100);
            end
                     
            %   this section fills the entropies and probabilities for all
            %   Parent configurations up to k over the jth variable
            
            for j = 1:1
            
            count = 0; 
            run = 1;
            stop = 0;
            
            c = ones(1,K);
            MAX = 6.*ones(1,K);
                        
            store = zeros(1,K);
            while run == 1
                % If the counter(i) reaches its max value, increment the adjacent state up 1
                for i = 1:K
                    if mod(c(i),MAX(i)+1) == 0
                        c(i+1) = c(i+1)+1;
                        c(i) = 1;
                    else
                        break
                    end
                end
                 
                if size(c,2)> size(unique(c),2)
                else
                store=cat(1,store,c);                                              
                count = count + 1;
                end
                
                c(1) = c(1) +  1;
                if stop == 1
                    run = 0;
                end
                if isequal(c,MAX)
                    stop = 1;
                end
            end
            end
            sortedc = sort(store,2);
            C = unique(sortedc,'rows')
            C(1,:) =[]
            depth = K; j=1;
            index = 2*zeros(1,depth);
            while i <= depth
                index(i+1) = C(6,i);
                index(i) = j+1;
                i = i + 2;
                j = j + 1;
            end
            
             
            
            % create root node of ADTree
            t = tree('11')  %#ok<NOPTS>;  
            place = linspace(2,depth+1,depth) 

            out0 = [place(rem(0:numel(C(t,:))-1,numel(place))+1);C(t,:)];
            srong = num2str(out0(:)');
            
            

            srong= srong(~isspace(srong))
            
            nadd = srong
            [t nadd] = t.addnode(1, 124);
            
            disp(t.tostring)
            nnodes(t)
            
            
            
        end
            
            
        
        
        function [] = read_probabilities(x,pi)
            
        end
        
        function [] = read_cond_entropy(x,pi)
            
        end
        
    end    
end


