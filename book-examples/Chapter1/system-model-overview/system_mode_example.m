filename = which('Net1_Rossman2000.inp')

S = epanet(filename);

hydraulic_states = S.getComputedHydraulicTimeSeries;
quality_states = S.getComputedQualityTimeSeries;

tank_index = G.NodeTankIndex;
node_index = G.NodeJunctionIndex;
link_index = G.LinkPipeIndex;

% tank levels/volume
x.Tank_Volume = [hydraulic_states.Time hydraulic_states.TankVolume(:,tank_index)];
x.Tank_Chlorine = [quality_states.Time quality_states.Quality(:, tank_index)]

z.Junctions_Head = [hydraulic_states.Time hydraulic_states.Head(:, node_index)];
z.Pipe_Flow = [hydraulic_states.Time hydraulic_states.Flow(:, link_index)];
c.Junctions_Chlorine = [quality_states.Time quality_states.Quality(:, node_index)];

S.unload

