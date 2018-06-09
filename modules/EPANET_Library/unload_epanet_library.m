function [output] = unload_epanet_library(libraryName)

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

%% Unload the EPANET library
if ~isempty(libraryName)
    try 
        unloadlibrary(libraryName)
    end
else
    try 
        unloadlibrary('epanet2')
    end
    try 
        unloadlibrary('libepanet')
    end
end

disp('EPANET library is unloaded')
%return the name of the loaded library (epanet2 in Windows, libepanet in
%Linux)
output = 0;
%------------- END OF CODE --------------
end
