function relocate_neighborhood = Relocate_fun(Indiv,nodeIncomplIndiv,cap,type)
%Relocaliza un grupo de nodos en cada posición de cada ruta de cada
    %depósito
    relocate_neighborhood = [];
    for k = 1:length(nodeIncomplIndiv)
        %Grupo de nodos
        node = nodeIncomplIndiv(k).Customers;
        %Individuo incompleto sin el nodo
        incomplete = nodeIncomplIndiv(k).Incomplete;
        %Índices del incompleto, empiezan desde cero
        incomplIndexList = makeIndexList(incomplete,0);
        for m = 1:length(incomplIndexList(:,1))
            h = incomplIndexList(m,1); %Depósito
            j = incomplIndexList(m,2); %Ruta
            i = incomplIndexList(m,3); %Posición
            copyIndiv = incomplete;
            %Se relocaliza el individuo en una ruta y actualiza el incompleto
            cRoute = copyIndiv(h).Hub(j).Route;
            nRoute = [cRoute(1:i,:);node;cRoute(i+1:end,:)];
            copyIndiv(h).Hub(j).Route = nRoute;
            copyIndiv = ActualizeIndiv(copyIndiv);
            feasible = checkConstrains(copyIndiv,cap);
            %No se puede volver a crear la ruta original
            orgRoute = isequal(Indiv(h).Hub(j).Route,nRoute);
            if feasible && ~orgRoute
                relocate_neighborhood = concatStruct(relocate_neighborhood,...
                    copyIndiv,strcat('Relocate-',type));
            end       
        end
    end
end
        
        
        
%         for h = 1:max(indexList(:,1))
%             lastTruck = max(indexList(indexList(:,1) == h,2));
%             j = lastTruck + 1;
%             copyIndiv = incomplete;
%             copyIndiv(h).Hub(j).Route = node;
%             copyIndiv = ActualizeIndiv(copyIndiv);
%             feasible = checkConstrains(copyIndiv,cap);
%             if feasible
%                 s = length(relocate_neighborhood) + 1;
%                 relocate_neighborhood(s).neighbor = copyIndiv;
%             end
%         end
%     end
    
    
% end