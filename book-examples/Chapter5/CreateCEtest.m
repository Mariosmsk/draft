function C = CreateCEtest()

network = 'Net1_Rossman2000.inp';
%% Arguments
% Sim Time, number of scenarios, magnitude
% Create Random Scenarios
d = epanet(network);
simulationTime=48*3600; % seconds
numberOfScenarios=100;
numberOfNodesInj=2; 
magnitude=[10 20];
%nodesID=[d.NodeNameID(2),d.NodeNameID(3)];
nodesID='';
NodesRes=[d.NodeNameID(2),d.NodeNameID(3)];

[msx,S] = CreateMsxFile(d,simulationTime,numberOfScenarios,numberOfNodesInj,nodesID,magnitude);
d.writeMSXFile(msx)
d.setTimeSimulationDuration(simulationTime);
C = createContaminationEvents(d,S,msx,NodesRes);



