function lightlabels(varargin)

ax=gca;
ax.YColor = 'y';
ax.XColor = 'y';
ax.GridColor = 'w';
ax.GridAlpha = .75;
ax = findall(gcf(),'Type','axes');
set(get(ax(1),'XLabel'),'Color','y')
set(get(ax(1),'YLabel'),'Color','y')
set(get(ax(1),'Title'),'Color','y')

klines=findobj(gca,'Type','Line','-not','Tag','StemLines');
for i=1:length(klines)
   klines(i).Color = 1-klines(i).Color; % invert
end
if(size(varargin)~=0)
    legend(flipud(klines(2:end)),varargin(1,:),'TextColor','y','EdgeColor','y')
end

grid on
end

