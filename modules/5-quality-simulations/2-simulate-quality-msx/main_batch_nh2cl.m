clear all;close all;clc;
settings.filename = 'batch-nh2cl.inp'; 
settings.msxfilename = 'batch-nh2cl.msx'; 
% Trace River
settings.duration = 168;
%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_batch_nh2cl(input);
results = output;

% Plots
figure;plot(results.compQualNodes.Time/3600,results.compQualNodes.Quality{1}{3}*1000)

%------------- END OF CODE --------------