settings=[];
settings.filename = 'Net1.inp';
settings.species = 'TRACE';
settings.node = '9'; % node id
settings.duration = 24; % hours

%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_bin_trace_node(input);

%% Extract output from JSON
tmp = loadjson(output);
results=tmp.results;

%% Plot graph
figure;
subplot(2,1,1);
plot(0:1:settings.duration,results.TraceNodes)
grid on
title('Trace at Nodes');
xlabel('Time (hours)')
ylabel('Trace (percent)')
legend(results.Network.NodeNameID)

subplot(2,1,2);
plot(0:1:settings.duration,results.TraceLinks)
grid on
title('Trace at Links');
xlabel('Time (hours)')
ylabel('Trace (percent)')
legend(results.Network.LinkNameID)

%------------- END OF CODE --------------