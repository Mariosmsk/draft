%% Run with executable, without DLL
settings=[];
settings.filename = 'Net1.inp';
settings.species = 'Chlorine'; 
settings.duration = 24; %hours

%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_bin_chlorine_residuals(input);

%% Extract output from JSON
tmp = loadjson(output);
results=tmp.results;

%% Plot graph
figure;
subplot(2,1,1);
plot(0:1:settings.duration,results.ChlorineNodes)
grid on
title('Chlorine Concentration at Nodes');
xlabel('Time (hours)')
ylabel('Cl_2 (mg/L)')
legend(results.Network.NodeNameID)

subplot(2,1,2);
plot(0:1:settings.duration,results.ChlorineLinks)
grid on
title('Chlorine Concentration at Links');
xlabel('Time (hours)')
ylabel('Cl_2 (mg/L)')
legend(results.Network.LinkNameID)

%------------- END OF CODE --------------