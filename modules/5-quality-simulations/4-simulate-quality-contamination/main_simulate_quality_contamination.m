settings=[];
settings.filename = which('Net1_Rossman2000.inp');

%% Create JSON file for input
input = savejson(settings);

%% Set default parameters
output = default_parameters(input);
settings.P = output.P;
settings.B = output.B;

%% Grid method
output = gridmethod(output);
settings.P = output.P;

% Run Multiple Scenarios
output = run_multiple_scenarios(settings);

%% Plot graph
% figure(1)
% plot(results.Water_Age.Time/3600,results.Water_Age.Quality)
% grid on
% title('Water Age');
% xlabel('Time (hours)')
% ylabel('Hours')
% legend(results.Network.NodeNameID)
%------------- END OF CODE --------------