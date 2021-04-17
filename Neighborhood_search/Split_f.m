function Split_f_neighbors = Split_f(Indiv,indexList,TRUCKS)
%Genera un vecindario creando una ruta con sucesores de un cliente

    %Extrae nodos sucesores del individuo sin cerrar rutas
    nodeIncomplIndiv = extractNode(Indiv,indexList,'split','f');

    %Vecindario de soluciones factibles para 'split-f'
    Split_f_neighbors = Split_fun(nodeIncomplIndiv,indexList,TRUCKS.Capacity,'f');

end


%     %Inicializa Struct de todas las vencindades 2-opt
%     Split_f_neighbors = [];
%     %número de depósitos
%     n_hubs = length(Indiv);
%     for oh = 1:n_hubs
%        %número de camiones en el depósito
%        for t = 1:length(Indiv(oh).Hub)
%            route = Indiv(oh).Hub(t).Route;
%            if length(route(:,1)) > 1
%                for c = 2:length(route(:,1))
%                    %ruta sin los nodos extraídos
%                    rest_route = route;
%                    rest_route(c:end,:) = [];
%                    %ruta de sucesores
%                    suc_route = route(c:end,:);
%                    %Genera una vecindad a partir de las dos nuevas rutas
%                    for nh = 1:n_hubs
%                        if nh ~= oh
%                            neighbor = Split_fun(Indiv,oh,nh,t,rest_route,suc_route);
%                            DepotCap = prod([neighbor.Capacity] >= [neighbor.Load]);
%                            if DepotCap
%                                Split_f_neighbors = concatStruct(Split_f_neighbors,...
%                                    neighbor);
%                            end
%                        end
%                    end
%                end              
%            end
%        end
%     end
% end