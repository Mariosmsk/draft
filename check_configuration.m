% Check Setup
computerArchitecture = computer('arch');
if strcmpi(computerArchitecture,'win64')
    compilerName = compiler_Name();
    if ~strcmp(compilerName,'Microsoft Windows SDK 7.1 (C)')
        disp('You need to select the "Microsoft Windows SDK 7.1 (C)" compiler for the C language in MATLAB')
        disp('To do this, you need to download the "Microsoft Windows SDK 7.1 (C)" using this link:')
        disp('***insert link***')
        disp('In case you get an error, you may need to install this package')
        disp('***insert link***')
        disp('Afterwards, you need to execute the command')
        disp('mex -setup') 
        disp('and select "Microsoft Windows SDK 7.1 (C)" as the compiler') 
    else
        disp('The correct compiler has been selected: "Microsoft Windows SDK 7.1 (C)"')
    end
elseif strcmpi(computerArchitecture(1:4),'glnx')
    disp('In Linux, you need to copy the EPANET shared object in the /lib64/ folder')
    disp('1. cd ./EPANET-MATLAB-2.1/glnx/')
    disp('2. tar -xzf libepanet.tar.gz')
    disp('3. mv libepanet.so /lib64/libepanet.so')
    disp('***insert instructions for MSX***')
end

