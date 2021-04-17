function Exchange_1_neighbors =  Exchange_1(Indiv,indexList,TRUCKS)
%Intercambia un cliente por otro intra/inter ruta e intra/inter depósito

    %Lista de nodos para intercambiar con los índices de su antigua
        %ubicación
    nodeIncomplIndiv = extractNode(Indiv,indexList,'exchange','1');
    
    %Vecindario de nodos generados en cada posible intercambio factible
        %para Exchange-1
    Exchange_1_neighbors = Exchange_fun(Indiv,nodeIncomplIndiv,TRUCKS.Capacity,'1');
    
end

%     Exchange_1_neighbors = [];
%     iterNodes = nchoosek(1:length(indexList),2);
%     for k = 1:length(iterNodes)
%         h1 = indexList(iterNodes(k,1),1);
%         h2 = indexList(iterNodes(k,2),1);
%         i1 = indexList(iterNodes(k,1),2);
%         i2 = indexList(iterNodes(k,2),2);
%         j1 = indexList(iterNodes(k,1),3);
%         j2 = indexList(iterNodes(k,2),3);
%         copyIndiv = Indiv;
%         node1 = copyIndiv(h1).Hub(i1).Route(j1,:);
%         node2 = copyIndiv(h2).Hub(i2).Route(j2,:);
%         copyIndiv(h1).Hub(i1).Route(j1,:) = node2;
%         copyIndiv(h2).Hub(i2).Route(j2,:) = node1;
%         copyIndiv = ActualizeIndiv(copyIndiv);
%         feasible = checkConstrains(copyIndiv,TRUCKS.Capacity);
%         if feasible
%             s = length(Exchange_1_neighbors) + 1;
%             Exchange_1_neighbors(s).neighbor = copyIndiv;
%         end
%     end
% end


    
%     %Inicializa Struct de todas las vencindades
%     Exchange_1_neighbors = struct([]);
%     %número de depósitos
%     n_hubs = length(Indiv);
%     %Array de índices: Sólo se intercambia entre depósitos diferentes una vez
%     logHubs = find(1:n_hubs >= [1:n_hubs]');
%     [h1,h2] = ind2sub([n_hubs,n_hubs],logHubs);
%     %Iteraciones entre depósitos
%     iterHubs = length(h1);
%     for i = 1:iterHubs
%        Indiv(h1(i)).N_veh
%        %Número de camiones en cada depósitos
%        trucks_h1 = Indiv(h1(i)).N_veh;
%        trucks_h2 = Indiv(h2(i)).N_veh;
%        if h1(i) == h2(i)
%            %Si es el mismo depósito, iterar en camiones diferentes una vez
%            logTrucks = find(1:trucks_h1 >= [1:trucks_h2]');
%            [t1,t2] = ind2sub([trucks_h1,trucks_h2],logTrucks);
%        else
%            %iterar en todos los camiones
%            [t1,t2] = ind2sub([trucks_h1,trucks_h2],1:trucks_h1*trucks_h2);
%        end
%        %iteraciones entre camiones
%        iterTrucks = length(t1);
%        for j = 1:iterTrucks
%            %clientes por camión
%            route_t1 = length(Indiv(h1(i)).Hub(t1(j)).Route(:,1));
%            route_t2 = length(Indiv(h2(i)).Hub(t2(j)).Route(:,1));
%            %Si es el mismo camión en el mismo depósito
%            if h1(i) == h2(i) && t1(j) == t2(j)
%                %itere en nodos diferentes una vez
%                logRoute = find(1:route_t1 >= [1:route_t2]');
%                [r1,r2] = ind2sub([route_t1,route_t2],logRoute);
%            else
%                %itere en todos los nodos
%                [r1,r2] = ind2sub([route_t1,route_t2],1:route_t1*route_t2);
%            end
%            %iteraciones entre nodos
%            iterRoute = length(r1);
%            for m = 1:iterRoute
%                %nodos de cada de cada ruta
%                node_r1 = Indiv(h1(i)).Hub(t1(j)).Route(r1(m),:);
%                node_r2 = Indiv(h2(i)).Hub(t2(j)).Route(r2(m),:);
%            
%                %si es el mismo nodo
%                if node_r1 ~= node_r2
%     %                copyIndiv = Indiv;
%                 %intercambiar nodos en copia de individuo
%                 %comprabar que se satisfacen restricciones de capacidad de
%                     %camión y cada depósito
%                 %capturar individuo en vecindario
% 
%                end
%            end
%            
%        end
%     end 
% end