function Split_1_neighbors = Split_1(Indiv,indexList,TRUCKS)
%Genera un vecindario creando una ruta con un sólo cliente

    %Extrae nodos del individuo sin cerrar rutas
    nodeIncomplIndiv = extractNode(Indiv,indexList,'split','1');

    %Vecindario de soluciones factibles para 'split-1'
    Split_1_neighbors = Split_fun(nodeIncomplIndiv,indexList,TRUCKS.Capacity,'1');

end

%     %Inicializa Struct de todas las vencindades
%     Split_1_neighbors = [];
%     %número de depósitos
%     n_hubs = length(Indiv);
%     for oh = 1:n_hubs
%        %número de camiones en el depósito
%        for t = 1:length(Indiv(oh).Hub)
%            route = Indiv(oh).Hub(t).Route;
%            if length(route(:,1)) > 1
%                for c = 1:length(route(:,1))
%                    %ruta sin el nodo extraído
%                    rest_route = route;
%                    rest_route(c,:) = [];
%                    %ruta de un solo nodo
%                    cust_route = route(c,:);
%                    %Genera una vecindad a partir de las dos nuevas rutas
%                    for nh = 1:n_hubs
%                        neighbor = Split_fun(Indiv,oh,nh,t,rest_route,cust_route);
%                        DepotCap = prod([neighbor.Capacity] >= [neighbor.Load]);
%                        if DepotCap
%                            Split_1_neighbors = concatStruct(Split_1_neighbors,...
%                                neighbor);
%                        end
%                    end
%                end              
%            end
%        end
%     end 
% end