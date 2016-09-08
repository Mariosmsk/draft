settings=[];
settings.filename = 'Net1_Rossman2000.inp';
settings.species = 'THMS';

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
ylabel('THMs (mg/L)')
legend(results.Network.NodeNameID)
%------------- END OF CODE --------------