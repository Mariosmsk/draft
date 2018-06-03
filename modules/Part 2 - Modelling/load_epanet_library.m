function [output] = load_epanet_library()

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
% Work address  : KIOS Research and Innovation Center of Excellence, University of Cyprus
% email         : eldemet@ucy.ac.cy
% Website       : http://www.kios.ucy.ac.cy
% Last revision : 

%------------- BEGIN CODE --------------

warning off

%% Try to unload the libary in case this was loaded previously and was not unloaded from the memory
%Windows
try 
    unload_epanet_library()
end


%% Load Library
% Specify computer architecture/operating system to select the appropriate
% path and library
computerArchitecture = computer('arch');
pathClass = fileparts(which('epanet.m'));
if strcmpi(computerArchitecture,'win64')
    libraryPath = [pathClass,'/64bit/'];
    libraryName = 'epanet2';
elseif strcmpi(computerArchitecture,'win32')
    libraryPath = [pathClass,'/32bit/'];
    libraryName = 'epanet2';
elseif strcmpi(computerArchitecture(1:4),'glnx')
    libraryPath = [pathClass,'/glnx/'];
    libraryName = 'libepanet';
end

%% Load the EPANET library
loadlibrary([libraryPath,libraryName], [libraryPath,libraryName,'.h']); 

%% Check if library is loaded
if libisloaded(libraryName)
    disp('EPANET loaded sucessfuly.');
else
    disp('There was an error loading the EPANET library.')
end

%return the name of the loaded library (epanet2 in Windows, libepanet in
%Linux)
output = [libraryName];
%------------- END OF CODE --------------
end
