function [Entropy] = entropy_cond(parents,D,states,j)
%Local entropy
%   Calculates the local entropy of variable i when passed a matrix M and
%   the data D, a correctly ordered vector containing the number of states
%   for each variable, and j, which refers to the particular variable
%
%   Note that there is a slight positive bias in the probability, thus
%   entropy, such that log P results in defined behaviour. It may be worth
%   experimenting with this.
%
global Dictor

%Dictor.Count
numnodes = size(parents,2) + 1;

if numnodes == 1
    Entropy = 0;
else
    % find the parents of node j and put them in an array
    % make a node array including the node j, also a node of their associated
    % number of states MAX. c is a counter array
    Nodes =[j,parents];
    MAX = [states(j),states(parents)];
    c = ones(1,numnodes);
    
    Size = size(D,1);
    stop = 0;
    run = 1;
    H_all = 0;
    H_minus = 0;
    
    while run == 1
        % c is the counter over states
        for i = 1:(numnodes-1)
            if mod(c(i),MAX(i)+1) == 0
                c(i+1) = c(i+1)+1;
                c(i) = 1;
            else
                break
            end
        end
        
        keypar = zeros(1,size(D,2));
        keypar(parents(:)) = c(2:numnodes);
        keypar = num2str(keypar);
        key = zeros(1,size(D,2));
        key(Nodes(:)) = c(:);
        key = num2str(key);
        
        % create array of string keys here then test if the aboot
        if isKey(Dictor,keypar)
            if isKey(Dictor,key)
                %' zero keyd in dictionary'
                % ^^^ here put a check to see if this config is equal to zero with
                % dictionary. if so step over the corresponding counts
            else
                strips = zeros(numnodes,Size);
                for z = 1:numnodes
                    strips(z,:) = D(:,Nodes(z),c(z));
                end
                p1 = (1 + sum(sum(strips) == numnodes))./Size;
                H_all = H_all + (p1).*log2(p1);
            end
            
        else
            %  'entrop calculated'
            % iterate over the data set summing how frequently all the variables co
            % occur given a particular state configuration and use this to
            % calculate their probability P.
            %'calculared'
            %strips(1:numnodes,1:Size) = 0;
            if isKey(Dictor,key)
                %' zero keyd in dictionary'
                % ^^^ here put a check to see if this config is equal to zero with
                % dictionary. if so step over the corresponding counts
            else
                strips = zeros(numnodes,Size);
                for z = 1:numnodes
                    strips(z,:) = D(:,Nodes(z),c(z));
                end
                p1 = (1 + sum(sum(strips) == numnodes))./Size;
                H_all = H_all + (p1).*log2(p1);
            end
            strips2 = zeros(numnodes-1,Size);
            
            for z = 2:numnodes
                strips2(z,:) = D(:,parents(z-1),c(z));
            end
            
            p2 = (1 + sum(sum(strips2) == numnodes - 1))./Size;
            H_minus = H_minus + (p2).*log2(p2);
            
        end
        c(1) = c(1) +  1;
        if stop == 1
            run = 0;
        end
        if isequal(c,MAX)
            stop = 1;
        end
        
        Entropy = H_all - H_minus;
        
    end
end
end
