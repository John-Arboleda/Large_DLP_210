function exchange_neighborhood = Exchange_fun(Indiv,nodeIncomplIndiv,cap,type)
%Intercambia grupos de nodos en un individuo, tomando como referencia los
%índices del primer cliente del grupo

    %Inicializa vecindario
    exchange_neighborhood = [];
    %Posible intercambios entre grupos
    iterNodes = nchoosek(1:length(nodeIncomplIndiv),2);
    for k = 1:length(iterNodes)
        %Indices de cada grupo
        index1 = nodeIncomplIndiv(iterNodes(k,1)).Index;
        index2 = nodeIncomplIndiv(iterNodes(k,2)).Index; 
        h1 = index1(1);%Índice depósito 1
        h2 = index2(1);%Índice depósito 2
        i1 = index1(2);%Índice ruta 1
        i2 = index2(2);%Índice ruta 2
        j1 = index1(3);%Indice cliente 1
        j2 = index2(3);%Indice cliente 2
        %Grupos de nodos
        nodes1 = nodeIncomplIndiv(iterNodes(k,1)).Customers;
        nodes2 = nodeIncomplIndiv(iterNodes(k,2)).Customers;
        %Los grupos no pueden tener clientes en común
        sameCustomer = any(nodes1(:,1) == nodes2(:,1)','all');
        %type 'b'/'f' son casos generales de 2-opt, no se aplica a un mismo
        %depósito para evitar repeticiones
        sameDepot = (type == 'b' | type == 'f') & h1 == h2; 
        if ~sameCustomer && ~sameDepot
            copyIndiv = Indiv;
            route1 = copyIndiv(h1).Hub(i1).Route;
            %se realiza el intercambio
            newRoute1 = [route1(1:j1-1,:);nodes2;route1(j1+length(nodes1(:,1)):end,:)];
            copyIndiv(h1).Hub(i1).Route = newRoute1;
            route2 = copyIndiv(h2).Hub(i2).Route;
            %Debe realizarse de forma secuencial para el caso de una misma ruta
            newRoute2 = [route2(1:j2-1,:);nodes1;route2(j2+length(nodes2(:,1)):end,:)];
            copyIndiv(h2).Hub(i2).Route = newRoute2;
            copyIndiv = ActualizeIndiv(copyIndiv);
            %Si la solución es factible agregar al vecindario
            feasible = checkConstrains(copyIndiv,cap);
            if feasible
                exchange_neighborhood = concatStruct(exchange_neighborhood,...
                    copyIndiv,strcat('Exchange-',type));
            end
        end
    end
end