function output = default_parameters(input)
%DEFAULT_PARAMETERS - One line description of what the function or script performs (H1 line)
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
tmp = loadjson(input); 
settings = tmp.settings;

d = epanet(settings.filename);

disp('Create Scenario Parameters')

P.Method = 'grid';
P.MethodParameter = NaN;

%TIMES
P.PatternTimeStep = d.getTimePatternStep;
P.SimulationTime = 48; %e.g.48 in Hours

%CONTAMINANT (A)
P.SourceInjectionRate = 10; %mg/L (Concentration), instead of mg/minute
P.SourceDuration = 2; %hours
P.SourceParameters = {'SourceInjectionRate','SourceDuration'};
P.SourceValues = {P.SourceInjectionRate, P.SourceDuration};
P.SourcePrc = {0, 0};
P.SourceSamples = {1,1}; 

%CONTAMINANT (B)
P.SourcesMaxNumber = 1; % maximum number of simultaneous sources (including 1,2..)
P.SourcesInjectionTimes = [0 24]; %from...to in hours
%P.SourcesInjectionTimes = [4 5]; %from...to in hours
P.SourcesNodeIndices = 1:d.NodeCount;
P.SensingNodeIndices = 1:d.NodeCount;
%P.SourcesNodeIndices = [3 10];
%P.SourcesNodeIndices = 89;

%AFFECTING FLOWS
P.Diameters = d.getLinkDiameter;
P.Lengths = d.getLinkLength;
P.Roughness = d.getLinkRoughnessCoeff;
P.Elevation = d.getNodeElevations;
P.BaseDemand = d.getNodeBaseDemands{1};
%P.SourcesNodeIndicesNonZero = P.BaseDemand~=0;
P.NodesNonZeroDemands = find(P.BaseDemand>0);
P.Patterns = d.getPattern;

P.FlowParameters = {'Diameters', 'Lengths','Roughness',...
    'Elevation','BaseDemand','Patterns'};
P.FlowValues = {P.Diameters, P.Lengths, P.Roughness,...
    P.Elevation, P.BaseDemand, P.Patterns};
P.FlowPrc = {0,0,0,0,0,5};
P.FlowSamples = {1,1,1,1,1,1};

output.P = P;
output.B = d;

% output = savejson(P);

%------------- END OF CODE --------------