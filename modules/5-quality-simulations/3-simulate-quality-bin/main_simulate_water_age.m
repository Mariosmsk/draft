settings=[];
settings.filename ='Net1.inp';
settings.species = 'AGE';
settings.duration = 24; %hours
%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_water_age(input);

%% Extract output from JSON
tmp = loadjson(output);
results=tmp.results;

%% Plot graph
figure;
plot(results.Water_Age.Time/3600,results.Water_Age.Quality)
grid on
title('Water Age');
xlabel('Time (hour)')
ylabel('Hours')
legend(results.Network.NodeNameID);

%------------- END OF CODE --------------