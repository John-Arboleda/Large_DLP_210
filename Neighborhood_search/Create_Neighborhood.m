function neighborhood = Create_Neighborhood(Indiv, TRUCKS)
%Crea un vecindario a partir de 14 operadores de búsqueda local
    %derivado del individuo
    
    %Lista de indices relacionados de depósito, ruta, cliente
    indexList = makeIndexList(Indiv,1);
    
    tic
    
    Opt_2_neighbors = Opt_2(Indiv,TRUCKS);
    
    Split_0_neighbors = Split_0(Indiv,indexList,TRUCKS);

    Split_1_neighbors = Split_1(Indiv,indexList,TRUCKS);

    Split_2_neighbors = Split_2(Indiv,indexList,TRUCKS);
    
    Split_b_neighbors = Split_b(Indiv,indexList,TRUCKS);
    
    Split_f_neighbors = Split_f(Indiv,indexList,TRUCKS);

    Relocate_1_neighbors = Relocate_1(Indiv,indexList,TRUCKS);

    Relocate_2_neighbors = Relocate_2(Indiv,indexList,TRUCKS);

    Relocate_b_neighbors = Relocate_b(Indiv,indexList,TRUCKS);

    Relocate_f_neighbors = Relocate_f(Indiv,indexList,TRUCKS);

    Exchange_1_neighbors =  Exchange_1(Indiv,indexList,TRUCKS);

    Exchange_2_neighbors =  Exchange_2(Indiv,indexList,TRUCKS);

    Exchange_b_neighbors =  Exchange_b(Indiv,indexList,TRUCKS);

    Exchange_f_neighbors =  Exchange_f(Indiv,indexList,TRUCKS);

    neighborhood = [Opt_2_neighbors,Split_0_neighbors,Split_1_neighbors,...
                    Split_2_neighbors, Split_b_neighbors, Split_f_neighbors,... 
                    Relocate_1_neighbors, Relocate_2_neighbors,Relocate_b_neighbors,...
                    Relocate_f_neighbors,Exchange_1_neighbors,Exchange_2_neighbors,... 
                    Exchange_b_neighbors,Exchange_f_neighbors];
    
    
    toc
end