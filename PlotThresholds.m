function [] = PlotThresholds(ai_distributions, alpha)

% Compute thresholds
for i = 1:5
    
    anomalyThreshold(i) = quantile(ai_distributions(i,:), alpha);
    
end

for j = 1:5
    
    figure();
    graph = sort(ai_distributions(j,:));
    bar(graph);
    hold on
    info = ['Anomaly scores for time Series X(', num2str(j), ')'];
    title(info);
    xl = yline(anomalyThreshold(j),'--r',{'Anomaly','Threshold'},'LineWidth',1);
    xl.LabelVerticalAlignment = 'middle';
    xl.LabelHorizontalAlignment = 'center';
    hold off
    
end



end