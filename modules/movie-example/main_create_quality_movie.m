settings=[];
settings.inpname = 'net2-cl2.inp';
settings.msxname = 'net2-cl2.msx';
settings.bulk_specie_id = 'CL2'; % Animate the bulk chlorine specie
settings.wall_specie_id = ''; % There is no wall specie

settings.movname = 'test.avi';
settings.fps = 8;
settings.quality = 100;
settings.fig = [];
settings.vsize = 4;  % Size of vertices in points (0 == omits verts)
settings.lwidth = 3; % Width of links in points
settings.tsize = 5;  % Size of tank/reservoir nodes

d=epanet(settings.inpname);
d.loadMSXFile(settings.msxname);

%   Get the simulation data using Epanet or Epanet-MSX
[V,L,T] = getQualityData(settings.bulk_specie_id,...
    settings.wall_specie_id,settings.msxname,d);

% fig = writeFrame(settings,d,V);
        
[PData, SData] = movie_parameters(settings,V);

%% Write the Movie File
% NetworkMovie will display the first frame in a figure window and allow
% you to make adjustments to it (zoom, pan, etc.) before rendering the
% frames into an AVI movie file.
NetworkMovie(V,L,settings.fig,settings.movname,...
    settings.quality,settings.fps,PData,SData,d);

%% Show the Movie
% You could display the movie in Matlab as follows, or just use 
% an external viewer...
implay(settings.movname);

%% Unload EPANET-MATLAB Toolkit  
d.unload;