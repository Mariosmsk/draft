function [output] = load_paths()
%LOAD_PATHS Loads all the folder paths in the memory. 
%Run this function before executing the book examples.
%
% Syntax:  load_paths()
%
% Inputs:
%    none
%
% Outputs:
%    output - String of paths in Matlab memory.
%
% Example: 
%    load_paths()
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

output=addpath(genpath(pwd));
    
%------------- END OF CODE --------------


