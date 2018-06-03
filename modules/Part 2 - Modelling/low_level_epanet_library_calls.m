%% Select benchmark network
inputNetwork = 'Net1.inp';
inputNetworkPath=which(inputNetwork);

%% Load EPANET Library
libName = load_epanet_library();

% display library's functions 
libfunctions(libName, '-full') 

% get EPANET version name
% [int32, int32Ptr] ENgetversion(int32Ptr)
[err, epanetVersion] = calllib(libName, 'ENgetversion',0);
disp(epanetVersion)

% check example error code
% https://github.com/OpenWaterAnalytics/EPANET/wiki/Error-Codes
% [int32, cstring] ENgeterror(int32, cstring, int32)
err = 251;
[err, errorText] = calllib(libName, 'ENgeterror',err,char(32*ones(1,79)),79);
disp(errorText)

%open network file, set output file eg. net1.inp 
% [int32, cstring, cstring, cstring] ENopen(cstring, cstring, cstring)
% https://github.com/OpenWaterAnalytics/EPANET/wiki/ENopen
[err, inputFile, reportFile, binaryFile] = calllib(libName, 'ENopen', inputNetworkPath,'Net1.rpt','Net1.bin'); 

%run hydraulic simulation and save in output file 
% int32 ENsolveH
err = calllib(libName,'ENsolveH'); 

%run quality simulations and save in output file (after ENsolveH) 
% int32 ENsolveQ
% https://github.com/OpenWaterAnalytics/EPANET/wiki/ENsolveQ
err = calllib(libName,'ENsolveQ'); 

% get the number of nodes
% https://github.com/OpenWaterAnalytics/EPANET/wiki/ENgetcount
[err nodesCount] = calllib(libName,'ENgetcount', 0,0);

% get the number of links
[err linksCount] = calllib(libName,'ENgetcount', 2,0);

% Write a formatted text report on simulation results to the Report file.
% https://github.com/OpenWaterAnalytics/EPANET/wiki/ENreport
err = calllib(libName,'ENreport');

% Close down the Toolkit system (including all files being processed).
% https://github.com/OpenWaterAnalytics/EPANET/wiki/ENclose
err = calllib(libName, 'ENclose');

% unload library 
err = unload_epanet_library(libName);