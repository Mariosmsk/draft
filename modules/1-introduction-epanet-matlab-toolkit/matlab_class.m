% Example: B=matlab_class('Net1.inp','epanet2'); 
%          B.getNodeCount
%
classdef matlab_class
    
   properties
       NodeCount
       LinkCount
       Errcode
       libepanet
   end
   
    properties (Constant = true)
        classversion='TEST';
    end
    
    methods 
      function obj = matlab_class(inpname,libepanet)
            obj.libepanet=libepanet;
            if ~libisloaded(libepanet)
                loadlibrary([which(libepanet),libepanet],[LibEPANETpath,libepanet,'.h'])
            end
            if libisloaded(libepanet)
                disp('EPANET loaded sucessfuly.');
            else
                warning('There was an error loading the EPANET library (DLL).')
            end    
            repname = ''; binname = '';
            Errcode=calllib(libepanet,'ENopen',which(inpname),repname,binname);
            if Errcode
               [~,errmsg] = calllib(libepanet,'ENgeterror',Errcode,char(32*ones(1,79)),79);
               warning(errmsg);
            end
            obj.NodeCount = obj.getNodeCount;
            obj.LinkCount = obj.getLinkCount;
      end
      
      function value = getNodeCount(obj)
         % Node Count - count code is zero
         code=0; % nodes
        [~, value]=calllib(obj.libepanet,'ENgetcount',code,0); 
      end
      function value = getLinkCount(obj)
         % Node Count - count code is zero
         code=1; % links
        [~, value]=calllib(obj.libepanet,'ENgetcount',code,0); 
      end
      
    end
end