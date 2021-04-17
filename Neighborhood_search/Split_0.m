function Split_0_neighbors = Split_0(Indiv,indexList,TRUCKS)
%Divide una ruta en dos intra-depot

    %Split-0 es la variante intra-depot de split-b y split-f
    %Se extraen los nodos predecesores de cada índice
    nodeIncomplIndiv = extractNode(Indiv,indexList,'split','b');

    %Vecindario con todas la soluciones factibles
    Split_0_neighbors = Split_fun(nodeIncomplIndiv,indexList,TRUCKS.Capacity,'0');

end
%     %Inicializa Struct de todas las vencindades 2-opt
%     Split_0_neighbors = [];
%     %número de depósitos
%     n_hubs = length(Indiv);
%     for h = 1:n_hubs
%        %número de camiones en el depósito
%        for t = 1:length(Indiv(h).Hub)
%            route = Indiv(h).Hub(t).Route;
%            for c = 1:length(route(:,1))-1
%            %En cada depósito, divide una ruta y la convierte en dos 
%                route_1 = route(1:c,:);
%                route_2 = route(c+1:end,:);
%                %Genera una vecindad a partir de las dos nuevas rutas
%                Split_0_neighbors = concatStruct(Split_0_neighbors,...
%                    Split_fun(Indiv,h,h,t,route_1,route_2));
%            end
%        end
%     end
% end