%% EPANET-Matlab Class Test Part 2
% This file is provided to ensure that all functions can be executed
% correctly.
% Press F10 for step-by-step execution. You may also use the breakpoints, 
% indicated with a short dash (-) on the left of each line number.

% Execute "addpath(genpath(pwd))" in main folder before running this, to load all EPANET
% functions

clc;
clear;
close all;clear class;

% Create EPANET object using the INP file
inpname=which('Net2_Rossman2000.inp'); %Net2_Rossman2000 example
% inpname=which('Net2_Rossman2000.inp')

%% MSX Functions
d=epanet(inpname);
d.loadMSXFile([inpname(1:end-4),'.msx'])

%% MSX PLOTS
index=1;
nodesID=d.getNodeNameID;
linksID=d.getLinkNameID;
linkID=linksID(index);
nodeID=nodesID(index);

lll=d.getMSXComputedQualityLink
figure(1);subplot(2,2,1);cmap=hsv(5);for i=1:d.getMSXSpeciesCount;plot(lll.Time,lll.Quality{index}{i},'Color',cmap(i,:));hold on; end; legend(d.MSXSpeciesNameID)
title(['LINK ',char(linkID),' - 1st Way']);

nnn=d.getMSXComputedQualityNode
figure(1);subplot(2,2,2);cmap=hsv(5);for i=1:d.getMSXSpeciesCount;plot(nnn.Time,nnn.Quality{index}{i},'Color',cmap(i,:));hold on; end; legend(d.MSXSpeciesNameID)
title(['NODE ',char(nodeID),' - 1st Way']);

arg2=1:d.MSXSpeciesCount;
s=d.getMSXComputedQualityNode(index,arg2);
SpeciesNameID=d.getMSXSpeciesNameID;

%plot 3
figure(1);subplot(2,2,4);
for i=arg2
    specie(:,i)=s.Quality{i,1};
    time(:,i)=s.Time;
end
plot(time,specie);
title(['NODE ',char(nodeID),' - 2st Way']);
ylabel('Quantity');
xlabel('Time(s)');
legend(SpeciesNameID(arg2));

 
s=d.getMSXComputedQualityLink(index,arg2);
SpeciesNameID=d.getMSXSpeciesNameID;
figure(1);subplot(2,2,3);
for i=arg2
    specie(:,i)=s.Quality{i,1};
    time(:,i)=s.Time;
end
plot(time,specie);
title(['LINK ',char(linkID),' - 2st Way']);
ylabel('Quantity');
xlabel('Time(s)');
legend(SpeciesNameID(arg2));
            

d.unloadMSX

d.unload

