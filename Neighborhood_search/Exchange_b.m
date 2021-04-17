function Exchange_b_neighbors = Exchange_b(Indiv,indexList,TRUCKS)
%Intercambia grupo de clientes predecesores de un nodo por otro grupo 
    %intra/inter ruta e intra/inter depósito

    %Lista de grupo de nodos para intercambiar con los índices de la antigua
        %ubicación del primer cliente
    nodeIncomplIndiv = extractNode(Indiv,indexList,'exchange','b');
    
    %Vecindario de nodos generados en cada posible intercambio factible
        %para Exchange-b 
    Exchange_b_neighbors = Exchange_fun(Indiv,nodeIncomplIndiv,TRUCKS.Capacity,'b');
    
end