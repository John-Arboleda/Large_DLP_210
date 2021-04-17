%Input
%Route(array) = Nodos asignados con su demanda
%aBus(integer) = Bus asignado
%nBuses(integer) = Número de buses

%Return
%newRoute(array) = Nodos reordenados con su demanda

%Algortimo que resuelve el TSP para el los nodos asignados a determinada
    %ruta apartir de dos rutas, una desde el depósito y otra desde la
    %posición del bus
function [newRoute] = Routing(Route,hubID,Dist)

%Inicializa nodos por asignar
nodo_x_asignar = Route(:,1);

%Indice del nodo más cercano desde el depósito
[~,nodeB] = min(Dist(hubID,nodo_x_asignar));
%arrBus: array de indices de nodos más cercanos desde el depósito
arrFrom = nodeB;
nodo_x_asignar(nodeB) = [];

%Indice del nodo más cercano hacia
[~,nodeD] = min(Dist(nodo_x_asignar,hubID));
%arrDepot: array de indices más cercanos hacia el depósito
[arrDepot, nodo_x_asignar] = assignNode(nodeD,[],nodo_x_asignar,Route);


while ~isempty(nodo_x_asignar)
    %distancia mínima del nodo más cercano al último nodo de
        %arrFrom/arrDepot
    [minBus,nodeFrom] = min(Dist(Route(arrFrom(end),1),nodo_x_asignar));
    [minDepot,nodeDepot] = min(Dist(nodo_x_asignar,Route(arrDepot(end),1)));
    %asigna según la cercanía al último nodo
    if minBus < minDepot
        %asigna a ruta del bus
        [arrFrom, nodo_x_asignar] = assignNode(nodeFrom,arrFrom,...      
            nodo_x_asignar,Route);
    else
        %asigna a ruta del depósito
        [arrDepot, nodo_x_asignar] = assignNode(nodeDepot,arrDepot,...
            nodo_x_asignar,Route);
    end
    
end

%Concatena índices de nodos cercanos al bus con los nodos hacia el depósito
%Genera nueva ruta
newRoute = Route([arrFrom, flip(arrDepot)],:);

    function [arrAct, nXaAct] = assignNode(n, arr, n_x_a, route)
        %busca el indice de n en route, asigna el indice a arr, actualiza
            %nodos por asignar
        nXaAct = n_x_a;
        ind = find(route(:,1) == nXaAct(n),1);
        arrAct = [arr, ind];
        nXaAct(n) = [];
    end

% 
%oldR = costoRuta(Route,aBus, DB,DC)
%newR = costoRuta(newRoute,aBus, DB,DC)


%fCost = @(x) costoRuta(x(:,1),aBus,nBuses);
% calcCost = cellfun(fCost, matPer);%Calcula el costo de cada permutación
% cost = min(calcCost);%Elige el menor costo
% minRoute = matPer{calcCost == cost,1};%Elige el ruteo asociado al menor costo

end
