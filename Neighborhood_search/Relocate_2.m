function Relocate_2_neighbors = Relocate_2(Indiv,indexList,TRUCKS)
%Relocaliza un par de nodos en cada posición intra/inter ruta e intra/inter depósito

    %Lista de nodos para relocalizar, individuos sin los nodos e índices de
        %los nodos previo a la extracción
    nodeIncomplIndiv = extractNode(Indiv,indexList,'relocate','2');
    
    %Vecindario de soluciones factibles para 'Relocate_2'
    Relocate_2_neighbors = Relocate_fun(Indiv,nodeIncomplIndiv,TRUCKS.Capacity,'2');
    
end