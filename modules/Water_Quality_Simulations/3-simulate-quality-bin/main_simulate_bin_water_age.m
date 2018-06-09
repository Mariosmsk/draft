settings=[];
settings.filename ='Net1.inp';
settings.species = 'AGE';
settings.duration = 480; %hours

%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_bin_water_age(input);

%% Extract output from JSON
tmp = loadjson(output);
results=tmp.results;

%% Plot graph
figure;
subplot(2,1,1);
plot(0:1:settings.duration,results.WaterAgeNodes);
grid on
title('Water Age at Nodes');
xlabel('Time (hours)');
ylabel('Hours');
legend(results.Network.NodeNameID);

subplot(2,1,2);
plot(0:1:settings.duration,results.WaterAgeLinks);
grid on
title('Water Age at Links');
xlabel('Time (hours)');
ylabel('Hours');
legend(results.Network.LinkNameID);

%------------- END OF CODE --------------