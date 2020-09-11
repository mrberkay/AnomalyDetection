function [] = PlotAnomaliesSpecial(timeSeries_2017, timeSeries_2018, aw1, aw2, aw3, aw4, aw5, dataSeries)

if(dataSeries == 1)
    labels = ["Temperature (\circC)","Air Pressure hPa","Precipitation (mm)","Humidity (%)","Cloudiness 0-100";];
end
if(dataSeries == 2)
    labels = ["Temperature (\circC)","Wind (km/h)","Sunny Hours per day","Humidity (%)","Cloudiness 0-100";];
end
if(dataSeries == 3)
    labels = ["Temperature (\circC)","Air Pressure hPa","Precipitation (mm)","Cloudiness 0-100","Solar Irradiance (J/cm²)";];
end
if(dataSeries == 4)
    labels = ["Wind (km/h)","Air Pressure hPa","Precipitation (mm)","Humidity (%)","Cloudiness 0-100";];
end

%% Plot X(1)
[~, AnomalWindows1] = size(aw1);
loopEnd1 = AnomalWindows1;

i = 1;  
while (i + 2 < loopEnd1)

check = 1;
lower = aw1(i);
upper = aw1(i+1);

while (i + 2 < loopEnd1) && ((aw1(i+2) - aw1(i)) <= 3)    
    
    if(check == 1)
        lower = aw1(i);
        check = 0;
    end
    upper = aw1(i+3);  
    i = i + 2;
end

info = ['lower: ', num2str(lower)];
disp(info);
info = ['upper: ', num2str(upper)];
disp(info);

figure();
hold off
w1 = 0.75;
w2 = 0.25;
bar(timeSeries_2017(1,lower:upper),w1,'FaceColor',[0.4660 0.6740 0.1880])
hold on
bar(timeSeries_2018(1,lower:upper),w2,'FaceColor',[0.6350 0.0780 0.1840])
legend({'2017','2018'});
ylabel(num2str(labels(1)));
xlabel('Day');
hold on
xline(1,'--r',{'Anomaly','Start'},'LineWidth',1);
hold on
xline(upper-lower+1,'--b',{'Anomaly','End'},'LineWidth',1);
info = ['Between ', num2str(lower), 'th - ', num2str(upper), 'th Day of Year'];
title(info);
hold off

  
  i = i + 2;
end

%% Plot X(2)
[~, AnomalWindows1] = size(aw2);
loopEnd1 = AnomalWindows1;



i = 1;  
while (i + 2 < loopEnd1)

check = 1;
lower = aw2(i);
upper = aw2(i+1);

while (i + 2 < loopEnd1) && ((aw2(i+2) - aw2(i)) <= 3)    
    
    if(check == 1)
        lower = aw2(i);
        check = 0;
    end
    upper = aw2(i+3);  
    i = i + 2;
end

info = ['lower: ', num2str(lower)];
disp(info);
info = ['upper: ', num2str(upper)];
disp(info);

figure();
hold off
w1 = 0.75;
w2 = 0.25;
bar(timeSeries_2017(2,lower:upper),w1,'FaceColor',[0.4660 0.6740 0.1880])
hold on
bar(timeSeries_2018(2,lower:upper),w2,'FaceColor',[0.6350 0.0780 0.1840])
legend({'2017','2018'});
ylabel(num2str(labels(2)));
xlabel('Day');
hold on
xline(1,'--r',{'Anomaly','Start'},'LineWidth',1);
hold on
xline(upper-lower+1,'--b',{'Anomaly','End'},'LineWidth',1);
info = ['Between ', num2str(lower), 'th - ', num2str(upper), 'th Day of Year'];
title(info);
if (dataSeries == 1 || dataSeries == 3 || dataSeries == 4)
    set(gca,'YLim',[960 1020])
end
hold off

  
  i = i + 2;
end

%% Plot X(3)
[~, AnomalWindows1] = size(aw3);
loopEnd1 = AnomalWindows1;

