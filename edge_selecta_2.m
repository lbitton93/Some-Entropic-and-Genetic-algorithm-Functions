function [M] = edge_selecta_2(A)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N = size(A,1);
M = zeros(N);
node_ref = vertcat(linspace(1,N,N),zeros(1,N))

node_choose_index = ceil(size(node_ref,2)*rand)
node_choose = node_ref(1,node_choose_index)

isfullyconnect = 0;
count = 0;
while isfullyconnect == 0;
      breakie = 0;
while breakie == 0
           if rand < (N-node_choose)/N   
               j_choose = ceil((N-node_choose)*rand)+node_choose
               % search horizontally
               'searching horizontally'
               if rand < A(node_choose,j_choose)
                  M(node_choose,j_choose) = 1;

                  node_ref(2,node_choose_index)  =  node_ref(2,node_choose_index) + 1; 
                  edge2 = find(node_ref(1,:)== j_choose);
                  node_ref(2,edge2)  =  node_ref(2,edge2) + 1; 
                     if (node_ref(2,edge2)>1)
                         node_ref(:,edge2)= [];
                     end                  
                  breakie = 1;
               end
           else
               if node_choose > 1
                  i_choose = ceil((node_choose-1)*rand)
                  %search vertically  
                  'searching vertically'
                  if rand < A(i_choose,node_choose)
                     M(i_choose,node_choose) = 1;
                     node_ref(2,node_choose_index)  =  node_ref(2,node_choose_index) + 1;
                     edge2 = find(node_ref(1,:)== i_choose);
                     node_ref(2,edge2)  =  node_ref(2,edge2) + 1; 
                     if (node_ref(2,edge2)>1)
                         node_ref(:,edge2)= [];
                     end
                     breakie = 1;
                  end
               end
           end
 node_ref 
 count = count +1;
 sizefa = size(find(node_ref == 0),1  )
 
 if count > (N-1)
     %isfullyconnect=1;
   if size(find(node_ref == 0),1  ) == 0 
       isfullyconnect = 1;
   end

 end
 M
end
end

