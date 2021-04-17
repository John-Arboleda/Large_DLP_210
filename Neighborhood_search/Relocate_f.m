function Relocate_f_neighbors = Relocate_f(Indiv,indexList,TRUCKS)
%Relocaliza grupo de nodos sucesores en cada posición intra/inter ruta e 
    %intra/inter depósito
    
    %Lista de nodos para relocalizar, individuos sin los nodos e índices de
        %los nodos previo a la extracción
    nodeIncomplIndiv = extractNode(Indiv,indexList,'relocate','f');
    
    %Vecindario de soluciones factibles para 'Relocate_f'
    Relocate_f_neighbors = Relocate_fun(Indiv,nodeIncomplIndiv,TRUCKS.Capacity,'f');
    
end