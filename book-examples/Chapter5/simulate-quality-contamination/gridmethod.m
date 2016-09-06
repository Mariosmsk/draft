function output = gridmethod(input)
%GRIDMETHOD - One line description of what the function or script performs (H1 line)
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
FlowScenarioSets={};
ContamScenarioSets={};
P=input.P;

%compute scenarios affecting flows
for i=1:length(P.FlowParameters)
    P.FlowParamScenarios{i}=linspaceNDim((P.FlowValues{i}-(P.FlowPrc{i}/100).*P.FlowValues{i})', (P.FlowValues{i}+(P.FlowPrc{i}/100).*P.FlowValues{i})', P.FlowSamples{i});
    if find(strcmp(P.FlowParameters{i},'Patterns'))
        if (size(P.Patterns,1)==1)
            FlowScenarioSets{i}=1:size(P.FlowParamScenarios{i},2);
        else
            FlowScenarioSets{i}=1:size(P.FlowParamScenarios{i},3);
        end
    else
        FlowScenarioSets{i}=1:size(P.FlowParamScenarios{i},2);
    end
end
%compute scenarios affecting contamination sources
for i=1:length(P.SourceParameters)
    P.SourceParamScenarios{i}=linspaceNDim((P.SourceValues{i}-(P.SourcePrc{i}/100).*P.SourceValues{i})', (P.SourceValues{i}+(P.SourcePrc{i}/100).*P.SourceValues{i})', P.SourceSamples{i});
    ContamScenarioSets{i}=1:size(P.SourceParamScenarios{i},1);
end   
%compute all source locations
k=1;
for i=1:P.SourcesMaxNumber
    tmp=combnk(P.SourcesNodeIndices,i);
    for j=1:size(tmp,1)
        T(k)={tmp(j,:)};
        k=k+1;
    end
end
P.SourceLocationScenarios=T;
ContamScenarioSets{size(ContamScenarioSets,2)+1}=1:size(P.SourceLocationScenarios,2);

tmpsteps=(P.SourcesInjectionTimes(2)-P.SourcesInjectionTimes(1))*3600/P.PatternTimeStep;
psim=double(P.SimulationTime);
pts=double(P.PatternTimeStep);
P.SourceTimes=min(find(pts/3600*(0:(psim-(pts/3600)))>=P.SourcesInjectionTimes(1))):max(find(pts/3600*(0:(psim-(pts/3600)))<=P.SourcesInjectionTimes(2)));
ContamScenarioSets{size(ContamScenarioSets,2)+1}=1:length(P.SourceTimes);

P.ScenariosFlowIndex=cartesianProduct(FlowScenarioSets);
P.ScenariosContamIndex=cartesianProduct(ContamScenarioSets);
P.TotalScenarios=size(P.ScenariosFlowIndex,1)*size(P.ScenariosContamIndex,1);        

output.P = P;
% output = savejson(P);

%------------- END OF CODE --------------