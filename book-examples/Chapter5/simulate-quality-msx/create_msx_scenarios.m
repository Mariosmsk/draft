function results = create_msx_scenarios(input)
%CREATE_MSX_SCENARIOS - One line description of what the function or script performs (H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%
% Syntax:  [output] = create_msx_scenarios(input)
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
% Other m-files required: simulate_chlorine_residuals
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author        : Demetrios G. Eliades, Marios Kyriakou
% Work address  : KIOS Research Center, University of Cyprus
% email         : eldemet@ucy.ac.cy
% Website       : http://www.kios.ucy.ac.cy
% Last revision : September 2016

%------------- BEGIN CODE --------------
tmp = loadjson(input); 
settings = tmp.settings;

for i=1:settings.num_scenarios
    %Nodes ID or random nodes ID
    b=0;
    sTime=randi(settings.simulation_time/3600,settings.num_nodesinj,2);
    while b==0
        if min(sTime(:,1))~=max(sTime(:,1)) || min(sTime(:,2))~=max(sTime(:,2))
            b=1;
        end
        sTime=randi(settings.simulation_time/3600,settings.num_nodesinj,2);
    end
    if isempty(settings.nodes_id)
        indexNodes=randperm(d.getNodeCount,settings.num_nodesinj);
        settings.nodes_id=d.NodeNameID(indexNodes);
    end

    results{i}.nodes_id = settings.nodes_id;
    results{i}.StartTime = [min(sTime(:,1)) min(sTime(:,2))];
    results{i}.EndTime = [max(sTime(:,1)) max(sTime(:,2))];
    results{i}.magnitude = settings.magnitude;
    
end
output = savejson(results);

%------------- END OF CODE --------------

  

