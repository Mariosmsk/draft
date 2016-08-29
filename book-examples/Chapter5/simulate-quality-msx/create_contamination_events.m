function [output] = create_contamination_events(input)
%CREATE_CONTAMINATION_EVENTS - One line description of what the function or script performs (H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%
% Syntax:  [output] = create_contamination_events(input)
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

NodesResultsIndices=d.getNodeIndex(settings.nodes_results);
for i=1:settings.num_scenarios
    if i>1;  d.unloadMSX; end
    d.loadMSXFile(settings.msx_info.msxFile);
    p1=zeros(1,d.getTimeSimulationDuration/3600);
    p2=zeros(1,d.getTimeSimulationDuration/3600);
    p1(settings.scenarios{i}.StartTime(1):settings.scenarios{i}.EndTime(1))=settings.scenarios{i}.magnitude(1);
    p2(settings.scenarios{i}.StartTime(2):settings.scenarios{i}.EndTime(2))=settings.scenarios{i}.magnitude(2);
    
    pat1=d.addMSXPattern([num2str(i),'p1'],p1);
    pat2=d.addMSXPattern([num2str(i),'p2'],p2);
    nodeIndex1 = d.getNodeIndex(settings.scenarios{i}.nodes_id(1));
    specIndex1 = 2; % suppose is index 1 %Chlorine
    type = 0;
    level = settings.scenarios{i}.magnitude(1);
    d.setMSXSources(nodeIndex1, specIndex1, type, level, pat1)
    nodeIndex2 = d.getNodeIndex(settings.scenarios{i}.nodes_id(2));
    specIndex2 = 3; % THMs
    level = settings.scenarios{i}.magnitude(2);
    d.setMSXSources(nodeIndex2, specIndex2, type, level, pat2)

    nn=d.getMSXComputedQualityNode;
    C1{i}.Scenarios = settings.scenarios{i};
    C2{i}.Scenarios = settings.scenarios{i};
    C1{i}.NodesResults = settings.nodes_results;
    C2{i}.NodesResults = settings.nodes_results;
    for u=1:length(NodesResultsIndices)
        C1{i}.disinfectant{u} = nn.Quality{NodesResultsIndices(u)}{specIndex1};
        C2{i}.contaminant{u} = nn.Quality{NodesResultsIndices(u)}{specIndex2};
    end
    disp(i);
end

d.unloadMSX;
d.unload;
results.Chlorine=C1;
results.THMs=C2;
output = savejson(results);

%------------- END OF CODE --------------
