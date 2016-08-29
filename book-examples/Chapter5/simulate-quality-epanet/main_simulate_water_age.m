settings.filename = which('Net1_Rossman2000.inp');
settings.species = 'AGE';

%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_water_age(input);

%% Extract output from JSON
tmp = loadjson(output);
results=tmp.results;

%% Plot graph
figure(1)
plot(results.Water_Age.Time/3600,results.Water_Age.Quality)
grid on
title('Water Age');
xlabel('Time (hours)')
ylabel('Hours')
legend(results.Network.NodeNameID)
%------------- END OF CODE --------------