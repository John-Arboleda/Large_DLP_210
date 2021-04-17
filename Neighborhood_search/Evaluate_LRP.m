%Realiza búsqueda local y calcula costo de las vecindades del individuo
    %Los vecinos se ordenan de menor a mayor costo
function evaluatedPop = Evaluate_LRP(pop,N_Indivs,DIST,TRUCKS)


    for n = 1:N_Indivs
        %Costo del individuo
        nIndvi = pop(n).Individual;
        nIndvi = costIndiv(nIndvi,DIST,TRUCKS.Cost);
        CostIndiv = sum([nIndvi.Total_Cost]);
        %Vecindario del individuo
        neighborhood = Create_Neighborhood(pop(n).Individual,TRUCKS);
        for m = 1:length(neighborhood)
            %Cálculo del costo para cada vecindad
            neighborhood(m).Neighbor = costIndiv(neighborhood(m).Neighbor,...
                DIST,TRUCKS.Cost);
            neighborhood(m).TotalCost = sum([neighborhood(m).Neighbor.Total_Cost]);
        end
        %Ranking de vecindades
        neighborhood = struct2table(neighborhood);
        neighborhood = sortrows(neighborhood,{'TotalCost'});
        neighborhood = table2struct(neighborhood)';
        [~,uni] = unique([neighborhood.TotalCost]);
        neighborhood = neighborhood(uni);
        rankIndiv = find([neighborhood.TotalCost] >= CostIndiv,1);
    end
    
    function evIndiv = costIndiv(Indiv,dist,TruckCost)
    %Cálculo de los costos totales de un individuo
        evIndiv = Indiv;
        for h = 1:length(Indiv)
            %ID del depósito
            hID = evIndiv(h).ID;
            for i = 1:evIndiv(h).N_veh
                %ID de los clientes de la ruta
                routeID = evIndiv(h).Hub(i).Route(:,1);
                %Costo de recorrido
                RouteCost = costRoute(routeID,hID,dist);
                evIndiv(h).Hub(i).Travel_Cost = RouteCost;
            end
            %Costos totales de recorrido
            evIndiv(h).Travel_Cost = sum([evIndiv(h).Hub.Travel_Cost]);
            %Costo fijo total de vehículos utilizados
            evIndiv(h).Veh_Cost = TruckCost*evIndiv(h).N_veh;
            %Costo total
            evIndiv(h).Total_Cost = evIndiv(h).Open*sum([evIndiv(h).Travel_Cost,...
                evIndiv(h).Veh_Cost,evIndiv(h).Hub_Cost]);
        end
    end
end