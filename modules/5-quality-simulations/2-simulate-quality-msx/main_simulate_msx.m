settings=[];
settings.filename = which('example.inp'); % net2-cl2
settings.index = 1; %node or link index
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
figure(settings.figure);subplot(2,2,1);cmap=hsv(5);
for i=1:results.MSXSpeciesCount
    plot(results.compQualLinks.Time,results.compQualLinks.Quality{settings.index}{i},'Color',cmap(i,:));
    hold on; 
end
legend(results.MSXSpeciesNameID)
title(['LINK ',char(results.linkID),' - 1st Way']);

figure(settings.figure);subplot(2,2,2);cmap=hsv(5);
for i=1:results.MSXSpeciesCount
    plot(results.compQualNodes.Time,results.compQualNodes.Quality{settings.index}{i},'Color',cmap(i,:));
    hold on; 
end
legend(results.MSXSpeciesNameID);
title(['NODE ',char(results.nodeID),' - 1st Way']);

figure(settings.figure);subplot(2,2,4);
for i=results.arg2
    specie(:,i)=results.resQualIndexNode.Quality{i};
    time(:,i)=results.resQualIndexNode.Time;
end
plot(time,specie);
title(['NODE ',char(results.nodeID),' - 2st Way']);
ylabel('Quantity');
xlabel('Time(s)');
legend(results.SpeciesNameID(results.arg2));

figure(settings.figure);subplot(2,2,3);
for i=results.arg2
    specie(:,i)=results.resQualIndexLink.Quality{i};
    time(:,i)=results.resQualIndexLink.Time;
end
plot(time,specie);
title(['LINK ',char(results.linkID),' - 2st Way']);
ylabel('Quantity');
xlabel('Time(s)');
legend(results.SpeciesNameID(results.arg2));

%------------- END OF CODE --------------