imagesc(dagadd)
 set(gcf, 'PaperUnits', 'points');
 x_width=600 ;y_width=600
 set(gcf, 'PaperPosition', [0 0 x_width y_width]); %
 saveas(gcf,'DagaddAIC3.eps','epsc')
