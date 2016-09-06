filename = 'Net1_Rossman2000.inp';

G = epanet(filename);

hydraulic_states = G.getComputedHydraulicTimeSeries;
quality_states = G.getComputedQualityTimeSeries;

tank_index = G.NodeTankIndex;
node_index = G.NodeJunctionIndex;
link_index = G.LinkPipeIndex;

% tank levels/volume
x.Tank_Volume = [hydraulic_states.Time hydraulic_states.TankVolume(:,tank_index)];
x.Tank_Chlorine = [quality_states.Time quality_states.Quality(:, tank_index)];

z.Junctions_Head = [hydraulic_states.Time hydraulic_states.Head(:, node_index)];
z.Pipe_Flow = [hydraulic_states.Time hydraulic_states.Flow(:, link_index)];
c.Junctions_Chlorine = [quality_states.Time quality_states.Quality(:, node_index)];

e_y = 0;

% Specify sensor array 's'
% 1) Tank Volume; 2) Tank Chlorine; Junctions Head 1,3,9; Junctions
% Chlorine 5,7
s = {[1], [1], [1 3 9], [], [5,7]}; 

% Construct output vector y
y = f_y(x,z,c,G,s) + e_y;

G.unload

