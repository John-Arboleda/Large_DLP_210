function Indiv = ActualizeIndiv(Indiv)
%Actualiza las variables dependientes del ruteo del Individuo
    for h = 1:length(Indiv)
        for i = 1:length(Indiv(h).Hub)
            TruckLoad = sum(Indiv(h).Hub(i).Route(:,2));
            %Carga de cada camión (suma de la demanda)
            Indiv(h).Hub(i).Load = TruckLoad;
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
    end
end