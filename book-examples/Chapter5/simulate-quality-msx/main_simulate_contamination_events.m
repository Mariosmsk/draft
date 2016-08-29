settings=[];
settings.filename = which('Net1_Rossman2000.inp');
settings.simulation_time=48*3600; % seconds
settings.num_scenarios=100;
settings.num_nodesinj=2; 
settings.magnitude=[10 20];

d = epanet(settings.filename); %prosorina
settings.nodes_id=[d.NodeNameID(10),d.NodeNameID(3)];
settings.nodes_results=[d.NodeNameID(10),d.NodeNameID(3),d.NodeNameID(6),d.NodeNameID(7)];

%% Create JSON file for input
input = savejson(settings);

%% Run Module
out_scenarios = create_msx_scenarios(input);
out_msx = create_msx_file;%(input);
d.writeMSXFile(msx)
d.setTimeSimulationDuration(settings.simulation_time);


% create contamination events
C = createContaminationEvents(d,S,msx,NodesResuls);

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