%% Simulate a contamination event at the Node '11'
close all; clear; rng(1)

%% Load EPANET Network and MSX
G = epanet('BWSN_Network_1.inp');
G.loadMSXFile('Arsenite.msx'); % Load MSX file

% Sensor locations

sensor_index = G.getNodeIndex({'JUNCTION-17', 'JUNCTION-83', 'JUNCTION-122', 'JUNCTION-31', 'JUNCTION-45'});

%% Simulation Setup
t_d = 5; % days
G.setTimeSimulationDuration(t_d*24*60*60); % Set simulation duration of 5 days

%% Get Network data
demand_pattern = G.getPattern;
roughness_coeff = G.getLinkRoughnessCoeff;

%% Scenarios
Ns = 10; % Number of scenarios to simulate
u_p = 0.10; % pattern uncertainty
u_r = 0.05; % roughness coefficient uncertainty
max_inj_conc = 0.5;
inj_start_time = 1*48; % after day 1 (Dt = 30min)
inj_duration = 12; % 6 hours
inj_sc=[randi(G.NodeCount,Ns,1), max_inj_conc*rand(Ns,1), randi(48,Ns,1)+inj_start_time, randi(inj_duration,Ns,1)]; % Injection location, magnitude, start time, duration 

inj_sc=[18, 1, 48, 12]; % Injection location, magnitude, start time, duration 




%% Run epochs
for i = 1:Ns
    %randomize hydraulics
    r_p = -u_p + 2*u_p.*rand(size(demand_pattern,1),size(demand_pattern,2));
    new_demand_pattern = demand_pattern + demand_pattern.*r_p;
    G.setPatternMatrix(new_demand_pattern);
    r_r = -u_r + 2*u_r.*rand(size(roughness_coeff,1),size(roughness_coeff,2));
    new_roughness_coeff = roughness_coeff + roughness_coeff.*r_r;
    G.setLinkRoughnessCoeff(new_roughness_coeff);
    
    %G.setMSXSources(inj_sc(i,1), 2, 0, 1, 2) %node, species_index, type, concentration, pattern
    G.setMSXSources(18, 2, 0, 0.5, 2)
    %as3_pat = ones(1, t_d*48);
    %as3_pat(inj_sc(i,3):(inj_sc(i,3)+inj_sc(i,4))) = 1; % 
    %G.setMSXPattern(2,as3_pat);
    Q{i} = G.getMSXComputedQualityNode(sensor_index);
end

G.unloadMSX

%% Plot Networkd
%G.plot('nodes','no','links','no','highlightnode',{'11'},'highlightlink',{'10'},'fontsize',8);

%% Initial Conditions

% 
% 
% G.setMSXSources(10, 1, 0, 0.6, 1) % Specify Chlorine disinfection at node index 10, of species `Chlorine', wnode, species_index, type, concentration, pattern
% M = 10; % number of scenarios
% inj_sc = [randi(G.NodeCount,M,1), 0.5*rand(M,1)];
% 
% for i = 1:1
%     disp(['Iteration ', int2str(i)])
%     G.setMSXSources(inj_sc(i,1), 2, 0, inj_sc(i,2), 2) %node, species_index, type, concentration, pattern
%     inj_time = 12 + randi(12,1,1); % random time after the first day
%     inj_duration = randi(6,1,1); % maximum duration time of 12 hours
%     as3_pat = zeros(1, 5*12);
%     as3_pat(inj_time:(inj_time+inj_duration)) = 1; % 
%     G.setMSXPattern(2,as3_pat);
%     Q{i} = G.getMSXComputedQualityNode;
%     G.setMSXSources(inj_sc(i,1), 2, 0, 0, 2) %node, species_index, type, concentration, pattern
% end
% %%
% figure
% plot(Q{1}.Quality{10}{1})
% hold all
% plot(Q{1}.Quality{10}{2})





%{
    pattern_index = find(strcmp(G.getMSXPatternsNameID,'AS3PAT'));    
    species_index = find(strcmp(G.getMSXSpeciesNameID,'AsIII'));

inj_time = 12 + randi(12,1,1); % random time after the first day
inj_duration = randi(6,1,1); % maximum duration time of 12 hours
as3_pat = zeros(1, 5*12);
InjectionConcentration = 0.7;
as3_pat(inj_time:(inj_time+inj_duration)) = InjectionConcentration; % 
G.addMSXPattern('AS3', as3_pat);

inj_node_index = G.getNodeIndex('11'); % Get index of Node 


pstep = G.TimePatternStep/3600;
patlen=(G.TimeSimulationDuration/3600)/pstep;

% add pattern for contamination at node injection
tmppat=zeros(1,patlen);
tmpstartstep=1; % hour
tmpendstep=round(max(randperm(G.TimeSimulationDuration/3600)));
tmppat(tmpstartstep:tmpendstep)=1;
tmp1=G.addPattern('CONTAMINANT',tmppat);
tmp2 = G.getNodePatternIndex;
tmp2(inj_node_index)=tmp1;
tmpQ=zeros(1,G.NodeCount);
tmpQ(inj_node_index)=1;
G.setNodeSourcePatternIndex(tmp2);
G.setNodeSourceQuality(tmpQ)

G.solveCompleteHydraulics;
Q = d.getComputedQualityTimeSeries('quality','time');
%}