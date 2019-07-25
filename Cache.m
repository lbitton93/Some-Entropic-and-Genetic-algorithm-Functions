classdef Cache
    %   Cache
    %   A tree structure that stores and indexes information such as
    %   probability, or the conditional entropy for all configurations. We
    %   limit to k, so the ADTree is limited to depth k+1
    
    properties
        depth;
        Prob;
        Map;
    end
    
    methods
        function obj = Cache(D,K,states)
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
            C(1,:) =[];
           
            % this section creates array of all possible child parent
            % configurations
            clenth = size(C,1);
            Dmod = zeros(4*clenth,K);
            Dmod(1:clenth,:) = C(1:clenth,:);

            for i = 2:K
                Cmod = C;
                A = C(:,i);
                Cmod(:,i) = [];
                Dmod( (i-1)*clenth+1:i*clenth,:) = [A,Cmod];
            end

            % create cache map
            keysize = size(Dmod,1)
            keys = cell(keysize,1);
            
            % create keys
            for i = 1:keysize
                keys{i} = num2str(Dmod(i,:));
            end
            
            Score = zeros(keysize,1);
           
            tic
            for i = 1:keysize
            Score(i) = entropy_cond(Dmod(i,2:K),D,states,Dmod(i,1))
            end
            toc
            Score
            
            Map = containers.Map(keys,Score);
            
            save Map Map
            save                    
        end
            
        
        function [] = read_score(x,pi)
            
        end
        
    end    
end



