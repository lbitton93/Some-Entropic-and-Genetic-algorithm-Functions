function [M] = edge_selecta(A,k)
%   Detailed explanation goes here
N = size(A,1);
M = zeros(N);
count = 0;
timeout =  800;

node_left = zeros(1,N)
node_ref = vertcat(linspace(2,N,N-1),zeros(1,N-1));

mainbreak = 0;
countin = 0;
countout = 0;

while mainbreak == 0
      
      node_ref(:,node_ref(2,:) == k)= []; % deletes row reference if more than k edges

      breakie = 0;
      while breakie == 0  

          
            i_choose = ceil((N-1)*rand);
            j_choose = i_choose   + ceil((N - i_choose)*rand);
            if ismember(j_choose,node_ref(1,:))
                if rand < A(i_choose,j_choose)
                    
                    % Adds an edge to our bayesian networks DAG, then deletes
                    % the entry from the selection matrix to avoid duplicate selection
                    M(i_choose,j_choose) = 1;
                    A(i_choose,j_choose) = 0;
                    
                    node_left(i_choose) = 1;
                    node_left(j_choose) = 1;
                    
                    % Acts as a counter so we can tell if a node has reached it
                    % k parent limit.
                    edge2 = find(node_ref(1,:) == j_choose);
                    node_ref(2,edge2)  =  node_ref(2,edge2) + 1;
                    
                    breakie = 1;
                                       
                end
                    if countin>timeout/20
                       breakie = 1;
                       'no solution found';
                    end  
                countin = countin + 1;
            end
            countin;
      end
      node_left;
      if sum(node_left) > 21
          mainbreak = 1;
      end
end

