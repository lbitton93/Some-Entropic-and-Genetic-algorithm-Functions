function [] = drawgraph(GP1,order_named,winr1)
%Draws the dag
%   Detailed explanation goes here
        drawnow
        G = plot(digraph(GP1(winr1).dag));
        labelnode(G,1:size(order_named,2),order_named)
end

