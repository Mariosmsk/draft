function output = default_parameters(input)
%DEFAULT_PARAMETERS - One line description of what the function or script performs (H1 line)
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
tmp = loadjson(input); 
settings = tmp.settings;

d = epanet(settings.filename);

IM{1}.SensorThreshold=0.3; %mg/L 
  
sizeflowscenarios=size(P.ScenariosFlowIndex,1);
sizecontscenarios=size(P.ScenariosContamIndex,1);

if strcmpi(SimulateMethod,'grid')
    totalscenarios=sizeflowscenarios*sizecontscenarios;
elseif strcmpi(SimulateMethod,'random')
    totalscenarios=P.newTotalofScenarios;
end
disp('Compute Impact Matrix')
Dt=double(B.TimeHydraulicStep)/60; % time step in minutes
T=inf*ones(sizeflowscenarios*sizecontscenarios,B.CountNodes);
W{1}=inf*ones(totalscenarios,B.CountNodes);
%W{2}=inf*ones(sizeflowscenarios*sizecontscenarios,B.CountNodes);
for i=1:length(D)
    demand{i}=zeros(size(D{1}.Demand,1),size(D{1}.Demand,2));
    demand{i}(:,B.NodeJunctionIndex)=D{i}.Demand(:,B.NodeJunctionIndex);
    demand{i}(find(demand{i}<0))=0;
end

l=0;pp=1;
for i=1:t0
    if exist([pathname,file0,'.c',num2str(i)])==2
        try
            load([pathname,file0,'.c',num2str(i)],'-mat')
        catch err
            break
        end

        for k=1:size(C,2)
            c=C{k}.Quality;             
            l=l+1;
            %Contaminated Water Consumption Volume
            c1=c;
            c1(find(c1<=IM{1}.SensorThreshold))=0;
            c1(find(c1>IM{1}.SensorThreshold))=1;
            detectionNodes=find(sum(c1));
            cwv=c1.*Dt.*demand{d(k)}; %D{d(k)}.Demand.*Dt;
            for j=detectionNodes
                [a tmp]=max(c1(:,j));
                W{1}(l,j)=sum(sum(cwv(1:tmp,1:B.CountNodes)));
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if isstruct(varargin{1}) 
                if mod(pp,100)==1
                    nload=pp/(totalscenarios); 
                    varargin{1}.color=char('red');
                    progressbar(varargin{1},nload)
                end
                pp=pp+1;
            end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
            try
                W{1}(l,find(W{1}(l,:)==inf))=sum(sum(cwv(1:size(cwv,1),1:B.CountNodes))); 
            catch err
            end
        end
        clear C;
        W{1}(:,find(P.SensingNodeIndices==0))=0;
        save([pathname,file0,'.w'],'W', 'IM', '-mat');
    end
end

output = P;
% output = savejson(P);

%------------- END OF CODE --------------