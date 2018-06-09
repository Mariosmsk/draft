function msx = create_msx_file(input)
%CREATE_MSX_FILE - One line description of what the function or script performs (H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%
% Syntax:  [output] = create_msx_file(input)
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
% tmp = loadjson(input); 

% Input Arguments
msx={};
msx.msxFile = 'MsxFileName.msx';
% section Title
msx.titleDescription{1} = 'Example: Contamination detection algorithm.';
% section Options
msx.options{1}='FT2'; %AREA_UNITS FT2/M2/CM2
msx.options{2}='DAY'; %TIME_UNITS SEC/MIN/HR/DAY
msx.options{3}='EUL'; %SOLVER EUL/RK5/ROS2
msx.options{4}='NONE'; %COUPLING FULL/NONE
msx.options{5}='NONE'; %COMPILER NONE/VC/GC
msx.options{6}=3600; %TIMESTEP in seconds
msx.options{7}=0.01;  %ATOL value
msx.options{8}=0.001;  %RTOL value
% section Species
% <type> <specieID> <units> (<atol> <rtol>)
msx.species{1}={'BULK','BULK','BULK','BULK'}; %type BULK/WALL
msx.species{2}={'AGE','Chlorine','THMs','TOC'}; %specieID
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
msx.pipes{3} ={'24','-Kb*Chlorine - (4/D)*Kw*Kf/(Kw+Kf)*Chlorine','Y*Kb*Chlorine*1000','0'}; %expression

% section Tanks
% EQUIL <specieID> <expression>
% RATE <specieID> <expression>
% FORMULA <specieID> <expression>
msx.tanks{1} ={'RATE','RATE','RATE','RATE'}; %type
msx.tanks{2} ={'AGE','Chlorine','THMs','TOC'}; %specieID
msx.tanks{3} ={'24','-Kb*Chlorine','Y*Kb*Chlorine*1000','0'}; %expression

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

% output = savejson(results);

%------------- END OF CODE --------------

  

