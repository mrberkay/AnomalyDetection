clear all;
close all;
clc;

%% Set Initial Parameters
% Select Dataset, Options are: [ 1 | 2 | 3 | 4 ]
dataSeries = 1;
% Set the Lag --> 2,3, max 4
Lag = 3;
% Set the Maximum Lambda for Cross Validation
Lambda = 2;
% Set Epsilon and Delta for Constraints
Epsilon = 0.006;
delta = 0.8;
% Set Window Lenght for Anomaly Detection --> Minimum 20 for Lag = 2
windowLength = 25;
% Select Significance Level as (1 - alpha)
alpha = 0.96;

%% Call Dataset
[timeSeries_2017, timeSeries_2018] = PrepareData(dataSeries);

% Column --> number of observations in dataset
% Row    --> number of time series/covatiates in dataset
[Row, Column] = size(timeSeries_2017);
% p is the number of time series
p = Row;

%% Start Algoritm -- Includes Step 1,2,3
stepSize = 1;
[anomalyThreshold, ai_distributions] = AnomalyThreshold(windowLength, stepSize, timeSeries_2017, timeSeries_2018, p, Lag, ...
                                                        Lambda, Epsilon, delta, alpha);
disp('Anomaly thresholds computed successfully'); 
disp(anomalyThreshold);


%% Step 4 -- Detect Anomaly with Computed Thresholds
[aw1, aw2, aw3, aw4, aw5] = AnomalyDetection(anomalyThreshold, ai_distributions, windowLength);

%% Plot Functions -- Please Uncomment or Call from Command Window
% %% Plot Anomaly Scores and Mark threshold
% PlotThresholds(ai_distributions, alpha);

%% Select/Filter and Plot Anomalous windows
% PlotAnomaliesSpecial(timeSeries_2017, timeSeries_2018, aw1, aw2, aw3, aw4, aw5, dataSeries);




