function [GP1] = breed(GP1,sortedm8,mutarate,priority)
% Breeding
%
winr1 = sortedm8(2,size(sortedm8,2));
winr2 = sortedm8(2,size(sortedm8,2)-1);
switch(priority)
    case {'DAG' , 'dag', 'Dag'}
        O = order_crossover(GP1(winr1).order,GP1(winr2).order,11,'ox1');
        GENES = structure_crossover(GP1(winr1).dag,GP1(winr2).dag,'uniform',O,priority);

    case {'Uag' , 'UAG', 'uag'}
        O = order_crossover(GP1(winr1).order,GP1(winr2).order,11,'ox1');
        GENES = structure_crossover(GP1(winr1).uag,GP1(winr2).uag,'uniform',O,priority);

    otherwise
end
% replace parents with offspring
GP1(sortedm8(2,1)).birth(GENES(:,:,1),O(1,:),mutarate);

if rand<mutarate
GP1(sortedm8(2,2)).scramble(GP1(winr1).density)
end
end

