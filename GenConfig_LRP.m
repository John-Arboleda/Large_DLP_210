%Genera N configuraciones de depósito factibles para satisfacer demanda de
    %un grupo de clientes
function groupDepotConfig = GenConfig_LRP(N_Config, extraCap, CUSTOMERS, HUBS)
    %Demanda total de los clientes
    totalDemand = sum(CUSTOMERS.Qty);
    %Inicializa matriz de configuraciones
    groupDepotConfig = false(N_Config, height(HUBS));
    %Matriz código de asignación
    checkEqual = zeros(N_Config,1); 
    n = 1;%Asignación actual
    while n <= N_Config
        %Abrir hubs aleatorio
        logArr = rand(1,height(HUBS)) < 0.5;
        %Capacidad total de los hubs abiertos
        totalDepotCap = logArr * HUBS.Capacity;
        %Código entero del número binario de la configuración
        checkNum = bin2dec(strjoin(string(double(logArr))));
        %Si no hay configuraciones iguales
        noneEqual = ~any(checkEqual == checkNum);
        %Sí la capacidad total es un 5% mayor que la demanda total
        capConst = totalDepotCap >= totalDemand * (1 + extraCap);
        if noneEqual && capConst
            groupDepotConfig(n,:) = logArr; %Agregar configuración
            checkEqual(n) = checkNum; %Agregar a código de individuos 
            n = n+1;
        end
    end
end