settings=[];
settings.filename = 'Net1.inp';

% Load epanet input file
d = epanet(settings.filename);

% tmpInd = randperm(d.NodeCount);
%Node Ingection
nodeinj = 2; %tmpInd(1);

% initial settings quality are zero
zeroNodes=zeros(1,d.NodeCount);
d.setNodeInitialQuality(zeroNodes);
% d.setLinkBulkReactionCoeff(zeros(1,d.LinkCount));
% d.setLinkWallReactionCoeff(zeros(1,d.LinkCount));

d.setNodeSourceType(nodeinj,'SETPOINT');
pstep = d.TimePatternStep/3600;
patlen=(d.TimeSimulationDuration/3600)/pstep;

% add pattern for contamination at node injection
tmppat=zeros(1,patlen);
tmpstartstep=1; % hour
tmpendstep=round(max(randperm(d.TimeSimulationDuration/3600)));
tmppat(tmpstartstep:tmpendstep)=1;
tmp1=d.addPattern('CONTAMINANT',tmppat);
tmp2 = d.getNodePatternIndex;
tmp2(nodeinj)=tmp1;
tmpQ=zeros(1,d.NodeCount);
tmpQ(nodeinj)=10;
d.setNodeSourcePatternIndex(tmp2);
d.setNodeSourceQuality(tmpQ)

% solve hydraulics and quality analisis
d.solveCompleteHydraulics;
C=d.getComputedQualityTimeSeries('quality','time');

% plots
figure;
plot(C.Time/3600,C.Quality);
grid on
title('Contaminant Concentration at Nodes');
xlabel('Time (hours)')
ylabel('Contaminant (mg/L)')
legend(d.NodeNameID);

%------------- END OF CODE --------------