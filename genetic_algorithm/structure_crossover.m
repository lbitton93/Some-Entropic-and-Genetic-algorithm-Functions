function [C] = structure_crossover(A,B,mode,order,priority)
%Genetic crossover of the adjacency matrices A and B
%   mode defines the crossover type { uniform , 2pt}
Size = size(A,2);
C = zeros(Size,Size,2);
C1 = zeros(Size);
C2 = zeros(Size);
switch(priority)
    
    case {'DAG', 'dag' ,'Dag'}
        for i = 1:Size
            for j = 1:Size
                if find(order == i) < find(order == j)
  
                    if rand < 0.5                       
                        C1(i,j) = A(i,j);
                        C2(i,j) = B(i,j);                       
                    else
                        C1(i,j) = B(i,j);
                        C2(i,j) = A(i,j);
                    end
                    
%                 else
%                     if rand < 0.5                       
%                         C1(i,j) = A(j,i);
%                         C2(i,j) = B(j,i);                       
%                     else
%                         C1(i,j) = B(j,i);
%                         C2(i,j) = A(j,i);
%                     end
                    
                end
            end
        end
    case { 'Uag', 'UAG', 'uag' }
        
    otherwise
        'invalid crossover mix priority'
end

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
        

    case {'2pt'}
        fprintf('B\n' );
    otherwise
        fprintf('Invalid crossover mode\n' );
end
        C(:,:,1) = C1;
        C(:,:,2) = C2;

end

