function [anomalyThreshold, ai_distributions] = AnomalyThreshold(windowLength, stepSize, timeSeries_2017, timeSeries_2018, p, Lag, Lambda, Epsilon, delta, alpha)
%% Set Parameters

ai_distributions = [];

% Get the number of observations in dataset
[~, Observations] = size(timeSeries_2017);

loopEnd = (Observations-windowLength);

% Statistical fitting test
[I_poisson, I_normal, ~, ~] = StatisticalFitting(timeSeries_2017);

%% Slide a window with a fixed length
for window = 1:stepSize:loopEnd
    
% Slide the window at each iteration and select corresponding data
windowed_2017 = timeSeries_2017(:,window:window+windowLength);
windowed_2018 = timeSeries_2018(:,window:window+windowLength);

% Column --> number of observations in dataset
% Row    --> number of time series/covatiates in dataset
[~, Column] = size(windowed_2017);

% Step 1 -- Computing Causal Graphs for reference dataset
% Call HGGM for reference Betas
[~, betas_ref, ~] = AD(windowed_2017, Lag, 1:Column, Lambda, I_normal, I_poisson);

% Step 1 -- Computing Causal Graphs for test dataset
% Call Constrained Optimization for test Betas
[betas_test, ~, ~, ~, ~, ~] = ConstrainedOptimization(windowed_2018, betas_ref, Lag, Epsilon, p, delta, I_normal, I_poisson);

% Display results of reference and test set
disp('Betas of reference Set (2017)'); 
disp(betas_ref'); 
disp('Betas of test Set (2018)'); 
disp(betas_test); 

info = ['window: ',num2str(window),' - ', num2str(window+windowLength)];
disp(info);

% Step 2 -- Computing Anomaly Scores
% Compute Mean, Standard Deviation, Lambda
% reference set (2017)
[mean_ref,sd_ref,lambda_ref] = Find_mu_sd_ld(windowed_2017, betas_ref, Lag, I_normal, I_poisson);

% test set (2018)
[mean_test,sd_test,lambda_test] = Find_mu_sd_ld(windowed_2018, betas_test', Lag, I_normal, I_poisson);

% Kullback Leibner divergence --> Anomaly score
[anomalyScore] = KLDivergence(sd_ref,sd_test,mean_ref,mean_test, lambda_ref, lambda_test, I_normal, I_poisson);

% Step 3 -- Store scores in a matrix. Each for contains scores for corresponding x_i
ai_distributions = [ai_distributions anomalyScore'];
  
end    

%% Step 3 cont. -- Calculate threshold cutoff with significance value alpha

for i = 1:5
    
    anomalyThreshold(i) = quantile(ai_distributions(i,:), alpha);
    
end




end