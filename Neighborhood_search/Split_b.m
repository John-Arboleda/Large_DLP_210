function Split_b_neighbors = Split_b(Indiv,indexList,TRUCKS)
%Genera un vecindario creando una ruta con predecesores de un cliente

    %Extrae nodos predecesores del individuo sin cerrar rutas
    nodeIncomplIndiv = extractNode(Indiv,indexList,'split','b');

    %Vecindario de soluciones factibles para 'split-b'
    Split_b_neighbors = Split_fun(nodeIncomplIndiv,indexList,TRUCKS.Capacity,'b');

end
%     %Inicializa Struct de todas las vencindades 2-opt
%     Split_b_neighbors = [];
%     %número de depósitos
%     n_hubs = length(Indiv);
%     for oh = 1:n_hubs
%        %número de camiones en el depósito
%        for t = 1:length(Indiv(oh).Hub)
%            route = Indiv(oh).Hub(t).Route;
%            if length(route(:,1)) > 1
%                for c = 1:length(route(:,1))-1
%                    %ruta sin los nodos extraídos
%                    rest_route = route;
%                    rest_route(1:c,:) = [];
%                    %ruta de predecesores
%                    pre_route = route(1:c,:);
%                    %Genera una vecindad a partir de las dos nuevas rutas
%                    for nh = 1:n_hubs
%                        if nh ~= oh
%                            neighbor = Split_fun(Indiv,oh,nh,t,rest_route,pre_route);
%                            DepotCap = prod([neighbor.Capacity] >= [neighbor.Load]);
%                            if DepotCap
%                                Split_b_neighbors = concatStruct(Split_b_neighbors,...
%                                    neighbor);
%                            end
%                        end
%                    end
%                end              
%            end
%        end
%     end