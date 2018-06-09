function [output] = data_structures()
%INTRODUCTION - One line description of what the function or script performs (H1 line)
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

%% Instructions
clc % clears everything in the Command Window
disp('Press F5 key to execute all code.') % disp('...') prints a message on the Command Window
disp('You can debug the code by pressing the "-" next to each line of code, to create a breakpoint. Press F5 to execute up to that point, and F10 for a step-by-step execution of the code.')


%% Data structures
% Create a vector array of node indices (integer numbers)
index = [1 2 3 5 6 8 11 13]

% You can avoid printing results in the Command Window by using the
% semicolon ";" at the end of each line.

index_noshow = index;

% Return the 3rd element of the vector
index(3)

% Return 3rd to 5th elements
index(3:5)

% Change the 4th element as unknown (i.e. Not-a-Number or NaN)

index(4) = NaN

% Change the 5th and 6th elements as infinite

index(5:6) = Inf

% Return last 2 elements
index(end-1:end)

% Create a matrix of three daily demand flow patterns with 2-hour time-step
patterns = [0.8 1.0 1.1 1.3 1.3 1.4 1.4 1.3 1.2 1.0 0.9 0.8;
            0.9 0.9 1.0 1.0 1.1 1.1 1.1 1.2 1.2 1.1 1.0 0.9;
            0.7 0.7 0.7 1.1 1.3 1.7 1.7 1.7 1.7 1.7 1.1 0.9]

% Transpose the matrix 

patterns_transpose = patterns'
        
% Create a time vector for the patterns, starting at hour 0 and ending at
% hour 22, with 2-hour time-step

pattern_time = 0:2:22

% Create a cell array of node IDs (strings of text)
ids = {'10', '11', '12', '13', '21'}

% Return 3rd to last element
ids(3:end)

% Change id of '10' to 'Node10'

ids(1) = strcat('Node', ids(1))

% Create Structure

output.ids = ids;
output.index = index;
output.index_noshow = index_noshow;
output.pattern_time = pattern_time;
output.patterns = patterns;

disp(output)
disp(output.ids{1})

% to find our how 'strcat' works, write 'help strcat' in the Command Window
doc strcat % you can used "help strcat" as well
help strcat

%%



%------------- END OF CODE --------------