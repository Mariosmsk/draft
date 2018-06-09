filename = 'Net1.inp';

% Load the network in an object of class 'epanet'. 
G = epanet(filename); 

% Solve the hydraulic equations and get all computed hydraulic time series
hydraulic_states = G.getComputedHydraulicTimeSeries;

% Solve the quality equations and get all computed quality time series
quality_states = G.getComputedQualityTimeSeries;

% Get the indices of different elements in the network
tank_index = G.NodeTankIndex;
node_index = G.NodeJunctionIndex;
link_index = G.LinkPipeIndex;

% Store in the 'x' structure the tank volume and chlorine concentration
x.Tank_Volume = [hydraulic_states.Time hydraulic_states.TankVolume(:,tank_index)];
x.Tank_Chlorine = [quality_states.Time quality_states.Quality(:, tank_index)];

% Store in the 'z' structure the junction heads and the pipe flows.
z.Junctions_Head = [hydraulic_states.Time hydraulic_states.Head(:, node_index)];
z.Pipe_Flow = [hydraulic_states.Time hydraulic_states.Flow(:, link_index)];

% Store in the 'c' structure the chlorine concentration in junctions.
c.Junctions_Chlorine = [quality_states.Time quality_states.Quality(:, node_index)];

% Set the sensor error as zero
e_y = 0;

% Specify sensor array 's'
% 1) Tank Volume [1]; 2) Tank Chlorine [1]; Junctions Head [1,3,9]; Junctions
% Chlorine [5,7]
s = { 1, 1, [1 3 9], [], [5,7]}; 

% Construct output vector y
y = f_y(x,z,c,G,s) + e_y;

% Save simulation in a file
save('y_Net1.mat','y');

% Unload the epanet object from MATLAB's memory
G.unload

