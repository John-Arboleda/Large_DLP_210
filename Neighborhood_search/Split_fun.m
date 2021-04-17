function split_neighborhood = Split_fun(nodeIncomplIndiv,indexList,cap,type)

    split_neighborhood = [];
    for k = 1:length(nodeIncomplIndiv)
        %Grupo de nodos
        node = nodeIncomplIndiv(k).Customers;
        %Individuo incompleto
        incomplete = nodeIncomplIndiv(k).Incomplete;
        %'b' y 'f' funcionan inter-depot, '0' intra-depot
        oldHub = nodeIncomplIndiv(k).Index(1);
        for h = 1:max(indexList(:,1))
            %Índice del último camión
            lastTruck = max(indexList(indexList(:,1) == h,2));
            j = lastTruck + 1;%Índice de nuevo camión
            copyIndiv = incomplete;
            %Agrega camión al individuo incompleto
            copyIndiv(h).Hub(j).Route = node;
            copyIndiv = ActualizeIndiv(copyIndiv);
            feasible = checkConstrains(copyIndiv,cap);
            typeCons = true;%Restrición de tipo
            if (strcmp(type,'b') || strcmp(type,'f')) && oldHub == h
                typeCons = false;
            elseif strcmp(type,'0') && oldHub ~= h
                typeCons = false;
            end
            %Agregar a vecindario
            if feasible && typeCons
                split_neighborhood = concatStruct(split_neighborhood,...
                    copyIndiv,strcat('Split-',type));
            end
        end
    end
end



%     function copyIndiv = Split_fun(aIndiv,orgHub,newHub,nR,orgRoute,newRoute)
%     %Actualiza un individuo a partir de un depósito, un número de ruta, una
%     %ruta original y una nueva ruta
%         copyIndiv = aIndiv;
%         copyIndiv(orgHub).Hub(nR).Route = orgRoute;
%         copyIndiv(newHub).Hub(end + 1).Route = newRoute;
%         copyIndiv(orgHub).Hub(nR).Load = sum(orgRoute(:,2));
%         copyIndiv(newHub).Hub(end).Load = sum(newRoute(:,2));
%         copyIndiv(orgHub).Load = sum([copyIndiv(orgHub).Hub.Load]);
%         copyIndiv(newHub).Load = sum([copyIndiv(newHub).Hub.Load]);
%         copyIndiv(newHub).N_veh = copyIndiv(newHub).N_veh + 1;
%     end