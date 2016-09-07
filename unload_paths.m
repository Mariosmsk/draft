function [output] = unload_paths()
%UNLOAD_PATHS Unloads all the folder paths from the memory. 
%Run this function when change any folder name.
%
% Syntax:  unload_paths()
%
% Inputs:
%    none
%
% Outputs:
%    output - Paths unloaded.
%
% Example: 
%    unload_paths()
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author        : Demetrios G. Eliades, Marios Kyriakou
% Work address  : KIOS Research Center, University of Cyprus
% email         : eldemet@ucy.ac.cy, mkiria01@ucy.ac.cy
% Website       : http://www.kios.ucy.ac.cy
% Last revision : September 2016

%------------- BEGIN CODE --------------
rmpath(genpath(pwd))
output = 'Paths unloaded.';    
%------------- END OF CODE --------------


