function [children] = order_crossover(ParA,ParB,seq,type)
% Crossover function for two parents of the same size
%   
% format( parent array 1 , parent array 2, sequence  swap size, string
% crossover type)
% crossover types: Ox1,

Size = size(ParA,2);
OA = zeros(1,Size);
OB = zeros(1,Size);

   switch(type)
   case {'Ox1' , 'OX1' , 'ox1'}
     % fprintf('Crossover operator =  Ox1\n' );
      x1 = ceil(Size*rand);
     % x1 = 23
      x2 = mod(x1+seq-1,Size) + 1;
      
      if x2 < x1
          x = [x1+1:Size,1:x2];
      else
          x = x1+1:x2;
      end
      
      OA(x)= ParA(x);
      OB(x)= ParB(x);
      %for OA
      loop = 1;
      j = x2+1;
      i = x2+1;
      i = mod(i-1,Size)+1 ;
      j = mod(j-1,Size) + 1;
      while(loop)
          if j == mod(x1,Size) + 1
              break;
          end
            if ~ismember(ParB(i),ParA(x))
                OA(j) = ParB(i);
                j = j + 1;
                j = mod(j-1,Size) + 1;
            end
            i = i +1;
            i = mod(i-1,Size)+1 ;              
      end
      
      %now for OB
      loop = 1;
      j = x2+1;
      i = x2+1;
      i = mod(i-1,Size)+1 ;
      j = mod(j-1,Size) + 1;
      while(loop)
          if j == mod(x1,Size) + 1
              break;
          end
            if ~ismember(ParA(i),ParB(x))
                OB(j) = ParA(i);
                j = j + 1;
                j = mod(j-1,Size) + 1;
            end
            i = i +1;
            i = mod(i-1,Size)+1 ;              
      end            


      
   case 'B' 
      fprintf('B\n' );
   otherwise
      fprintf('Invalid crossover type\n' );
   end

children = vertcat(OA,OB);
end

