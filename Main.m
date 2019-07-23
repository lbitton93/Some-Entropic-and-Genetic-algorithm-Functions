      
missingdata = zeros(1,23)
datanumstates = [2,6,4,10,2,9,4,3,2,12,2,7,4,4,9,9,2,4,3,8,9,6,7]; % check this corrsponds to datastates
datastates =['e' 'p' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'b' 'c' 'x' 'f' 'k' 's' ' ' ' ' ' ' ' ' ' ' ' ';
    'f' 'g' 'y' 's' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'n' 'b' 'c' 'g' 'r' 'p' 'u' 'e' 'w' 'y' ' ' ' ';
    't' 'f' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'a' 'l' 'c' 'y' 'f' 'm' 'n' 'p' 's' ' ' ' ' ' ';
    'a' 'd' 'f' 'n' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'c' 'w' 'd' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'b' 'n' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'k' 'n' 'b' 'h' 'g' 'r' 'o' 'p' 'u' 'e' 'w' 'y';
    'e' 't' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'b' 'c' 'u' 'e' 'z' 'r' '?' ' ' ' ' ' ' ' ' ' ';
    'f' 'y' 'k' 's' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'f' 'y' 'k' 's' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'n' 'b' 'c' 'g' 'o' 'p' 'e' 'w' 'y' ' ' ' ' ' ';
    'n' 'b' 'c' 'g' 'o' 'p' 'e' 'w' 'y' ' ' ' ' ' ';
    'p' 'u' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'n' 'o' 'w' 'y' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'n' 'o' 't' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ';
    'c' 'e' 'f' 'l' 'n' 'p' 's' 'z' ' ' ' ' ' ' ' ';
    'k' 'n' 'b' 'h' 'r' 'o' 'u' 'w' 'y' ' ' ' ' ' ';
    'a' 'c' 'n' 's' 'v' 'y' ' ' ' ' ' ' ' ' ' ' ' ';
    'g' 'l' 'm' 'p' 'u' 'w' 'd' ' ' ' ' ' ' ' ' ' ';]

vartop = 23;
num_nodes = vartop;
Dtop = 8124;
mush = char(vartop,Dtop);
datavectors = zeros(Dtop,vartop,10);

mushroom = readtable('agaricus-lepiota.csv','Delimiter',',','ReadVariableNames',false,'TextType','char');

musharraycell = table2array(mushroom);
for i = 1:Dtop
    for j = 1:vartop
        mush(i,j) = musharraycell{i,j};
    end
end


for i = 1:Dtop
    for j = 1:vartop
        for k = 1:datanumstates(j)
            if isequal(mush(i,j),datastates(j,k))
                datavectors(i,j,k) = 1;
            end
        end
    end
end


straight = linspace(1,num_nodes,num_nodes);
order = straight;
order([1 12]) = order( [12 1]);
order
MI_JOINT = MI(datavectors,datanumstates,0.05,0)

k = 3;

% tic
% D = Dictionary2(datavectors,5,datanumstates)
%
% Dictor4 = D.return_dict
% save('dictionary4', 'Dictor4')
% toc


global MIT4;
global Dictor4;
load('MIT4dict','MIT4')
load('dictionary4.mat','Dictor4')
order_named={'toxicity','cap-shape','cap-surface','cap-color','bruises?','odour','gill-attachment','gill-spacing','gill-size','gill-color','stalk-shape','stalk-root','stalk surface above ring','stalk surface below ring','stalk colour above ring','stalk colour below ring','veil-type','veil-color','ring-number','ring-type','spore-p-color','population','habitat'}

tournament_size = 6;

mutaratetop = [0.3 0.005];
mutarateconst = [tournament_size*8.3e-5 tournament_size*5e-4];
N = 23;

% HERE IS A GENERATION, PARENTS RANDOMLY GENNED, CHILDREN BRED
poolsiz = 256;

%   initialise genepool
numpools = 1;

% 'gene pool initialised'
eras = [20000];
winners = zeros(2,eras(1),numpools);
GP2 = genepool(0,MI_JOINT,k);

top = 1;
divisor = 50;
score = zeros(top,eras(1)/divisor);

counta = 1;
dagstore(1) = DAG();
dagstore(2) = DAG();
dagstore(3) = DAG();
dagstore(4) = DAG();
dagstore(5) = DAG();
dagstore(6) = DAG();
dagstore(7) = DAG();
dagstore(8) = DAG();
dagstore(9) = DAG();
dagstore(10) = DAG();
for sim= 1:top
    GP(1) = genepool(poolsiz,MI_JOINT,k);
    %mstcount = mststep*10-10;
    mstcount = 50;
    for i = 1:mstcount
    %    GP(1).pool(i).replace(MST_draft(MI_JOINT,gen_rand_order(N),order_named));
    end
    
    
    for j = 1:numpools
        avg=0;
        for t = 1:eras(1)
            
            mutarate = mutaratetop(1)*exp(-mutarateconst(1)*t);
            sorted = tournament(GP(j).pool,tournament_size,datavectors,datanumstates);
            winners(:,t,sim) = sorted(:,tournament_size);
            GP(1).pool = breed(GP(j).pool,sorted,mutarate,'UAG');
                      
            %avg = avg + winners(1,t,j);
            drawnow
            drawgraph(GP(j).pool,order_named,winners(2,t,j))
            if mod(t,divisor)==0
                
                %score(mststep,t/divisor) = avg/divisor+score(mststep,t/divisor);
                avg = 0;
                t

            
            %surf(score)  
                mutarate;
                
                 winners(1,t,sim)
                              
            end
            selecta = randperm(size(GP(j).pool,1));
            
             if t == eras(1)
                 GP2.merge(GP(j))
                 dagstore(sim) = GP(j).pool(winners(2,eras(1),sim));
            end
            counta= counta+1;
        end
        
    end
end
dagadd = zeros(23)
for i = 1:top 
    dagadd = dagadd + (dagstore(i).dag);
end


'EREHJRERE'

winners2 = zeros(2,sum(eras)+1);

% for t = 1:eras(2)
%     mutarate = mutaratetop(2)*exp(-mutarateconst(2)*t);
%     sorted = tournament(GP2.pool,tournament_size,datavectors,datanumstates);
%     winners2(:,t+eras(1)) = sorted(:,tournament_size);
%     GP2.pool = breed(GP2.pool,sorted,mutarate,'UAG');
%     
%     if mod(t,100)==0
%         t
%         mutarate
%         [t winners2(1,t+eras(1))]
%         drawgraph(GP2.pool,order_named,winners2(2,t+eras(1)))
%     end
% end




