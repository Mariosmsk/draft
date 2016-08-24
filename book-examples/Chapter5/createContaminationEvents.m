function C = createContaminationEvents(d,S,msx,NodesRes)
% Create Contamination Events

NodesResIndex=d.getNodeIndex(NodesRes);
for i=1:length(S)
    if i>1;  d.unloadMSX; end
    d.loadMSXFile(msx.msxFile);
    p1=zeros(1,d.getTimeSimulationDuration/3600);
    p2=zeros(1,d.getTimeSimulationDuration/3600);
    p1(S{i}.StartTime(1):S{i}.EndTime(1))=S{i}.magnitude(1);
    p2(S{i}.StartTime(2):S{i}.EndTime(2))=S{i}.magnitude(2);
    
    pat1=d.addMSXPattern([num2str(i),'p1'],p1);
    pat2=d.addMSXPattern([num2str(i),'p2'],p2);
    nodeIndex1 = d.getNodeIndex(S{i}.nodesID(1));
    specIndex1 = 2; % suppose is index 1
    type = 0;
    level = S{i}.magnitude(1);
    d.setMSXSources(nodeIndex1, specIndex1, type, level, pat1)
    nodeIndex2 = d.getNodeIndex(S{i}.nodesID(2));
    specIndex2 = 3;
    level = S{i}.magnitude(2);
    d.setMSXSources(nodeIndex2, specIndex2, type, level, pat2)

    nn=d.getMSXComputedQualityNode;
    C{i}.Scenarios = S{i};
    C{i}.NodesRes = NodesRes;
    for u=1:length(NodesResIndex)
        C{i}.disinfectant{u} = nn.Quality{NodesResIndex(u)}{specIndex1};
        C{i}.contaminant{u} = nn.Quality{NodesResIndex(u)}{specIndex2};
    end
    i
end






