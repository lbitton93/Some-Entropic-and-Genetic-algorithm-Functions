classdef MIT_CACHE
    %   ADTree
    %   A tree structure that stores and indexes information such as
    %   probability, or the conditional entropy for all configurations. We
    %   limit to k, so the ADTree is limited to depth k+1
    
    properties
        DICT  = containers.Map;
    end
    
    methods
        function obj = MIT_CACHE(D,KTOP,states)
            
            %   this section fills the entropies and probabilities for all
            %   Parent configurations up to k over the jth variable
            tcount = 1;
            keys = cell(1,100000000);
            values = zeros(1,100000000);
            
            for K = 1:KTOP-1
                
                count = 0;
                run = 1;
                stop = 0;
                c = linspace(1,K,K);
                MAX = size(D,2)*ones(1,K);
                store = zeros(1,K);
                
                %--------------------------------------------------------------
                  while run == 1                  
                    % If the counter(i) reaches its max value, increment the adjacent state up 1
                    for j = 1:K-1
                        i = K +1 - j;
                        if mod(c(i), 25-j) == 0                          
                            c(i-1) = c(i-1)+1;  
                            
                            for k = i:K
                            c(k) = c(k-1)+1;                         
                            end             
                            
                        else
                            break
                        end
                    end

                    store=cat(1,store,c);
                    count = count + 1;                   
                    % loop checks if complete
                    c(K) = c(K) +  1;
                    if c(1) == 24 - K 
                        run =0;
                    end
                end

                %--------------------------------------------------------------
                % sorts the possible combinations of variables

                if K == 1
                        store = [store',23];
                        store = store';
                end
                variable = store;
                
                variable(1,:) = []
                varsizepre = size(variable,1);
                ' size of fingg'
                
                y = 1:size(D,2);
                x = 1:varsizepre;
                [X,Y] = meshgrid(y,x);
                varsizepre*size(D,2);
                adder = reshape(X,varsizepre*size(D,2),1);
                variable = repmat(variable,size(D,2),1);
                newvariable = [adder, variable];
                variable = unique(newvariable,'rows');
                variable = unique(variable','rows')'
                
    
                
                varsize = size(variable,1)

                
                
                %--------------------------------------------------------------
                
                for t = 1:varsize
                    
                    j = variable(t,1);
                    parents = variable(t,2:K+1);
                    if mod(t,100)==0
                        t
                    toc
                    tic
                    end
                    % C(1,:)is our variable configs
                    % Now we search through each variable state config and look in
                    % the dictionary to see if a subset of it is equal to zero, i.e
                    % it has a key for subset string. If so we move onto the next
                    % config.
                                
                    MITSCORE = 2*size(D,1)*mutual_info(parents,D,states,j) -CHI_PENALTY(parents,j,states,0.999);
                                         
                    key = variable(t,:) ;
                    key = num2str(key);
                    key = regexprep(key,' +',' ');
                    
                    keys{tcount} = key;
                    values(tcount) = MITSCORE;
                    tcount = tcount + 1;
                    
                end
            end
            
            keys = keys(~cellfun('isempty', keys'));
            values = values(values~=0);
            obj.DICT = containers.Map(keys,values);
        end
        
        function [DICT] = return_dict(obj)
            DICT = obj.DICT;
        end
              
    end
end


