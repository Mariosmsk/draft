% Dll name
LibEPANET = 'epanet2';

% Load the EPANET dynamic link library
loadlibrary(LibEPANET, [LibEPANET,'.h']); 

% Check if library is loaded
if libisloaded(LibEPANET)
    disp('EPANET loaded sucessfuly.');
else
    disp('There was an error loading the EPANET library (DLL).')
end

% Input file name
inpname = 'Net1.inp';
repname = ''; binname = '';
Errcode=calllib(LibEPANET,'ENopen',which(inpname),repname,binname);
if Errcode
   [~,errmsg] = calllib(LibEPANET,'ENgeterror',Errcode,char(32*ones(1,79)),79);
   warning(errmsg);
end

% Node Count - count code is zero
countcode = 0; 
[Errcode,count]=calllib(LibEPANET,'ENgetcount',countcode,0);
disp(['Node Count: ',num2str(count)]);