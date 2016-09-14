settings=[];
settings.filename = 'Net3.inp'; % net2-cl2
settings.msxfilename = 'Net3_two_source_chlorine_decay.msx'; % net2-cl2
settings.index = [1:97]; %node or link index
settings.figure = 1;
%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_msx(input);
results = output;

% %% Extract output from JSON
% tmp = loadjson(output);
% results=tmp.results;
u=ones(1,4); clear pp1 pp2 pp3 pp4
for i=1:length(results.nodeID)
    ppNodesvalue(i) = results.compQualNodes.Quality{i}{1}(end);
    if ppNodesvalue(i)<0.2
        pp1{u(1)}=results.linkID{i}; u(1)=u(1)+1;
    end
    if ppNodesvalue(i)>0.2 && ppNodesvalue(i)<0.4
        pp2{u(2)}=results.linkID{i}; u(2)=u(2)+1;
    end
    if ppNodesvalue(i)>0.4 && ppNodesvalue(i)<0.6
        pp3{u(3)}=results.linkID{i}; u(3)=u(3)+1;
    end
    if ppNodesvalue(i)>0.6
        pp4{u(4)}=results.linkID{i}; u(4)=u(4)+1;
    end
end
d = epanet(settings.filename);
d.plot('highlightnode',pp1);

for u=1:length(results.nodeID)
    figure;cmap=hsv(5);
    for i=1:results.MSXSpeciesCount
        plot(results.compQualNodes.Time,results.compQualNodes.Quality{settings.index(u)}{i},'Color',cmap(i,:));
        hold on; 
    end
    legend(results.MSXSpeciesNameID);
    title(['NODE ',char(results.nodeID(u))]);
    ylabel('Quantity');
    xlabel('Time(sec)');
end

for u=1:length(results.linkID)
    figure;cmap=hsv(5);
    for i=1:results.MSXSpeciesCount
        plot(results.compQualLinks.Time,results.compQualLinks.Quality{settings.index(u)}{i},'Color',cmap(i,:));
        hold on; 
    end
    legend(results.MSXSpeciesNameID);
    title(['LINK ',char(results.linkID(u))]);
    ylabel('Quantity');
    xlabel('Time(sec)');
end


%------------- END OF CODE --------------