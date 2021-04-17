function Relocate_1_neighbors = Relocate_1(Indiv,indexList,TRUCKS)
%Relocaliza un nodo en cada posición intra/inter ruta e intra/inter depósito
    
    %Lista de nodos para relocalizar, individuos sin los nodos e índices de
        %los nodos previo a la extracción
    nodeIncomplIndiv = extractNode(Indiv,indexList,'relocate','1');
    tic
    %Vecindario de soluciones factibles para 'Relocate_1'
    Relocate_1_neighbors = Relocate_fun(Indiv,nodeIncomplIndiv,TRUCKS.Capacity,'1');
    toc
end
%     %Inicializa Struct de todas las vencindades
%     Relocate_1_neighbors = struct([]);
%     %número de depósitos
%     n_hubs = length(Indiv);
%     for oh = 1:n_hubs
%        %número de camiones en el depósito
%        for t = 1:length(Indiv(oh).Hub)
%            route = Indiv(oh).Hub(t).Route;
%            for c = 1:length(route(:,1))
%                %Individuo incompleto
%                incomp_Indiv = Indiv;
%                %ruta sin el nodo extraído
%                rest_route = route;
%                rest_route(c,:) = [];
%                %Cierra una ruta de ser necesario
%                if isempty(rest_route)
%                    incomp_Indiv(oh).Hub(t) = [];
%                    incomp_Indiv(oh).N_veh = incomp_Indiv(oh).N_veh - 1;
%                else
%                    incomp_Indiv(oh).Hub(t).Route = rest_route;
%                    incomp_Indiv(oh).Hub(t).Load = sum(rest_route(:,2));
%                end
%                %Actualiza carga del depósito
%                incomp_Indiv(oh).Load = sum([incomp_Indiv(oh).Hub.Load]);
%                %ruta de un solo nodo
%                aCustomer = route(c,:);
%                Relocate_1_neighbors = [Relocate_1_neighbors, ...
%                   Relocate_fun(incomp_Indiv,Indiv,aCustomer,TRUCKS{1,1})];
%            end              
%        end
%     end
%     
%     function sub_neighborhood = Relocate_fun(IncompIndiv,compIndiv,node,TruckCap)
%     %Actualiza un individuo a partir de un depósito, un número de ruta, una
%     %ruta original y una nueva ruta
%         sub_neighborhood = [];
%         for D = 1:length(IncompIndiv)
%             %no puede exceder la capacidad del depósito
%             newDepotCap = IncompIndiv(D).Load + sum(node(:,2));
%             if newDepotCap <= IncompIndiv(D).Capacity
%                 for T = 1:length(IncompIndiv(D).Hub)
%                     %No puede excerder la capacidad del camión
%                     newRouteCap = IncompIndiv(D).Hub(T).Load + sum(node(:,2));
%                     if newRouteCap <= TruckCap
%                         cRoute = IncompIndiv(D).Hub(T).Route;
%                         for N = 0:length(cRoute(:,1))
%                             %Actualizo ruta
%                             copyIndiv = IncompIndiv;
%                             nRoute = [cRoute(1:N,:);node;cRoute(N+1:end,:)];
%                             copyIndiv(D).Hub(T).Route = nRoute;
%                             copyIndiv(D).Hub(T).Load = sum(nRoute(:,2));
%                             copyIndiv(D).Load = sum([copyIndiv(D).Hub.Load]);
%                             if ~isequaln(copyIndiv,compIndiv) %no puede construir el mismo individuo
%                                 sub_neighborhood = ...
%                                     concatStruct(sub_neighborhood, copyIndiv);
%                             end
%                             %Actaulizar demanda de depósito y 
%                             %concatenar a vecindario
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end