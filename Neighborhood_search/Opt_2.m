


function Opt_2_neighbors = Opt_2(Indiv,TRUCKS)
    %Inicializa Struct de todas las vencindades 2-opt
    Opt_2_neighbors = [];
    %número de depósitos
    n_hubs = length(Indiv);
    for h = 1:n_hubs
       %número de camiones en el depósito
       n_trucks = length(Indiv(h).Hub);
       if n_trucks > 1 %itera sólo si hay más de una ruta
           %Combinatorio par de las rutas del depósito
           pair_comb = nchoosek(1:n_trucks,2);
           for c = 1:length(pair_comb(:,1))
               %vecindades de cada combinación
               Opt_2_neighbors = iterate_pair(Indiv,h,pair_comb(c,:),...
                   TRUCKS.Capacity,Opt_2_neighbors);
           end  
       end
    end
    
    function neighbors = iterate_pair(aIndiv,hub,pair,cap,neighbors)
    %itera las posible combinaciones 2-opt de un par de rutas, retorna un
    %Struct con todas las combinaciones factibles
        %Rutas seleccionadas
        route_1 = aIndiv(hub).Hub(pair(1)).Route;
        route_2 = aIndiv(hub).Hub(pair(2)).Route;
        %Itera cada nodo de la ruta 1 con un nodo de la ruta 2
        for i = 0:length(route_1(:,1))
            for j = 0:length(route_2(:,1))
                if i > 0 || j > 0 %Evita repetir la concatenación de rutas
                    %Concatena los fragmentos separados de cada ruta
                    m_route_1 = [route_1(1:i,:);route_2(j+1:end,:)];
                    m_route_2 = [route_2(1:j,:);route_1(i+1:end,:)];
                    %Genera una copia del individuo y la actualiza con las
                    %nuevas rutas y su demanda
                    copyIndiv = aIndiv;
                    copyIndiv(hub).Hub(pair(1)).Route = m_route_1;
                    copyIndiv(hub).Hub(pair(2)).Route = m_route_2;
                    copyIndiv = ActualizeIndiv(copyIndiv);
                    feasible = checkConstrains(copyIndiv,cap);
                    %Si la solución es factible, agregar al vecindario
                    if feasible
                        neighbors = concatStruct(neighbors,copyIndiv,'2-Opt');
                    end
                end
            end
        end
    end 
end
%     function neighbors = base_case_pair(aIndiv,hub,pair,cap,neighbors)
%     %Evalúa si es posible eliminar una ruta al concatenar dos rutas
%         %Concatena las rutas de ambas formas
%         route_1 = aIndiv(hub).Hub(pair(1)).Route;
%         route_2 = aIndiv(hub).Hub(pair(2)).Route;
%         %Calcula si es factible unir las rutas
%         totalLoad = sum([route_1(:,2);route_2(:,2)]);
%         exceedLoad = totalLoad > cap;
%             if ~exceedLoad %Si no excede la capacidad el camión
%             %Generar dos vecinos con cada uno de las nuevas rutas
%                 %Genera un vecino, elimina una de las rutas 
%                 copyIndiv1 = aIndiv;
%                 m_route_1 = [route_1; route_2];
%                 copyIndiv1(hub).Hub(pair(1)).Route = m_route_1;
%                 copyIndiv1(hub).Hub(pair(1)).Load = totalLoad;
%                 copyIndiv1(hub).Hub(pair(2)) = [];
%                 copyIndiv1(hub).N_veh = copyIndiv1(hub).N_veh - 1;
%                 neighbors = concatStruct(neighbors,copyIndiv1,'2-Opt');
%                 %Genera segundo vecino, elimina otra de las rutas 
%                 copyIndiv2 = aIndiv;
%                 m_route_2 = [route_2; route_1];
%                 copyIndiv2(hub).Hub(pair(1)).Route = m_route_2;
%                 copyIndiv2(hub).Hub(pair(1)).Load = totalLoad;
%                 copyIndiv2(hub).Hub(pair(2)) = [];
%                 copyIndiv2(hub).N_veh = copyIndiv2(hub).N_veh - 1;
%                 neighbors = concatStruct(neighbors,copyIndiv2,'2-Opt');
%             end
%     end
