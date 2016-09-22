function msx = create_msx_file_water_age(input)
%CREATE_MSX_FILE_WATER_AGE - One line description of what the function or script performs (H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%
% Syntax:  [output] = create_msx_file_water_age(input)
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

% Input Arguments
msx={};
msx.msxFile = 'water_age.msx';
% section Title
msx.titleDescription{1} = 'Example: Water Age.';
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
msx.species{1}={'BULK'}; %type BULK/WALL
msx.species{2}={'AGE'}; %specieID
msx.species{3}={'HR'}; %units UG/MG
msx.species{4}={0.01}; %atol
msx.species{5}={0.001}; %rtol

% section Pipes
% EQUIL <specieID> <expression>
% RATE <specieID> <expression>
% FORMULA <specieID> <expression>
msx.pipes{1} ={'RATE'}; %type
msx.pipes{2} ={'AGE'}; %specieID
msx.pipes{3} ={'24'}; %expression

% section Tanks
% EQUIL <specieID> <expression>
% RATE <specieID> <expression>
% FORMULA <specieID> <expression>
msx.tanks{1} ={'RATE'}; %type
msx.tanks{2} ={'AGE'}; %specieID
msx.tanks{3} ={'24'}; %expression

%------------- END OF CODE --------------

  

