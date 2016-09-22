settings=[];
settings.filename = 'Net1.inp';
settings.simulation_time=48*3600; % seconds
settings.num_scenarios=100;
settings.num_nodesinj=2; 
settings.magnitude=[10 20];

d = epanet(settings.filename); %prosorina
settings.nodes_id=[d.NodeNameID(10),d.NodeNameID(3)];
settings.nodes_results=d.NodeNameID;%[d.NodeNameID(10),d.NodeNameID(3),d.NodeNameID(6),d.NodeNameID(7)];

%% Create JSON file for input
input = savejson(settings);

%% Run Module
out_scenarios = create_msx_scenarios(input);
out_msx = create_msx_file;%(input);
d.writeMSXFile(out_msx)
d.setTimeSimulationDuration(settings.simulation_time);


% create contamination events
settings.network=d; 
settings.scenarios=out_scenarios;
settings.msx_info = out_msx;
settings.nodes_results = settings.nodes_results;
input2 = savejson(settings);
output2 = create_contamination_events(input2);

%% Extract output from JSON
tmp = loadjson(output2);
results=tmp.results;

delete(which(out_msx.msxFile));

%% Plot graph
figure(1)
scenario=1;
plot(results.Chlorine{scenario}.disinfectant)
grid on
title('Chlorine Concentration');
xlabel('Time (hours)')
ylabel('Chlorine (mg/L)')
legend(d.NodeNameID)

figure(2)
plot(results.THMs{scenario}.contaminant)
grid on
title('THMs Concentration');
xlabel('Time (hours)')
ylabel('THMs (ug/L)')
legend(d.NodeNameID)
%------------- END OF CODE --------------