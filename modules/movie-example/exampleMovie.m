%% How to Make an AVI Movie of Your EPANET or EPANET-MSX Simulation
%% Synopsis
% This example illustrates the use of NetworkMovie and NetworkFrame to
% animate either a bulk or wall specie, or both, for an Epanet/MSX
% simulation, and store the result as an *.avi movie
%
% Note that the EPANET and MSX Matlab wrappers must be on your Matlab
% search path.  Matlab will also need to be able to find the epanet and
% epanet-msx object libraries and header files.
% Jim Uber
% modified by Marios Kyriakou 25/09/2016

%% Get the Epanet-MSX Simulation Data

msxFname = 'net2-cl2.msx';
inpFname = 'net2-cl2.inp';
%   Animate the bulk chlorine specie
bulkSpecieID = 'CL2';
%   There is no wall specie
wallSpecieID = '';

d=epanet(inpFname);
d.loadMSXFile(msxFname);

%   Get the simulation data using Epanet or Epanet-MSX
[V,L,T] = getQualityData(bulkSpecieID,wallSpecieID,msxFname,d);

%% Specify Movie Parameters
% These parameters are described in NetworkFrame()...
fig = [];                   % Use a new figure window
movFname = 'mymovie.avi';   % Movie file name
quality = 100;              % 0-100 movie quality (related to data compression)
fps = 8;                    % Frame rate - # to display per second
PData.c = 'jet';            % colormap - see 'help colormap'
PData.logtransv = 'n';      % Do not log transform the data
PData.vmin = 0;             % min vertex value for plot color mapping
PData.vmax = max(max(V));   % max vertex value
% PData.logtransl = 'n';    % We're not plotting link data so these are ignored
% PData.lmin = min(min(L));
% PData.lmax = max(max(L));
PData.lwidth = 3;           % Width of links in points
PData.vsize = 4;            % Size of vertices in points (0 == omits verts)
PData.tsize = 5;            % Size of tank/reservoir nodes
PData.legend = 'v';         % Show a colorbar legend for vertex data
SData = [];                 % No special node symbols
% SData(1...).ivs = [];             % Node IDs to annotate with special symbols
% SData(1...).vsmarker = [];        % Marker symbols
% SData(1...).vsmarkersize = [];    % Marker symbol sizes
% SData(1...).vsmarkercolor = [];   % Marker symbol colors

%% Write the Movie File
% NetworkMovie will display the first frame in a figure window and allow
% you to make adjustments to it (zoom, pan, etc.) before rendering the
% frames into an AVI movie file.
NetworkMovie(V,L,fig,movFname,quality,fps,inpFname,PData,SData,d);
implay('mymovie.avi');
%% Show the Movie
% You could display the movie in Matlab as follows, or just use 
% an external viewer...

% mov = aviread(movFname);
% h = figure;
% axis equal;
% movie(h,mov);
d.unload;
