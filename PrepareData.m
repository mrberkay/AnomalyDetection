function [ts2017,ts2018] = PrepareData(dataSet)

%% Read Data from csv files
% Read data from csv files --> Reference Dataset 2017
temperature_2017 = csvread('Temperature_2017.csv');
wind_2017 = csvread('WindMeanValues_2017.csv');
airPressure_2017 = csvread('AirPressure_2017.csv');
humidity_2017 = csvread('Humidity_2017.csv');
sunnyHours_2017 = csvread('SunnyHours_2017.csv');
precipitation_2017 = csvread('Niederschlag_2017.csv');
SolarIrradiance_2017 = csvread('SolarIrradiance_2017.csv');
Cloudiness_2017 = csvread('cloud_14_2017.csv');

% Read data from csv files --> Test dataset 2018
temperature_2018 = csvread('Temperature_2018.csv');
wind_2018 = csvread('WindMeanValues_2018.csv');
airPressure_2018 = csvread('AirPressure_2018.csv');
humidity_2018 = csvread('Humidity_2018.csv');
sunnyHours_2018 = csvread('SunnyHours_2018.csv');
precipitation_2018 = csvread('Niederschlag_2018.csv');
SolarIrradiance_2018 = csvread('SolarIrradiance_2018.csv');
Cloudiness_2018 = csvread('cloud_14_2018.csv');
% End --> Read data from csv files


% % %Normalize air Pressure by substracting mean values
% airPressure_2017 = airPressure_2017 - 992;
% airPressure_2018 = airPressure_2018 - 991;

% Multiply Cloudiness with a constant
Cloudiness_2017 = Cloudiness_2017 * 10;
Cloudiness_2018 = Cloudiness_2018 * 10;

%% Dataset 1
if (dataSet == 1)
    timeSeries_2017 = [temperature_2017; airPressure_2017; precipitation_2017; humidity_2017; Cloudiness_2017;];
    timeSeries_2018 = [temperature_2018; airPressure_2018; precipitation_2018; humidity_2018; Cloudiness_2018;];
end
%% Dataset 2
if (dataSet == 2)
    timeSeries_2017 = [temperature_2017; wind_2017; sunnyHours_2017; humidity_2017; Cloudiness_2017;];
    timeSeries_2018 = [temperature_2018; wind_2018; sunnyHours_2018; humidity_2018; Cloudiness_2018;];
end
%% Dataset 3
if (dataSet == 3)
    timeSeries_2017 = [temperature_2017; airPressure_2017; precipitation_2017; Cloudiness_2017; SolarIrradiance_2017;];
    timeSeries_2018 = [temperature_2018; airPressure_2018; precipitation_2018; Cloudiness_2018; SolarIrradiance_2018;];
end
%% Dataset 4
if (dataSet == 4)
    timeSeries_2017 = [wind_2017; airPressure_2017; precipitation_2017;  humidity_2017; Cloudiness_2017;];
    timeSeries_2018 = [wind_2018; airPressure_2018; precipitation_2018;  humidity_2018; Cloudiness_2018;];
end


ts2017 = timeSeries_2017;
ts2018 = timeSeries_2018;

end
