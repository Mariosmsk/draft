function output = simulate_bin_water_age(input)
%SIMULATE_BIN_WATER_AGE - One line description of what the function or script performs (H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%
% Syntax:  [output] = simulate_water_age(input)
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

d = epanet(settings.filename);
d.setBinTimeSimulationDuration(settings.duration*3600);
d.setBinQualityAge;
CN = d.getBinComputedNodeQuality;
CL = d.getBinComputedLinkQuality;
d.BinClose;
d.unload
results.WaterAgeNodes=CN;
results.WaterAgeLinks=CL;
results.Network=d;
output = savejson(results);

%------------- END OF CODE --------------
