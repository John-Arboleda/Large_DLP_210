


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
                    copyIndiv = UpdateIndiv(copyIndiv);
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