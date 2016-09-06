filename = which('Net1_Rossman2000.inp')

Sigma = epanet(filename);

hydraulic_states = Sigma.getComputedHydraulicTimeSeries;
quality_states = Sigma.getComputedQualityTimeSeries;

tank_index = Sigma.NodeTankIndex;
node_index = Sigma.NodeJunctionIndex;
link_index = Sigma.LinkPipeIndex;

% tank levels/volume
x.Tank_Volume = [hydraulic_states.Time hydraulic_states.TankVolume(:,tank_index)];
x.Tank_Chlorine = [quality_states.Time quality_states.Quality(:, tank_index)]

z.Junctions_Head = [hydraulic_states.Time hydraulic_states.Head(:, node_index)];
z.Pipe_Flow = [hydraulic_states.Time hydraulic_states.Flow(:, link_index)];
c.Junctions_Chlorine = [quality_states.Time quality_states.Quality(:, node_index)];

e_y = 0;

y = f_y(x,z,c) + e_y;



Sigma.unload

