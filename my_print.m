% Function to print a pdf, eps and tiff file of the current figure
function my_print(print_file_name)

figure_dimensions = get(gcf, 'Position');
figure_height = figure_dimensions(4);
figure_width = figure_dimensions(3);

aux = get(gca,'TightInset');
% set(gca,'Position',[aux(1),aux(2),1-aux(1)-aux(3),1-aux(2)-aux(4)]);
% set(gcf, 'PaperOrientation', 'landscape')
set(gcf,'PaperPositionMode','manual');
set(gcf, 'PaperUnits', 'points');
set(gcf, 'PaperSize', [figure_width,figure_height]);
set(gcf, 'PaperPosition', [0,0, figure_width,figure_height]);
print ('-dpdf',  strcat(print_file_name,'.pdf'))
% print ('-depsc2', strcat(print_file_name,'.eps'))
% print ('-dtiff',  strcat(print_file_name,'.tiff'))

set(gcf, 'PaperUnits', 'normalized');