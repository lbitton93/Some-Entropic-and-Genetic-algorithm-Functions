function [C] = uag_crossover(A,B,mode)
%Genetic crossover of the adjacency matrices A and B
%   mode defines the crossover type { uniform , 2pt}
Size = size(A,2);
C = zeros(Size,Size,2);
C1 = zeros(Size);
C2 = zeros(Size);

switch(mode)
   case {'Uniform' , 'uniform' , 'U' , 'u'}
      
       for i = 1:Size
           for j = i+1:Size
               if rand < 0.5
                   C1(i,j) = A(i,j);
                   C2(i,j) = B(i,j);
               else
                   C1(i,j) = B(i,j);
                   C2(i,j) = A(i,j);
               end
           end
       end
       
    %  fprintf('Crossover operator =  uniform\n' );
      
      C(:,:,1) = C1;
      C(:,:,2) = C2;
   case {'2pt'} 
      fprintf('B\n' );
   otherwise
      fprintf('Invalid crossover mode\n' );
end
   

end

