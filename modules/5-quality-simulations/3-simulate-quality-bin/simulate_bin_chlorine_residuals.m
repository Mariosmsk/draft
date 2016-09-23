function output = simulate_bin_chlorine_residuals(input)
%SIMULATE_BIN_CHLORINE_RESIDUALS - One line description of what the function or script performs (H1 line)
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

% Author        : Demetrios G. Eliades, Marios Kyriakou
% Work address  : KIOS Research Center, University of Cyprus
% email         : eldemet@ucy.ac.cy
% Website       : http://www.kios.ucy.ac.cy
% Last revision : September 2016

%------------- BEGIN CODE --------------
tmp = loadjson(input); 
settings = tmp.settings;

d = epanet(settings.filename);
d.setBinTimeSimulationDuration(settings.duration*3600);
d.setBinQualType(settings.species,settings.units);
CN = d.getBinComputedNodeQuality;
CL = d.getBinComputedLinkQuality;
d.BinClose;
d.unload
results.ChlorineNodes=CN;
results.ChlorineLinks=CL;
results.Network=d;
output = savejson(results);

%------------- END OF CODE --------------