function fig = writeFrame(settings,d,V)
fig = figure;
axis equal;
axis off;
    
% Network Geometry (from processing text InpFname)
vx = d.NodeCoordinates{1};
vy = d.NodeCoordinates{2};
vertx = d.NodeCoordinates{3};
verty = d.NodeCoordinates{4};

% Network topology
tmp = d.getLinkNodesIndex;
from = tmp(:,1);
to = tmp(:,2);
Itank = false(d.NodeCount,1);
tmp_nodetypes = d.getNodeTypeIndex;
Itank(find(tmp_nodetypes~=0))=true;
    
% Link handles
x(1,:) = vx(from);
x(2,:) = vx(to);
y(1,:) = vy(from);
y(2,:) = vy(to);
    
for i=1:d.LinkCount
    hlinks(i)=line([x(1,i) vertx{i} x(2,i)],[y(1,i) verty{i} y(2,i)],'LineWidth',settings.lwidth);
end

for i=1:d.NodeCount
    hnodes(i)=line(vx(i),vy(i),'Marker','o','MarkerSize',settings.vsize);
end

if V(:,1)<0.2
    
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




pval = cell(size(hnodes(Itank)))';
pname(1)={'Marker'};
pname(2)={'MarkerSize'};
pval(:,1) = {'s'};
pval(:,2) = {settings.tsize};
set(hnodes(Itank),pname,pval);