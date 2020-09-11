function [aw1,aw2,aw3,aw4,aw5] = AnomalyDetection(anomalyThreshold, ai_distributions, windowLength)

aw1 = [];
aw2 = [];
aw3 = [];
aw4 = [];
aw5 = [];

% Get the number of divergences
[~, NumberOfDivergences] = size(ai_distributions);

loopEnd = NumberOfDivergences;
counter = 0;

%% Compare thresholds with KL-Divergences of windows
for i = 1:loopEnd

if ai_distributions(1,i) > anomalyThreshold(1)
   info = ['Anomaly detected in X(1), days: ',num2str(i),' - ', num2str(windowLength+counter)];
   disp(info);
   aw1 = [aw1 i (windowLength+counter)];
end
if ai_distributions(2,i) > anomalyThreshold(2)
   info = ['Anomaly detected in X(2), days: ',num2str(i),' - ', num2str(windowLength+counter)];
   disp(info);
   aw2 = [aw2 i (windowLength+counter)];
end
if ai_distributions(3,i) > anomalyThreshold(3)
   info = ['Anomaly detected in X(3), days: ',num2str(i),' - ', num2str(windowLength+counter)];
   disp(info);
   aw3 = [aw3 i (windowLength+counter)];
end
if ai_distributions(4,i) > anomalyThreshold(4)
   info = ['Anomaly detected in X(4), days: ',num2str(i),' - ', num2str(windowLength+counter)];
   disp(info);
   aw4 = [aw4 i (windowLength+counter)];
end
if ai_distributions(5,i) > anomalyThreshold(5)
   info = ['Anomaly detected in X(5), days: ',num2str(i),' - ', num2str(windowLength+counter)];
   disp(info);
   aw5 = [aw5 i (windowLength+counter)];
end
  
    counter = counter + 1;
end    


end