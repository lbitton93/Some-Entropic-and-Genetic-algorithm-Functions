classdef Dictionary
    %   ADTree
    %   A tree structure that stores and indexes information such as
    %   probability, or the conditional entropy for all configurations. We
    %   limit to k, so the ADTree is limited to depth k+1
    
    properties
        DICT  = containers.Map;
    end
    
    methods
        function obj = Dictionary(D,K,states)
            
            %   this section fills the entropies and probabilities for all
            %   Parent configurations up to k over the jth variable
            
            N = size(D,2);
            count = 0;
            run = 1;
            stop = 0;
            c = ones(1,K);
            MAX = 5*ones(1,K);
            store = zeros(1,K);
            keySet = cell(1,200000000);
           % DICT
            
            keyindex = 1;

            while run == 1
                % If the counter(i) reaches its max value, increment the adjacent state up 1
                for i = 1:K
                    if mod(c(i), MAX(i)+1) == 0
                        c(i+1) = c(i+1)+1;
                        c(i) = 1;
                    else
                        break
                    end
                end
                
                % only store non duplicate configurtions i.e 1,1,2 ommited
                if size(c,2)> size(unique(c),2)
                else
                    store=cat(1,store,c);
                    count = count + 1;
                end
                
                % loop checks if complete
                c(1) = c(1) +  1;
                if stop == 1
                    run = 0;
                end
                if isequal(c,MAX)
                    stop = 1;
                end
            end
            
            % sorts the possible combinations of variables
            % and cuts out duplicates
            sortedc = sort(store,2)
            variable = unique(sortedc,'rows')
            variable(1,:) = [];
            varsize = size(variable,1)
            zerocount = 0;
            
            for t = 1:varsize
                
                coutn =0;
                   if mod(t,100)==0
                       t
                   end
            
            % C(1,:)is our variable configs
            % Now we search through each variable state config and look in
            % the dictionary to see if a subset of it is equal to zero, i.e
            % it has a key for subset string. If so we move onto the next
            % config.
            
            
            strips(1:K,1:size(D,1)) = 0;
            MAX = states(variable(t,:));
            stop = 0;
            run = 1;
            state = ones(1,K);
            
            % loop over the specific variable configuration
            while run == 1
                
                % c is the counter over states
                for i = 1:(K-1)
                    if mod(state(i),MAX(i)+1) == 0
                        state(i+1) = state(i+1)+1;
                        state(i) = 1;
                    else
                        break
                    end
                end
                
                % now look too see if this value has been zero cached
                % by incrementing over the loop
                
                for i = 1:K
                    
                    key = zeros(1,N);
                    key(variable(t,1:i)) = state(1:i);
                    key = num2str(key);
                    % if the key is present skip to next higher state
                    if isKey(obj.DICT,key)
                        coutn =coutn+1;
                        'key is in the dictionary';
                        for j = K-i+1:K
                            if mod(state(j),MAX(j)+1) == 0
                                state(j+1) = state(j+1)+1;
                            else
                                break;
                            end
                        end
                    else
                        %'check if key has zero counts'
                        % if the key is not present, check if it has
                        % zero count.
                        for z = K-i+1:K
                            strips(z,:) = D(:,variable(t,z),state(z));
                        end
                        
                        if (sum(sum(strips) == i) == 0)
                            
                            % if zero, cache string in DICT and increment over the
                            % remaining supersets
                            %'zero count'
                            zerocount = zerocount +1;

                            keySet{keyindex} = key;
                            keyindex = keyindex+1;
                            for j = K-i+1:K
                                if mod(state(j),MAX(j)+1) == 0
                                    state(j+1) = state(j+1)+1;
                                else
                                    break;
                                end
                            end
                            break;
                        end
                        
                    end
                end
                
                
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
                     
   
            
            end
            keySet = keySet(~cellfun('isempty', keySet'));
           % 'keyset size';
            
            
            
            obj.DICT = containers.Map(keySet,1:size(keySet,2));
           % 'countin dictuionreydt'                   ;

           % obj.DICT.Count
           % size(keySet,2); 
           % zerocount      
            %r=randi([1 size(keySet,2)],1,100)
           % isKey(obj.DICT,keySet(r))
            
        end
        
        
        function [DICT] = return_dict(obj)
           DICT = obj.DICT;
        end
        

        
    end
end


