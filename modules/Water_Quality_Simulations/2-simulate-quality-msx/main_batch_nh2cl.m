clear all;close all;clc;
settings.filename = 'batch-nh2cl.inp'; 
settings.msxfilename = 'batch-nh2cl.msx'; 
% Trace River
settings.duration = 168;
settings.species_id = 'H';
%% ph 6.5
settings.ph = 6.55; 
ph1=settings.ph;

%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_batch_nh2cl(input);
results1 = output;

%% ph 7.5
settings.ph = 7.55;
ph2=settings.ph;
input = savejson(settings);
output = simulate_batch_nh2cl(input);
results2 = output;

% Plots
figure;
subplot(2,1,1);
plot(results1.compQualNodes.Time/3600,results1.compQualNodes.Quality{1}(:,3)*1000);
hold on;
xlabel('Time(hour)');
ylabel('NH2CL(mM)');
title('NH2CL bacth model results');
[t,y]=nh2cl(ph1); % example from OWA nh2cl mfile
plot(t,y(:,3)*1000,'ro');
tmp=[{['EPANET-MSX at pH=',num2str(ph1)]},{['Matlab Results at pH=',num2str(ph1)]}];
legend(tmp);

subplot(2,1,2);
plot(results2.compQualNodes.Time/3600,results2.compQualNodes.Quality{2}(:,3)*1000);
hold on;
xlabel('Time(hour)');
ylabel('NH2CL(mM)');
[t,y]=nh2cl(ph2);
plot(t,y(:,3)*1000,'r<');
tmp=[{['EPANET-MSX at pH=',num2str(ph2)]},{['Matlab Results at pH=',num2str(ph2)]}];
legend(tmp);

%------------- END OF CODE --------------