function evaluatedPop = Evaluate_MDVRP(initPop, N_Indivs, DIST, TRUCKS)
    
    evaluatedPop = initPop;
    
    for n = 1:N_Indivs
        Hubs = 1:length(evaluatedPop(n).Individual);%Todos los hubs
        logOpen = [evaluatedPop(n).Individual.Open];%Array lógico hubs abiertos
        openHubs = Hubs(logOpen);%Hubs abiertos
        for h = openHubs
            %Sub-estructura de un depósito
            aHub = evaluatedPop(n).Individual(h).Hub;
            hubID = evaluatedPop(n).Individual(h).ID;
            %Ruteo con método de los ahorros para un hub
            rHub = savingsAlgorithm(aHub, hubID, DIST, TRUCKS); 
            for r = 1:length(rHub)
                %Cálculo del costo de ruta
                rHub(r).Travel_Cost = costRoute(rHub(r).Route,hubID,DIST);
            end
            evaluatedPop(n).Individual(h).Hub = rHub;
        end
        %Actualiza todas las variables de un individuo
        evaluatedPop(n).Individual = ...
            ActualizeIndiv(evaluatedPop(n).Individual,TRUCKS.Cost);
        %Costo total de depósitos
        hub_Cost = sum([evaluatedPop(n).Individual.Hub_Cost].*logOpen);
        %Costo total de vehículos
        veh_Cost = sum([evaluatedPop(n).Individual.Veh_Cost].*logOpen);
        %Costo total de recorrido
        travel_Cost = sum([evaluatedPop(n).Individual.Travel_Cost].*logOpen);
        %Costo total
        total_Cost = sum([evaluatedPop(n).Individual.Total_Cost].*logOpen);
        %Array de valores objetivo
        evaluatedPop(n).Obj_Vals = [hub_Cost,veh_Cost,travel_Cost,total_Cost];
    end  
end