%% Simulate with Trace Node

settings.filename = which('Net1_Rossman2000.inp');
settings.species = 'TRACE';
settings.node = '9';
d=epanet(settings.filename);
d.setQualityType(settings.species, settings.node)
d.solveCompleteHydraulics;
traceC = d.getComputedQualityTimeSeries;