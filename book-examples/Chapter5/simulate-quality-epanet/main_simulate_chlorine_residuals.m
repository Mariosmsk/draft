settings.filename = which('Net1_Rossman2000.inp');
settings.species = 'Chlorine';

%% Create JSON file for input
input = savejson(settings);

%% Run Module
[C, d] = simulate_chlorine_residuals(input);

%% Plot graph
figure(1)
plot(C.Time/3600,C.Quality)
grid on
title('Chlorine Concentration');
xlabel('Time (hours)')
ylabel('Cl_2 (mg/L)')
legend(d.NodeNameID)
%------------- END OF CODE --------------