pounts = 10;

x = linspace(0,5,pounts);
y = linspace(0,5,pounts);


y = -5*x.^2 + 1.2*x.^3 + 6*rand(1,pounts);

p1 = polyfit(x,y,1)
p3 = polyfit(x,y,3)
p9 = polyfit(x,y,9)

x1 = linspace(0,5,200);

f1 = polyval(p9,x1);
f2 = polyval(p3,x1);
f3 = polyval(p1,x1);

figure('pos',[10 10 900 600])

scatter(x,y,400,'.','k')
hold on 
plot(x1,f1,'color','g')
hold on 
plot(x1,f2,'color','r')
hold on 
%plot(x1,f3,'color','b')
hold off
axis([0  5  -12  	15])

