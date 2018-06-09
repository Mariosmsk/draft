function [output] = f_y(x,z,c,G,s)
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
% Work address  : KIOS Research Center, University of Cyprus
% email         : eldemet@ucy.ac.cy
% Website       : http://www.kios.ucy.ac.cy
% Last revision : September 2016

%------------- BEGIN CODE --------------

output = [x.Tank_Volume(:,(s{1})), x.Tank_Volume(:,(s{1}+1)), x.Tank_Chlorine(:,(s{2}+1)), z.Junctions_Head(:,(s{3}+1)), z.Pipe_Flow(:,(s{4}+1)), c.Junctions_Chlorine(:,(s{5}+1))]';

%------------- END OF CODE --------------