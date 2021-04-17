function indexList = makeIndexList(Indiv,init)
    %Lista de la posición en la estructura de cada cliente, 
    %permite ahorrarse 3 ciclos for durante partes del algoritmo que se 
        %requieran índices
    %[h,i,j] = [hub,camión/ruta,cliente]
    indexList = [];
    %Iteraciones entre depósitos
    for h = 1:length(Indiv)
       for i = 1:length(Indiv(h).Hub)
           for j = init:length(Indiv(h).Hub(i).Route(:,1))
               if Indiv(h).Open
                    indexList = [indexList;[h,i,j]];
               end
           end
       end  
    end
end   
