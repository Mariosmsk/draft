function output = simulate_msx_two_source(input)
%SIMULATE_MSX - One line description of what the function or script performs (H1 line)
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

% Create EPANET object using the INP file
tmp = loadjson(input); 
settings = tmp.settings;
d = epanet(settings.filename);
d.loadMSXFile(settings.msxfilename,d.LibEPANETpath)

nodeID=d.getNodeNameID;
linkID=d.getLinkNameID;

compQualLinks=d.getMSXComputedQualityLink;
compQualNodes=d.getMSXComputedQualityNode;

arg2=1:d.MSXSpeciesCount;
SpeciesNameID=d.getMSXSpeciesNameID;

results.arg2 = arg2;
results.linkID = linkID;
results.nodeID = nodeID;
results.MSXSpeciesCount = d.getMSXSpeciesCount;
results.MSXSpeciesNameID = d.MSXSpeciesNameID;
results.compQualLinks = compQualLinks;
results.compQualNodes = compQualNodes;
results.SpeciesNameID = SpeciesNameID;
results.d = d;

output = results;
% output = savejson(results);


%------------- END OF CODE --------------
