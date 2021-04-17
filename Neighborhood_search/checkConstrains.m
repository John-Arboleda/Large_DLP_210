function feasible = checkConstrains(Indiv,truckCap)
%Revisa que no se violen restricciones
    %Capacidad del depósito
    depotLoad = all([Indiv.Load] <= [Indiv.Capacity]);
    truckLoad = true;
    for h = length(Indiv)
        %Capacidad del camión
        truckLoad = truckLoad & all([Indiv(h).Hub.Load] <= truckCap);
    end
    feasible = depotLoad & truckLoad;

end