function Exchange_2_neighbors = Exchange_2(Indiv,indexList,TRUCKS)
%Intercambia dos clientes por otros dos intra/inter ruta e intra/inter depósito

    %Lista de pares de nodos para intercambiar con los índices de la antigua
        %ubicación del primer cliente
    nodeIncomplIndiv = extractNode(Indiv,indexList,'exchange','2');
    
    %Vecindario de nodos generados en cada posible intercambio factible
        %para Exchange-2 
    Exchange_2_neighbors = Exchange_fun(Indiv,nodeIncomplIndiv,TRUCKS.Capacity,'2');
    
end