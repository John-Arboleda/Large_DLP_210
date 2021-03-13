%Crea una estructura para cada individuo con el número total de nodos y
    %un vehiculo por nodo
function emptyPop = makeEmptyPop(nIndi, hubs)
    nHubs = 1:height(hubs);
    %Vehicle = struct;
    for h = nHubs
        IndivStruct(1,h) = struct('ID',hubs{h,'ID'},'Hub',[],'Open',false,'N_veh',0,...
            'Capacity',hubs{h,'Capacity'},'Load',0,'Hub_Cost',hubs{h,'Cost'},'Veh_Cost',0,'Travel_Cost',0,'Total_Cost',0)';
    end
    emptyPop(1,1:nIndi) = struct('Individual',IndivStruct,'Obj_Vals',[])';
end