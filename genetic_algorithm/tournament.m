function [sortedm8] = tournament(GP1,tournament_size,datavectors,datanumstates)
% GA tournament
%   returns the winners
        p = randperm(size(GP1,2),tournament_size);
        tournament_scores = zeros(2,tournament_size);
        
        for n = 1:tournament_size    
            tournament_scores(1,n) = AIC_score(GP1(p(n)).dag,datavectors,datanumstates);
            tournament_scores(2,n) = p(n) ;
        end

        sortedm8 = sortrows(tournament_scores',1)'; 
       
end

