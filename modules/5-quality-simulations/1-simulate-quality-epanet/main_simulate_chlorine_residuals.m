settings=[];
settings.filename = which('Net1_Rossman2000.inp');
settings.species = 'Chlorine';

%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_chlorine_residuals(input);

%% Extract output from JSON
tmp = loadjson(output);
results=tmp.results;

%% Plot graph
figure(1)
plot(results.Chlorine.Time/3600,results.Chlorine.Quality)
grid on
title('Chlorine Concentration');
xlabel('Time (hours)')
ylabel('Cl_2 (mg/L)')
legend(results.Network.NodeNameID)
%------------- END OF CODE --------------