function Exchange_f_neighbors = Exchange_f(Indiv,indexList,TRUCKS)
%Intercambia grupo de clientes sucesores de un nodo por otro grupo 
    %intra/extra ruta e intra/extra depósito
    
    %Lista de grupo de nodos para intercambiar con los índices de la antigua
        %ubicación del primer cliente
    nodeIncomplIndiv = extractNode(Indiv,indexList,'exchange','f');
    
    %Vecindario de nodos generados en cada posible intercambio factible
        %para Exchange-b 
    Exchange_f_neighbors = Exchange_fun(Indiv,nodeIncomplIndiv,TRUCKS.Capacity,'f');
    
end