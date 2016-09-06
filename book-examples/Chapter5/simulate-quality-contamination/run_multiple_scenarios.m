function output = run_multiple_scenarios(input)
%RUN_MULTIPLE_SCENARIOS - One line description of what the function or script performs (H1 line)
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

B = input.B;
P = input.P;

T=100; %save every 1000 scenarios

B.setQualityType('chem','mg/L')
B.setTimeSimulationDuration(P.SimulationTime*3600);
% disp('Create Hydraulic files')
for i=1:size(P.ScenariosFlowIndex,1)
    B.setLinkDiameter(P.FlowParamScenarios{1}(:, P.ScenariosFlowIndex(i,1))')
    B.setLinkLength(P.FlowParamScenarios{2}(:, P.ScenariosFlowIndex(i,2))')
    B.setLinkRoughnessCoeff(P.FlowParamScenarios{3}(:, P.ScenariosFlowIndex(i,3))')
    B.setNodeElevations(P.FlowParamScenarios{4}(:, P.ScenariosFlowIndex(i,4))')
    B.setNodeBaseDemands({P.FlowParamScenarios{5}(:, P.ScenariosFlowIndex(i,5))'})
    if size(P.Patterns,1)==1
        B.setPatternMatrix(P.FlowParamScenarios{6}(:,P.ScenariosFlowIndex(i,6))')
    else
        B.setPatternMatrix(P.FlowParamScenarios{6}(:,:,P.ScenariosFlowIndex(i,6))')
    end
    B.solveCompleteHydraulics
    B.saveHydraulicFile(['hydfiles','.h',num2str(i)])
end

% disp('Create Quality files')
pstep=double(B.getTimePatternStep);
B.setTimeQualityStep(pstep);
zeroNodes=zeros(1,B.NodeCount);
B.setNodeInitialQuality(zeroNodes);
B.setLinkBulkReactionCoeff(zeros(1,B.LinkCount));
B.setLinkWallReactionCoeff(zeros(1,B.LinkCount));
for i=1:B.NodeCount
    B.setNodeSourceType(i,'SETPOINT');
end
patlen=(P.SimulationTime)*3600/pstep;
if sum(strcmp(fields(P),'newTotalofScenarios'))
    if P.newTotalofScenarios ~= P.TotalScenarios
        P.ScenariosFlowIndex=cartesianProduct(P.FlowScenarioSets);
        P.ScenariosContamIndex=cartesianProduct(P.ContamScenarioSets);
    end
end
sizeflowscenarios=size(P.ScenariosFlowIndex,1);
sizecontscenarios=size(P.ScenariosContamIndex,1);
% disp(['Hydraulic Scenarios: ', num2str(sizeflowscenarios), ', Quality Scenarios:',num2str(sizecontscenarios)])
SensingNodeIndices_NodeBaseDemands=unique([find(P.SensingNodeIndices),find(B.NodeBaseDemands{1})]);

l=0;
t0=1;
k=1;
for j=1:(sizeflowscenarios*sizecontscenarios)
    if mod(j,sizecontscenarios)==1
        l=l+1;
        tmphydfile=['hydfiles','.h',num2str(l)];
        B.useHydraulicFile(tmphydfile);
        disp(['Hydraulic Scenario ',num2str(l)])
        st2=0;
        avtime=inf;
        D{l}=B.getComputedQualityTimeSeries('time','demandSensingNodes',SensingNodeIndices_NodeBaseDemands);
        i=1;
    end
    disp(['Scenario: ',num2str(i)])
    t1=tic;
    tmppat=zeros(1,patlen);
    tmpstartstep=P.SourceTimes(P.ScenariosContamIndex(i,4));
    tmpendstep=tmpstartstep+round(P.SourceParamScenarios{2}(P.ScenariosContamIndex(i,2))*3600/pstep)-1;
    tmppat(tmpstartstep:tmpendstep)=1;
    tmp1=B.addPattern('CONTAMINANT',tmppat);
    tmpinjloc=P.SourceLocationScenarios{P.ScenariosContamIndex(i,3)};
    tmp2=zeroNodes;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if tmpinjloc~=0
        tmp2(tmpinjloc)=tmp1;
        B.setNodeSourcePatternIndex(tmp2);
        tmp2 = zeroNodes;
        tmp2(tmpinjloc)=P.SourceParamScenarios{1}(P.ScenariosContamIndex(i,1));
        B.setNodeSourceQuality(tmp2)
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    C{k}=B.getComputedQualityTimeSeries('qualitySensingNodes',SensingNodeIndices_NodeBaseDemands);
    d(k)=l;
    t2=toc(t1);
    st2=st2+t2;
    avtime=st2/i;
    i=i+1;  
    if mod(j,T)==0;
        t0=t0+1;
        k=1;
    else
        k=k+1;
    end
end
B.unload;
for i=1:l
    delete(which(['hydfiles.h',num2str(i)]))
end
output.C = C;

%------------- END OF CODE --------------