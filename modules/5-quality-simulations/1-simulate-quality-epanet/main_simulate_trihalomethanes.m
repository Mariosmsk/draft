settings=[];
settings.filename = 'Net3.inp';
settings.species = 'THMs';
settings.species_units = 'ug/L';
settings.kb = 0.5;
settings.kw = 1;

%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_trihalomethanes(input);

%% Extract output from JSON
tmp = loadjson(output);
results=tmp.results;

%% Plot graph
figure(1)
plot(results.THMs.Time/3600,results.THMs.Quality)
grid on
title('Trihalomethane Concentration');
xlabel('Time (hours)')
ylabel('THMs (ug/L)')
legend(results.Network.NodeNameID)
%------------- END OF CODE --------------