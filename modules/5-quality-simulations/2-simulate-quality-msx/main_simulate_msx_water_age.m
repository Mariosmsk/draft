settings=[];
settings.filename = 'Net1.inp';
settings.simulation_time=24; % seconds

d = epanet(settings.filename); 
d.setTimeSimulationDuration(settings.simulation_time*3600);
d.saveInputFile(d.BinTempfile);
d.loadEPANETFile(d.BinTempfile);

out_msx = create_msx_file_water_age;%(input);
d.writeMSXFile(out_msx)
settings.msxfilename = out_msx.msxFile;
d.loadMSXFile(settings.msxfilename,d.LibEPANETpath)

%% Run Module
compQualLinks=d.getMSXComputedQualityLink;
compQualNodes=d.getMSXComputedQualityNode;
WAnodes=[];WAlinks=[];
for i=1:d.NodeCount
    WAnodes(:,i) = compQualNodes.Quality{i}{1};
end
for i=1:d.LinkCount
    WAlinks(:,i) = compQualLinks.Quality{i}{1};
end
delete(which(settings.msxfilename));
d.unloadMSX;
d.unload;

%% Plot graph
figure;
plot(WAnodes)
grid on
title('Water Age for Nodes');
xlabel('Time (hour)')
ylabel('Hours')
legend(d.NodeNameID)

figure;
plot(WAlinks)
grid on
title('Water Age for Links');
xlabel('Time (hour)')
ylabel('Hours')
legend(d.LinkNameID)

%------------- END OF CODE --------------