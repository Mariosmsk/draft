function [C] = simulate_contamination_events(input1)
%FUNCTION_NAME - One line description of what the function or script performs (H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%
% Syntax:  [output1,output2] = function_name(input1,input2,input3)
%
% Inputs:
%    input1 - Description
%
% Outputs:
%    output1 - Description
%
% Example: 
%    Line 1 of example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author        : Demetrios G. Eliades
% Work address  : KIOS Research Center, University of Cyprus
% email         : eldemet@ucy.ac.cy
% Website       : http://www.kios.ucy.ac.cy
% Last revision : September 2016

%------------- BEGIN CODE --------------

% Sim Time, number of scenarios, magnitude
% Create Random Scenarios
inpname = which('Net1_Rossman2000.inp');
d = epanet(inpname);
simulationTime=48*3600; % seconds
numberOfScenarios=100;
numberOfNodesInj=2; 
magnitude=[10 20];
nodesID=''; % [d.NodeNameID(2),d.NodeNameID(3)]
NodesResuls=[d.NodeNameID(2),d.NodeNameID(3)];

% Create msx struct for write msx file
[msx,S] = CreateMsxFile(d,simulationTime,numberOfScenarios,numberOfNodesInj,nodesID,magnitude);
d.writeMSXFile(msx)

% set simulation time
d.setTimeSimulationDuration(simulationTime);

% create contamination events
C = createContaminationEvents(d,S,msx,NodesResuls);
end
%------------- END OF CODE --------------
function C = createContaminationEvents(d,S,msx,NodesRes)
% Create Contamination Events
NodesResIndex=d.getNodeIndex(NodesRes);
for i=1:length(S)
    if i>1;  d.unloadMSX; end
    d.loadMSXFile(msx.msxFile);
    p1=zeros(1,d.getTimeSimulationDuration/3600);
    p2=zeros(1,d.getTimeSimulationDuration/3600);
    p1(S{i}.StartTime(1):S{i}.EndTime(1))=S{i}.magnitude(1);
    p2(S{i}.StartTime(2):S{i}.EndTime(2))=S{i}.magnitude(2);
    
    pat1=d.addMSXPattern([num2str(i),'p1'],p1);
    pat2=d.addMSXPattern([num2str(i),'p2'],p2);
    nodeIndex1 = d.getNodeIndex(S{i}.nodesID(1));
    specIndex1 = 2; % suppose is index 1
    type = 0;
    level = S{i}.magnitude(1);
    d.setMSXSources(nodeIndex1, specIndex1, type, level, pat1)
    nodeIndex2 = d.getNodeIndex(S{i}.nodesID(2));
    specIndex2 = 3;
    level = S{i}.magnitude(2);
    d.setMSXSources(nodeIndex2, specIndex2, type, level, pat2)

    nn=d.getMSXComputedQualityNode;
    C{i}.Scenarios = S{i};
    C{i}.NodesRes = NodesRes;
    for u=1:length(NodesResIndex)
        C{i}.disinfectant{u} = nn.Quality{NodesResIndex(u)}{specIndex1};
        C{i}.contaminant{u} = nn.Quality{NodesResIndex(u)}{specIndex2};
    end
    disp(i);
end
end
function [msx,S] = CreateMsxFile(d,simulationTime,numberOfScenarios,numberOfNodesInj,nodesID,magnitude)

for i=1:numberOfScenarios
    %Nodes ID or random nodes ID
    b=0;
    sTime=randi(simulationTime/3600,numberOfNodesInj,2);
    while b==0
        if min(sTime(:,1))~=max(sTime(:,1)) || min(sTime(:,2))~=max(sTime(:,2))
            b=1;
        end
        sTime=randi(simulationTime/3600,numberOfNodesInj,2);
    end
    if isempty(nodesID)
        indexNodes=randperm(d.getNodeCount,numberOfNodesInj);
        nodesID=d.NodeNameID(indexNodes);
    end

    Scenarios{i}.nodesID = nodesID;
    Scenarios{i}.StartTime = [min(sTime(:,1)) min(sTime(:,2))];
    Scenarios{i}.EndTime = [max(sTime(:,1)) max(sTime(:,2))];
    Scenarios{i}.magnitude = magnitude;
    
end
S = Scenarios;

%% Create Msx File.. arguments
clInputs = {'AGE','Chlorine','THMs','TOC'};
%speciesStrength ={10,20,30,4};

% Input Arguments
msx={};
msx.msxFile = 'MsxFileName.msx';
% section Title
msx.titleDescription{1} = 'Example: Contamination detection algorithm.';
% section Options
msx.options{1}='FT2'; %AREA_UNITS FT2/M2/CM2
msx.options{2}='DAY'; %TIME_UNITS SEC/MIN/HR/DAY
msx.options{3}='RK5'; %SOLVER EUL/RK5/ROS2
msx.options{4}='NONE'; %COUPLING FULL/NONE
msx.options{5}='NONE'; %COMPILER NONE/VC/GC
msx.options{6}=3600; %TIMESTEP in seconds
msx.options{7}=0.01;  %ATOL value
msx.options{8}=0.001;  %RTOL value
% section Species
% <type> <specieID> <units> (<atol> <rtol>)
msx.species{1}={'BULK','BULK','BULK','BULK'}; %type BULK/WALL
msx.species{2}=clInputs; %specieID
msx.species{3}={'HR','MG','UG','MG'}; %units UG/MG
msx.species{4}={0.01,0.01,0.01,0.01}; %atol
msx.species{5}={0.001,0.001,0.001,0.001}; %rtol

% section Coefficients 
% CONSTANT name value % PARAMETER name value
msx.coefficients{1}={'PARAMETER','PARAMETER','PARAMETER'}; 
msx.coefficients{2}={'Temp','Kw','Y'}; 
msx.coefficients{3}={20,0.3048,33.5}; 

% section Terms
% <termID> <expression>
msx.terms{1}={'Kf','Kb'}; % termID
msx.terms{2}={'(1.5826e-4 * RE^0.88 / D)','(1.8e6*exp(-6050/(Temp+273)))*TOC'}; % expression

% section Pipes
% EQUIL <specieID> <expression>
% RATE <specieID> <expression>
% FORMULA <specieID> <expression>
msx.pipes{1} ={'RATE','RATE','RATE','RATE'}; %type
msx.pipes{2} ={'AGE','Chlorine','THMs','TOC'}; %specieID
msx.pipes{3} ={'1','-Kb*Chlorine - (4/D)*Kw*Kf/(Kw+Kf)*Chlorine','0','Y*Kb*Chlorine*1000'}; %expression

% section Tanks
% EQUIL <specieID> <expression>
% RATE <specieID> <expression>
% FORMULA <specieID> <expression>
msx.tanks{1} ={'RATE','RATE','RATE','RATE'}; %type
msx.tanks{2} ={'AGE','Chlorine','THMs','TOC'}; %specieID
msx.tanks{3} ={'1','-Kb*Chlorine','0','Y*Kb*Chlorine*1000'}; %expression

% % section Sources
% % <type> <nodeID> <specieID> <strength> (<patternID>)
% msx.sources{1}={''}; %CONC/MASS/FLOW/SETPOINT
% msx.sources{2}={''}; %nodeID
% msx.sources{3}={''}; %specieID
% msx.sources{4}={''}; %strength
% msx.sources{5}={''}; %patternID
% 
% % section Quality Global
% % GLOBAL <specieID> <value>
% msx.global{1} = {''};
% msx.global{2} = {''};%specieID
% msx.global{3} = {''};%value
% % others
% % NODE <nodeID> <bulkSpecieID> <value>
% % LINK <linkID> <wallSpecieID> <value>
% msx.quality{1} = {''}; %NODE/LINK
% msx.quality{2} = {''}; %ID
% msx.quality{3} = {''}; %bulkSpecieID/wallSpecieID
% msx.quality{4} = {''}; %value
% 
% % section Parameters
% % PIPE <pipeID> <paramID> <value>
% % TANK <tankID> <paramID> <value>
% msx.parameters{1} = {''};
% msx.parameters{2} = {''};
% msx.parameters{3} = {''};
% msx.parameters{4} = {''};
% 
% % section Patterns
% % <patternID> <multiplier> <multiplier> 
% msx.patterns{1} = {''}; %patternID
% msx.patterns{2} = {''}; %multiplier

end

