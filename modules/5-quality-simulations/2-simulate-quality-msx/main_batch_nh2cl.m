clear all;close all;clc;
settings.filename = 'batch-nh2cl.inp'; 
settings.msxfilename = 'batch-nh2cl.msx'; 
% Trace River
settings.duration = 168;
%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_batch_nh2cl(input);
results = output;

% load results.mat
% nodes
u=ones(1,5); pp1n=[]; pp2n=[]; pp3n=[]; pp4n=[]; pp5n=[];
ppNodesvalue=[];
for i=1:length(results.nodeID)
    ppNodesvalue(i) = mean(results.compQualNodes.Quality{i}{1});
    if ppNodesvalue(i)<0.2
        pp1n{u(1)}=results.nodeID{i}; u(1)=u(1)+1;
    end
    if ppNodesvalue(i)>=0.2 && ppNodesvalue(i)<0.4
        pp2n{u(2)}=results.nodeID{i}; u(2)=u(2)+1;
    end
    if ppNodesvalue(i)>=0.4 && ppNodesvalue(i)<0.6
        pp3n{u(3)}=results.nodeID{i}; u(3)=u(3)+1;
    end
    if ppNodesvalue(i)>=0.6 && ppNodesvalue(i)<0.8
        pp4n{u(4)}=results.nodeID{i}; u(4)=u(4)+1;
    end
    if ppNodesvalue(i)>=0.8
        pp5n{u(5)}=results.nodeID{i}; u(5)=u(5)+1;
    end    
end
c1n = cell(1,length(pp1n)); c1n(:) = {'b'};
c2n = cell(1,length(pp2n)); c2n(:) = {'c'};
c3n = cell(1,length(pp3n)); c3n(:) = {'g'};
c4n = cell(1,length(pp4n)); c4n(:) = {'y'};
c5n = cell(1,length(pp5n)); c5n(:) = {'r'};
 
% links
u=ones(1,5); pp1=[]; pp2=[]; pp3=[]; pp4=[]; pp5=[];
ppLinksvalue=[];
for i=1:length(results.linkID)
    ppLinksvalue(i) = mean(results.compQualLinks.Quality{i}{1});
    if ppLinksvalue(i)<0.2
        pp1{u(1)}=results.linkID{i}; u(1)=u(1)+1;
    end
    if ppLinksvalue(i)>=0.2 && ppLinksvalue(i)<0.4
        pp2{u(2)}=results.linkID{i}; u(2)=u(2)+1;
    end
    if ppLinksvalue(i)>=0.4 && ppLinksvalue(i)<0.6
        pp3{u(3)}=results.linkID{i}; u(3)=u(3)+1;
    end
    if ppLinksvalue(i)>=0.6 && ppLinksvalue(i)<0.8
        pp4{u(4)}=results.linkID{i}; u(4)=u(4)+1;
    end
    if ppLinksvalue(i)>=0.8
        pp5{u(5)}=results.linkID{i}; u(5)=u(5)+1;
    end    
end
c1 = cell(1,length(pp1)); c1(:) = {'b'};
c2 = cell(1,length(pp2)); c2(:) = {'c'};
c3 = cell(1,length(pp3)); c3(:) = {'g'};
c4 = cell(1,length(pp4)); c4(:) = {'y'};
c5 = cell(1,length(pp5)); c5(:) = {'r'};
  
% h=results.d.plot('highlightlink',[pp1 pp2 pp3 pp4 pp5],'colorlink',[c1 c2 c3 c4 c5],...
%     'highlightnode',[pp1n pp2n pp3n pp4n pp5n],'colornode',[c1n c2n c3n c4n c5n],'nodes','yes');
h2=results.d.plot('highlightlink',[pp1 pp2 pp3 pp4 pp5],'colorlink',[c1 c2 c3 c4 c5],...
    'highlightnode',[pp1n pp2n pp3n pp4n pp5n],'colornode',[c1n c2n c3n c4n c5n]);
% h2=results.d.plot('highlightlink',[pp1 pp2 pp3 pp4 pp5],'colorlink',[c1 c2 c3 c4 c5],...
%     'highlightnode',[pp1n pp2n pp3n pp4n pp5n],'colornode',[c1n c2n c3n c4n c5n],'links','yes');

results.d.unloadMSX
results.d.unload

%------------- END OF CODE --------------