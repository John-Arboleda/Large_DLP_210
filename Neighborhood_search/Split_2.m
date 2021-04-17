function Split_2_neighbors = Split_2(Indiv,indexList,TRUCKS)
%Genera un vecindario creando una ruta con dos clientes

    %Extrae pares de nodos del individuo sin cerrar rutas
    nodeIncomplIndiv = extractNode(Indiv,indexList,'split','2');

    %Vecindario de soluciones factibles para 'split-2'
    Split_2_neighbors = Split_fun(nodeIncomplIndiv,indexList,TRUCKS.Capacity,'2');
    
end
%     %Inicializa Struct de todas las vencindades 2-opt
%     Split_2_neighbors = [];
%     %número de depósitos
%     n_hubs = length(Indiv);
%     for oh = 1:n_hubs
%        %número de camiones en el depósito
%        for t = 1:length(Indiv(oh).Hub)
%            route = Indiv(oh).Hub(t).Route;
%            if length(route(:,1)) > 2
%                for c = 1:length(route(:,1))-1
%                    %ruta sin el nodo extraído
%                    rest_route = route;
%                    rest_route(c:c+1,:) = [];
%                    %ruta de dos nodos
%                    two_route = route(c:c+1,:);
%                    %Genera una vecindad a partir de las dos nuevas rutas
%                    for nh = 1:n_hubs
%                        neighbor = Split_fun(Indiv,oh,nh,t,rest_route,two_route);
%                        DepotCap = prod([neighbor.Capacity] >= [neighbor.Load]);
%                        if DepotCap
%                            Split_2_neighbors = concatStruct(Split_2_neighbors,...
%                                neighbor);
%                        end
%                    end
%                end              
%            end
%        end
%     end
