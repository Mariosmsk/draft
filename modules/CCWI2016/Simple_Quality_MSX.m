clc
clear
path(path,strcat(pwd,'\toolkit\epanet'));
path(path,strcat(pwd,'\toolkit\epanet-msx')); 

ENopen('Network_1.inp')

SensorNodesID={'JUNCTION-17' 'JUNCTION-31' 'JUNCTION-45' 'JUNCTION-83' 'JUNCTION-122'};
SensorNodesIndex=ENgetnodeindex(SensorNodesID);

TD=4*2; % SIMULATION DAYS
TD0=5;
tduration=TD*24*60*60;
ENsettimeparam('DURATION',tduration)
%T0=TD0*288+1;

InjectionConcentration=[0.7];

MSXopen('Arsenite.msx')
MSXsolveH()
CLid= MSXgetindex('MSX_SPECIES', 'Chlorine');
AS3id= MSXgetindex('MSX_SPECIES', 'AsIII');
NodeId=32;
PAS3=zeros(1,2*24*TD);
PAS3(240:end)=1; %start on day 5
calllib('epanetmsx','MSXsetpattern',4,PAS3,length(PAS3));
calllib('epanetmsx','MSXsetsource',NodeId,MSXgetindex('MSX_SPECIES', 'AsIII'), ConstantsMSX('MSX_SETPOINT'),InjectionConcentration(1),4);
MSXinit(1)

[errorcode,tleft,t]=MSXstep();
KMAX=double(tleft/300);
%C=zeros(tleft/t,3*length(SensorNodesIndex)+1);
k=1;
perc=0.0;
h = waitbar(0,'Initializing waitbar...');
%tic
T00=tleft*TD0/TD;
while tleft>0
    XT(k)=t;
    for i=1:length(SensorNodesIndex)
        X{i}(k,1)=MSXgetqual('MSX_NODE', SensorNodesIndex(i), 1);
        X{i}(k,2)=MSXgetqual('MSX_NODE', SensorNodesIndex(i), 2);
        X{i}(k,3)=MSXgetqual('MSX_NODE', SensorNodesIndex(i), 3);
    end
    [errorcode,tleft,t]=MSXstep();
    k=k+1;
    perc=k/KMAX;
    waitbar(perc,h,sprintf('%d%% along... (%d/%d/%d)',floor(perc*100),1,length(1),1))  
end
%toc
close(h)
MSXclose()