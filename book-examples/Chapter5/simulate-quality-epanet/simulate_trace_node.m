%% Simulate Trace Node

settings.filename = which('Net1_Rossman2000.inp');
settings.species = 'AGE';
d=epanet(settings.filename);
d.setQualityType(settings.species)
d.solveCompleteHydraulics;
water_age = d.getComputedQualityTimeSeries;