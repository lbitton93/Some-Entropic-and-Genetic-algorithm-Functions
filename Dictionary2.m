classdef Dictionary2
    %   ADTree
    %   A tree structure that stores and indexes information such as
    %   probability, or the conditional entropy for all configurations. We
    %   limit to k, so the ADTree is limited to depth k+1
    
    properties
        DICT  = containers.Map;
    end
    
    methods
        function obj = Dictionary2(D,KTOP,states)
            
            %   this section fills the entropies and probabilities for all
            %   Parent configurations up to k over the jth variable
            tcount = 1;
            keys = cell(1,100000000);
            values = zeros(1,100000000);
            
            for K = 1:KTOP
                
                count = 0;
                run = 1;
                stop = 0;
                c = linspace(1,K,K);
                MAX = 23*ones(1,K);
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

                variable(1,:) = [];
                variable
                varsize = size(variable,1)
                
                
                %--------------------------------------------------------------
                
                for t = 1:varsize
                    if mod(t,100)==0
                    t
                    end
                    % C(1,:)is our variable configs
                    % Now we search through each variable state config and look in
                    % the dictionary to see if a subset of it is equal to zero, i.e
                    % it has a key for subset string. If so we move onto the next
                    % config.
                    
                    
                    MAX = states(variable(t,:));
                    stop = 0;
                    run = 1;
                    state = ones(1,K);
                    H_all = 0;
                    % loop over the specific variable configuration
                    while run == 1
                        % c is the counter over states
                        for i = 1:K
                            if mod(state(i),MAX(i)+1) == 0
                                state(i+1) = state(i+1)+1;
                                state(i) = 1;
                            else
                                break
                            end
                        end
                        % now find counts and put in strips
                        strips = zeros(K,size(D,1));
                        for z = 1:K
                            strips(z,:) = D(:,variable(t,z),state(z));
                        end
                        %sum(sum(strips) == size(c,2));
                        p1 = (1 + sum(sum(strips) == size(c,2)))/size(D,1);
                        H_all = H_all + (p1).*log2(p1);
                                               
                        % step up to next variable set
                        state(1) = state(1) +  1;
                        % stop condition
                        if stop == 1
                            run = 0;
                        end
                        if isequal(state,MAX)
                            stop = 1;
                        end
                    end


                                       
                    key = variable(t,:) ;
                    key = num2str(key);
                    key = regexprep(key,' +',' ');
                    
                    keys{tcount} = key;
                    values(tcount) = H_all;
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


