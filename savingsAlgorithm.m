%Método de los ahorros: genera rutas sin un número fijo de vehículos,
    %teniendo en cuenta su capacidad.
    
%INPUT
%Hub(struct): Hub con clientes asignados individualmente a una ruta
%hubID(integer): ID del hub en matriz de distancias
%DIST(matrix): Distancias entre nodos (incluye clientes y depósitos)
%TRUCKS(table): Información de vehículos

%RETURN
%assignedHub(struct): Hub con clientes asignados a rutas que maximizan el
    %ahorro

function assignedHub = savingsAlgorithm(Hub, hubID, DIST, TRUCKS)
    customers = vertcat(Hub.Route);%Clientes del nodo con demanda
    nodes = customers(:,1);%ID de clientes
    distCust = DIST(nodes,nodes); %matriz de distancia entre nodos
    %distancia desde depósito hasta clientes
    distFromHub = DIST(hubID,nodes).* ~eye(length(distCust));
    %Distancia de clientes hasta depósito
    distToHub = DIST(nodes,hubID).* ~eye(length(distCust));
    %Matriz de ahorros, cómo la matriz tiene distancias no euclidianas,
        %algunos ahorros son negativos
    saves = distFromHub + distToHub - distCust;
    savesMat = saves;
    savesMat(saves < 0) = 0;%Matriz de ahorros sin números negativos
    
    assignedHub = Hub;%Inicializa hub de retorno
    while any(savesMat,'all')%Si hay algun non-zero
        [~,inD] = max(savesMat(:)); %Índice lineal del máximo ahorro
        [inD_row,inD_col] = ind2sub(size(savesMat),inD);%fila y columna del índice
        HubCell = struct2cell(assignedHub');%Celda de la estructura del hub
        RoutesCell = HubCell(1,:);%Celda de rutas
        routeStart = cellfun(@(r) r(1,1),RoutesCell);%Inicio de cada ruta
        routeEnd = cellfun(@(r) r(end,1),RoutesCell);%Fin de cada ruta
        fromCust = customers(inD_row);%Cliente desde
        toCust = customers(inD_col);%Cliente hasta
        %Si es factible fusionar el final con el inicio de alguna ruta
        endToStart = any(routeEnd == fromCust) && any(routeStart == toCust);
        if endToStart
            %Buscar la posición de las rutas a fusionar
            route_1 = find(routeEnd == fromCust);
            route_2 = find(routeStart == toCust);
            %Si es factible la unión
            feasible = assignedHub(route_1).Load + assignedHub(route_2).Load...
                <= TRUCKS.Capacity;
            if feasible && (route_1 ~= route_2)
                %Unir rutas
                assignedHub = mergeRoutes(assignedHub,route_1,route_2);
                %Actualizar matriz de ahorros
                savesMat(inD_row,:) = 0;%ya no se puede ir desde este nodo
                savesMat(:,inD_col) = 0;%ya no se puede ir hacia ese nodo
                savesMat(inD_col,inD_row) = 0;%no se puede viajar en sentido contrario
            end
        end
        %Actualizar matriz de ahorros, incluso si no es factible
        savesMat(inD_row,inD_col) = 0;
    end
            
    function m_Hub = mergeRoutes(a_Hub,route1,route2)
    %Asigna clientes a vehículos con capacidad disponible, si el vehículo
    %no tiene capacidad disponible agrega uno
        m_Hub = a_Hub;
        m_Hub(route1).Route = [m_Hub(route1).Route;m_Hub(route2).Route];
        m_Hub(route1).Load = m_Hub(route1).Load + m_Hub(route2).Load;
        m_Hub(route2) = [];
    end

end