settings=[];
settings.filename = 'Net1_Rossman2000.inp';
settings.species = 'TRACE';
settings.node = '9';

%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_trace_node(input);

%% Extract output from JSON
tmp = loadjson(output);
results=tmp.results;

%% Plot graph
figure(1)
plot(results.Trace.Time/3600,results.Trace.Quality)
grid on
title('Trace Nodes');
xlabel('Time (hours)')
ylabel('Trace (percent)')
legend(results.Network.NodeNameID)
%------------- END OF CODE --------------