function Indiv = UpdateIndiv(Indiv,Truck_Cost)
%Actualiza las variables dependientes del ruteo del Individuo
    openHubs = 1:length(Indiv);
    openHubs = openHubs([Indiv.Open]);
    for h = openHubs
        for i = 1:length(Indiv(h).Hub)
            if ~isempty(Indiv(h).Hub(i).Route)
                TruckLoad = sum(Indiv(h).Hub(i).Route(:,2));
                %Carga de cada camión (suma de la demanda)
                Indiv(h).Hub(i).Load = TruckLoad;
            end
        end
        
        %Elimina camiones sin carga
        allTruckLoads = [Indiv(h).Hub.Load];
        Indiv(h).Hub = Indiv(h).Hub(allTruckLoads > 0);

        %Número de vehículos
        Indiv(h).N_veh = length(Indiv(h).Hub);
        %Carga total del depósito
        Indiv(h).Load = sum([Indiv(h).Hub.Load]);
        %Cierra depósito si está vacío
        if ~Indiv(h).Load
            Indiv(h).Open = false;
        else
            Indiv(h).Open = true;
        end
        %Actualiza costos fijos de vehículos, costo de ruteo, costo total
        Indiv(h).Veh_Cost = Indiv(h).N_veh*Truck_Cost;
        Indiv(h).Travel_Cost = sum([Indiv(h).Hub.Travel_Cost]);
        Indiv(h).Total_Cost = Indiv(h).Hub_Cost + Indiv(h).Travel_Cost +...
            Indiv(h).Veh_Cost;
    end
end