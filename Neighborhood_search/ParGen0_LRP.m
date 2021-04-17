function initPop = ParGen0_LRP(N_Indivs, dist, Customers, hubs, trucks)

    %n_hubs = height(hubs);

    initPop = makeEmptyPop(N_Indivs, hubs);
    
    for i = 1:N_Indivs
        %Asigna clientes al depósito más cercano
        initPop(i).Individual = ...
            initAssignToHub(initPop(i).Individual,dist,Customers,trucks);
        initPop(i).Individual = iterateRouting(initPop(i).Individual,dist);
            
    end
    
    function aIndiv = iterateRouting(aIndiv,Dist)
        for h = 1:length(aIndiv)
            for v = 1:aIndiv(h).N_veh
                %Ruteo de cada camión
                aIndiv(h).Hub(v).Route = Routing(aIndiv(h).Hub(v).Route,...
                    aIndiv(h).ID,Dist);
            end
            %Sí el depósito tiene clientes asignados, abrir
            if aIndiv(h).Load
                aIndiv(h).Open = true;
            end
        end
    end
    
    
    function aIndiv = addToVehicle(aIndiv,aHub,aNode,cap)
    %Asigna clientes a vehículos con capacidad disponible, si el vehículo
    %no tiene capacidad disponible agrega uno
        %Último vehículo utilizado
        veh = aIndiv(aHub).N_veh;
        %Si no se ha utilizado ningún vehiculo...
        if veh == 0
           %utilizar el primer vehiculo
           aIndiv(aHub).N_veh = 1;
           veh = 1;
           %Agregar cliente a la lista de clientes asignados del vehiculo
           aIndiv(aHub).Hub(veh).Route = [aIndiv(aHub).Hub(veh).Route; aNode];
        %Si el camión tiene cupo, agregar nodo
        elseif aIndiv(aHub).Hub(veh).Load + aNode(2) <= cap
           aIndiv(aHub).Hub(veh).Route = [aIndiv(aHub).Hub(veh).Route; aNode]; 
        else
        %Si no hay cupo, crear un nuevo vehiculo y agregar nodo
           Vehicle(1,1) = struct('Route',aNode,'Load',aNode(2),'Travel_Cost',0)';
           aIndiv(aHub).Hub = [aIndiv(aHub).Hub, Vehicle];
           veh = veh + 1;
           aIndiv(aHub).N_veh = veh;
        end
        %Caluclar carga total del camión
        occ = sum(aIndiv(aHub).Hub(veh).Route(:,2));
        aIndiv(aHub).Hub(veh).Load = occ;
    end
    
    function aIndiv = initAssignToHub(aIndiv,matDist,tabCust,Trucks)
    %Asigna clientes al depósito más cercano (distancia euclidiana), sin
    %tener en cuenta la capacidad del depósito, pero respetando la
    %capacidad de los camiones.
        %Lista de clientes por asignar
        cust_4_assign = tabCust{:,:};
        while ~isempty(cust_4_assign)
            %distnacia euclidiana de cada uno de los nos a los depósitos
            matHubCust = matDist([aIndiv.ID],cust_4_assign(:,1));
            %Mínima distancia e indice del nodo más cercano a cada depósito
            [minD,indD] = min(matHubCust,[],2);
            %Depósito con el nodo más cercano
            [~,s_hub] = min(minD);
            ind = indD(s_hub);
            %cliente más cercano con su demanda
            min_cust = cust_4_assign(ind,:);
            %agregar nodo a un vehículo
            aIndiv = addToVehicle(aIndiv,s_hub,min_cust,Trucks.Capacity);
            %calcular demanda total del depósito
            aIndiv(s_hub).Load = sum([aIndiv(s_hub).Hub.Load]);
            %Elimina nodo asignado de clientes por asignar
            cust_4_assign(ind,:) = [];
        end  
    end
end