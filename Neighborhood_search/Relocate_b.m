function Relocate_b_neighbors = Relocate_b(Indiv,indexList,TRUCKS)
%Relocaliza grupo de nodos predecesores en cada posición intra/inter ruta e 
    %intra/inter depósito

    %Lista de nodos para relocalizar, individuos sin los nodos e índices de
        %los nodos previo a la extracción
    nodeIncomplIndiv = extractNode(Indiv,indexList,'relocate','b');
    
    %Vecindario de soluciones factibles para 'Relocate_b'
    Relocate_b_neighbors = Relocate_fun(Indiv,nodeIncomplIndiv,TRUCKS.Capacity,'b');
    
end