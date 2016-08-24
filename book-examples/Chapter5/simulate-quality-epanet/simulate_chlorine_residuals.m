%% Simulate Chlorine Residuals

settings.filename = which('Net1_Rossman2000.inp');
settings.species = 'Chlorine';
d=epanet(settings.filename);
d.setQualityType(settings.species)
d.solveCompleteHydraulics;
chlorine_residuals = d.getComputedQualityTimeSeries;


