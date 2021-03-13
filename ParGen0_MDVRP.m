function initPop = ParGen0_MDVRP(depotConfig, N_Indivs, DIST, CUSTOMERS, HUBS)
    %Inicializa población
    initPop = makeEmptyPop(N_Indivs, HUBS);
    
    for i = 1:N_Indivs
        aIndiv = initPop(i).Individual;
        %Lista de clientes por asignar
        cust_4_assign = CUSTOMERS{:,:};
        while ~isempty(cust_4_assign)
            %distancia euclidiana de cada uno de los nodos a los depósitos
            matHubCust = DIST([aIndiv.ID],cust_4_assign(:,1));
            Depots = 1:height(HUBS);%Todos los hubs
            openDepots = Depots(depotConfig);%Hubs abiertos
            %Selecciona el nodo más cercano de un depósito aleatorio
            [indD,depot] = selRandHub(openDepots,matHubCust);
            
            min_cust = cust_4_assign(indD,:);
            %Restricción de capacidad del depósito
            depotCap = aIndiv(depot).Load + min_cust(2) <= aIndiv(depot).Capacity;
            %Por lo menos un depósito tiene capacidad disponible
            allDepotsFull = all([aIndiv(depotConfig).Capacity] -...
                [aIndiv(depotConfig).Load] < min_cust(2));
            if depotCap %Sí el depósito tiene capacidad disponible
                %Agregar nodo a un vehículo
                aIndiv = addToVehicle(aIndiv,min_cust,depot);
                cust_4_assign(indD,:) = [];%Eliminar de la lista de nodos por asignar
            elseif allDepotsFull %Si no hay capacidad, viola restricción de capacidad
                %Agregar nodo a un vehículo 
                aIndiv = addToVehicle(aIndiv,min_cust,depot);
                cust_4_assign(indD,:) = [];
            end
        end
        initPop(i).Individual = aIndiv;
    end
    
    function [ind,s_depot] = selRandHub(depotList,nodeList)
        s_depot = depotList(randi(length(depotList)));
        %Indice del nodo más cercano al depósito
        [~,ind] = min(nodeList(s_depot,:));
    end

    function aIndiv = addToVehicle(aIndiv,cust,depot)
        Vehicle = struct('Route',cust,'Load',cust(2),'Travel_Cost',0)';
        aIndiv(depot).Hub = [aIndiv(depot).Hub, Vehicle]; 
        %aIndiv(depot).Hub.Route = [aIndiv(depot).Hub.Route;min_cust];
        aIndiv(depot).Load = sum([aIndiv(depot).Hub.Load]);
        %Sí el depósito tiene clientes asignados, abrir
        aIndiv(depot).Open = true;
        %Elimina nodo asignado de clientes por asignar   
    end
end