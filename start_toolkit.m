function start_toolkit()
%START_TOOLKIT Loads all the EPANET-MATLAB Toolkit folder paths in MATLAB. 
%Run this function before calling 'epanet.m' and the Matlab modules.
%
% Syntax:  start_toolkit
%
% Inputs:
%    none
%
% Outputs:
%    none
%
% Example: 
%    start_toolkit
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
% Last revision : 

%------------- BEGIN CODE --------------
clc
addpath(genpath(pwd));
disp('EPANET-MATLAB Toolkit paths been loaded.');
disp('Benchmark netwrosk paths have been loaded.');
disp('Move to ./modules/ folder to execute the functions'); 
%------------- END OF CODE --------------


