function output = simulate_quality_contamination(input)
%SIMULATE_QUALITY_CONTAMINATION - One line description of what the function or script performs (H1 line)
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
d.setQualityType(settings.species)
d.solveCompleteHydraulics;
C = d.getComputedQualityTimeSeries('time','quality');
d.unload
results.Chlorine=C;
results.Network=d;
output = savejson(results);

%------------- END OF CODE --------------