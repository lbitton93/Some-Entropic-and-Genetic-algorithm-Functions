function [MST] = MST(MI,order,order_named)
%   Minimum spanning tree draft using the cheng-bell-liu algorithm
%   order = ordering of vertices
%   order_named is only neccessary if you want to plot a graph of the structure,
%   in which case uncomment the bottom bit(i know this can be done better)

[row,col] = find(MI~=0);
edges = [row,col];
value = MI(MI~=0);
total = [value,edges];
sorted = sortrows(total,1,'descend')';
edges = sorted(2:3,:);
MST = zeros(size(order,2));
% add two mos probable edges
count = 0;
while size(edges,2) > 1
    chain = 0;
    commoncause = 0;   
    MSTcopy = MST;
    n1 = edges(1,1);
    n2 = edges(2,1);
    n1o = find(order == n1);
    n2o = find(order == n2);
    
    if n2o>n1o
        first = n1; firsto = n1o;
        last = n2; lasto = n2o;
    else
        first = n2; firsto = n2o;
        last = n1; lasto = n1o;
    end
    % add the first two edges regardless
    if count<2  
       MST(first,last) = 1;
    else
        % chain structure presence test
        % --------------------------------------------------------------
        n12 = abs(n1o-n2o); % difference in node positons in order
        % create input state
        input = zeros(size(order,2),1);    
        input(first) = 1;
        % assign a loop to the copy at the second node to catch any information      
        MSTcopy(last,last) = 1;
            
        output = input'*((MSTcopy)^n12);
        if output(last) ~= 0
            'chain';
            chain = 1;
        end
        
        % common cause
        % --------------------------------------------------------------
        % assign  a loop to the first variable
        MSTcopy(first,first) = 1;
        
        for i = 1:firsto-1
            cc = firsto - i;

            ncc = cc;
            maxstep = lasto - cc;
            input = zeros(size(order,2),1);
            input(ncc) = 1;
            
            output = input'*((MSTcopy)^maxstep);
            if (output(first)>=1) && (output(last)>=1)
               'common cause' ;
               commoncause = 1;
               break;
            end
        end
    end

    if (chain + commoncause) == 0

        MST(first,last) = 1;
    end
    edges(:,1:2) = []; % deletes edge from descending set
    count = count +1;

end
        %drawnow        
        %G = plot(digraph(MST));
        %labelnode(G,1:size(order_named,2),order_named);
end

