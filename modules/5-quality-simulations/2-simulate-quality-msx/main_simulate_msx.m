settings=[];
settings.filename = 'net2-cl2.inp'; % net2-cl2
settings.msxfilename = 'net2-cl2.msx'; % net2-cl2
settings.index = [1:2]; %node or link index
settings.figure = 1;
%% Create JSON file for input
input = savejson(settings);

%% Run Module
output = simulate_msx(input);
results = output;

% %% Extract output from JSON
% tmp = loadjson(output);
% results=tmp.results;
   
%% Plot graph
for u=1:length(results.nodeID)
    figure(settings.figure);subplot(2,2,u);cmap=hsv(5);
    for i=1:results.MSXSpeciesCount
        plot(results.compQualNodes.Time,results.compQualNodes.Quality{settings.index(u)}{i},'Color',cmap(i,:));
        hold on; 
    end
    legend(results.MSXSpeciesNameID);
    title(['NODE ',char(results.nodeID(u))]);
    ylabel('Quantity');
    xlabel('Time(sec)');
end

for u=3:4
    figure(settings.figure);subplot(2,2,u);cmap=hsv(5);
    for i=1:results.MSXSpeciesCount
        plot(results.compQualLinks.Time,results.compQualLinks.Quality{settings.index(u-2)}{i},'Color',cmap(i,:));
        hold on; 
    end
    legend(results.MSXSpeciesNameID)
    title(['LINK ',char(results.linkID(u-2))]);
    ylabel('Quantity');
    xlabel('Time(sec)');
end

%------------- END OF CODE --------------