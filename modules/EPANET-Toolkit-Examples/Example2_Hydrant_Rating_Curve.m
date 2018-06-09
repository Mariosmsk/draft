% https://github.com/OpenWaterAnalytics/EPANET/wiki/Example-2

%% Select benchmark network
inputNetwork = 'Net1.inp';
inputNetworkPath=which(inputNetwork);

%% Select node of interest
MyNode = '32';

%% Select number of iterations
r = 1:0.5:10;
N = length(D);

%% Load EPANET Library
libName = load_epanet_library();

%open network file, set output file eg. net1.inp 
% [int32, cstring, cstring, cstring] ENopen(cstring, cstring, cstring)
% https://github.com/OpenWaterAnalytics/EPANET/wiki/ENopen
[err, inputFile, reportFile, binaryFile] = calllib(libName, 'ENopen', inputNetworkPath,'Net1.rpt','Net1.bin'); 

err = calllib(libName,'ENopenH');

[err, nodeID, nodeIndex] = calllib(libName,'ENgetnodeindex', MyNode, 0);

EN_BASEDEMAND = 1;
EN_PRESSURE = 11;

[err, B] = calllib(libName,'ENgetnodevalue',nodeIndex, EN_BASEDEMAND, 0);
D = B.*r;

%%
for i = 1:N
     err = calllib(libName,'ENsetnodevalue',nodeIndex, EN_BASEDEMAND, D(i));
     err = calllib(libName,'ENinitH',0);
     [err, t]=calllib(libName,'ENrunH',int32(0));
     [err, P(i)] = calllib(libName,'ENgetnodevalue',nodeIndex, EN_PRESSURE, 0);
end

err = calllib(libName, 'ENcloseH');
err = calllib(libName, 'ENclose');

unload_epanet_library(libName)

plot(D,P,'-x')  
xlabel('Base Demand')
ylabel('Pressure')