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

results.d.unloadMSX
results.d.unload

%------------- END OF CODE --------------