i = 1;  
while (i + 2 < loopEnd1)

check = 1;
lower = aw3(i);
upper = aw3(i+1);

while (i + 2 < loopEnd1) && ((aw3(i+2) - aw3(i)) <= 3)    
    
    if(check == 1)
        lower = aw3(i);
        check = 0;
    end
    upper = aw3(i+3);  
    i = i + 2;
end

info = ['lower: ', num2str(lower)];
disp(info);
info = ['upper: ', num2str(upper)];
disp(info);

figure();
hold off
w1 = 0.75;
w2 = 0.25;
bar(timeSeries_2017(3,lower:upper),w1,'FaceColor',[0.4660 0.6740 0.1880])
hold on
bar(timeSeries_2018(3,lower:upper),w2,'FaceColor',[0.6350 0.0780 0.1840])
legend({'2017','2018'});
ylabel(num2str(labels(3)));
xlabel('Day');
hold on
xline(1,'--r',{'Anomaly','Start'},'LineWidth',1);
hold on
xline(upper-lower+1,'--b',{'Anomaly','End'},'LineWidth',1);
info = ['Between ', num2str(lower), 'th - ', num2str(upper), 'th Day of Year'];
title(info);
hold off

  
  i = i + 2;
end

%% Plot X(4)
[~, AnomalWindows1] = size(aw4);
loopEnd1 = AnomalWindows1;

i = 1;  
while (i + 2 < loopEnd1)

check = 1;
lower = aw4(i);
upper = aw4(i+1);

while (i + 2 < loopEnd1) && ((aw4(i+2) - aw4(i)) <= 3)    
    
    if(check == 1)
        lower = aw4(i);
        check = 0;
    end
    upper = aw4(i+3);  
    i = i + 2;
end

info = ['lower: ', num2str(lower)];
disp(info);
info = ['upper: ', num2str(upper)];
disp(info);

figure();
hold off
w1 = 0.75;
w2 = 0.25;
bar(timeSeries_2017(4,lower:upper),w1,'FaceColor',[0.4660 0.6740 0.1880])
hold on
bar(timeSeries_2018(4,lower:upper),w2,'FaceColor',[0.6350 0.0780 0.1840])
legend({'2017','2018'});
ylabel(num2str(labels(4)));
xlabel('Day');
hold on
xline(1,'--r',{'Anomaly','Start'},'LineWidth',1);
hold on
xline(upper-lower+1,'--b',{'Anomaly','End'},'LineWidth',1);
info = ['Between ', num2str(lower), 'th - ', num2str(upper), 'th Day of Year'];
title(info);
hold off

  
  i = i + 2;
end

%% Plot X(5)
[~, AnomalWindows1] = size(aw5);
loopEnd1 = AnomalWindows1;

i = 1;  
while (i + 2 < loopEnd1)

check = 1;
lower = aw5(i);
upper = aw5(i+1);

while (i + 2 < loopEnd1) && ((aw5(i+2) - aw5(i)) <= 3)    
    
    if(check == 1)
        lower = aw5(i);
        check = 0;
    end
    upper = aw5(i+3);  
    i = i + 2;
end

info = ['lower: ', num2str(lower)];
disp(info);
info = ['upper: ', num2str(upper)];
disp(info);

figure();
hold off
w1 = 0.75;
w2 = 0.25;
bar(timeSeries_2017(5,lower:upper),w1,'FaceColor',[0.4660 0.6740 0.1880])
hold on
bar(timeSeries_2018(5,lower:upper),w2,'FaceColor',[0.6350 0.0780 0.1840])
legend({'2017','2018'});
ylabel(num2str(labels(5)));
xlabel('Day');
hold on
xline(1,'--r',{'Anomaly','Start'},'LineWidth',1);
hold on
xline(upper-lower+1,'--b',{'Anomaly','End'},'LineWidth',1);
info = ['Between ', num2str(lower), 'th - ', num2str(upper), 'th Day of Year'];
title(info);
hold off

  
  i = i + 2;
end


end