settings=[];
settings.filename = 'Net3_MSXexample.inp'; % net2-cl2
settings.msxfilename = 'Net3_two_source_chlorine_decay.msx'; % net2-cl2
% settings.index = [1:97]; %node or link index
settings.figure = 1;
settings.duration = 700;
%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_msx_two_source(input);
results = output;

% nodes
u=ones(1,5); pp1n=[]; pp2n=[]; pp3n=[]; pp4n=[]; pp5n=[];
for i=1:length(results.nodeID)
    ppNodesvalue(i) = mean(results.compQualNodes.Quality{i}{1});
    if ppNodesvalue(i)<0.2
        pp1n{u(1)}=results.nodeID{i}; u(1)=u(1)+1;
    end
    if ppNodesvalue(i)>0.2 && ppNodesvalue(i)<0.4
        pp2n{u(2)}=results.nodeID{i}; u(2)=u(2)+1;
    end
    if ppNodesvalue(i)>0.4 && ppNodesvalue(i)<0.6
        pp3n{u(3)}=results.nodeID{i}; u(3)=u(3)+1;
    end
    if ppNodesvalue(i)>0.6 && ppNodesvalue(i)<0.8
        pp4n{u(4)}=results.nodeID{i}; u(4)=u(4)+1;
    end
    if ppNodesvalue(i)>0.8
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
for i=1:length(results.linkID)
    ppLinksvalue(i) = mean(results.compQualLinks.Quality{i}{1});
    if ppLinksvalue(i)<0.2
        pp1{u(1)}=results.linkID{i}; u(1)=u(1)+1;
    end
    if ppLinksvalue(i)>0.2 && ppLinksvalue(i)<0.4
        pp2{u(2)}=results.linkID{i}; u(2)=u(2)+1;
    end
    if ppLinksvalue(i)>0.4 && ppLinksvalue(i)<0.6
        pp3{u(3)}=results.linkID{i}; u(3)=u(3)+1;
    end
    if ppLinksvalue(i)>0.6 && ppLinksvalue(i)<0.8
        pp4{u(4)}=results.linkID{i}; u(4)=u(4)+1;
    end
    if ppLinksvalue(i)>0.8
        pp5{u(5)}=results.linkID{i}; u(5)=u(5)+1;
    end    
end
c1 = cell(1,length(pp1)); c1(:) = {'b'};
c2 = cell(1,length(pp2)); c2(:) = {'c'};
c3 = cell(1,length(pp3)); c3(:) = {'g'};
c4 = cell(1,length(pp4)); c4(:) = {'y'};
c5 = cell(1,length(pp5)); c5(:) = {'r'};
  
h=results.d.plot('highlightlink',[pp1 pp2 pp3 pp4 pp5],'colorlink',[c1 c2 c3 c4 c5],...
    'highlightnode',[pp1n pp2n pp3n pp4n pp5n],'colornode',[c1n c2n c3n c4n c5n],'nodes','yes');
h2=results.d.plot('highlightlink',[pp1 pp2 pp3 pp4 pp5],'colorlink',[c1 c2 c3 c4 c5],...
    'highlightnode',[pp1n pp2n pp3n pp4n pp5n],'colornode',[c1n c2n c3n c4n c5n]);

results.d.unloadMSX
results.d.unload

% for u=1:length(results.nodeID)
%     figure;cmap=hsv(5);
%     for i=1:results.MSXSpeciesCount
%         plot(results.compQualNodes.Time,results.compQualNodes.Quality{settings.index(u)}{i},'Color',cmap(i,:));
%         hold on; 
%     end
%     legend(results.MSXSpeciesNameID);
%     title(['NODE ',char(results.nodeID(u))]);
%     ylabel('Quantity');
%     xlabel('Time(sec)');
% end
% 
% for u=1:length(results.linkID)
%     figure;cmap=hsv(5);
%     for i=1:results.MSXSpeciesCount
%         plot(results.compQualLinks.Time,results.compQualLinks.Quality{settings.index(u)}{i},'Color',cmap(i,:));
%         hold on; 
%     end
%     legend(results.MSXSpeciesNameID);
%     title(['LINK ',char(results.linkID(u))]);
%     ylabel('Quantity');
%     xlabel('Time(sec)');
% end

%------------- END OF CODE --------------