%Extrae nodos de un individuo de acuerdo al operador y tipo de variante
%Retorna un listado de nodos extraidos, un individuo sin dichos nodos, y el
    %índice dónde el primer cliente del grupo de nodos se encontraba ubicado

function nodeIncomplIndiv = extractNode(Indiv,indexList,Op,type)
    
    %Número de grupos de nodos
    iter = length(indexList);
    %Contador para excluir vecindades vacías
    emptyCounter = 0;
    for k = 1:iter
        h = indexList(k,1);%Indice Depósito
        i = indexList(k,2);%Índice Ruta/Camión
        j = indexList(k,3);%Indice Nodo/Cliente
        copyIndiv = Indiv;
        exclude = false;
        %Longitud de ruta
        len = length(copyIndiv(h).Hub(i).Route(:,1));
        switch type
            case '1'
            %Extraer sólo un nodo
                if len > 1 || ~strcmp(Op,'split')
                %Si es operador 'split', no puede dejar rutas vacías
                    customer = copyIndiv(h).Hub(i).Route(j,:);
                    copyIndiv(h).Hub(i).Route(j,:) = [];
                else
                    exclude = true;
                end
            case '2'
            %Extraer un par de nodos
                if  len ~= j && (len > 2 || ~strcmp(Op,'split'))
                %Omite rutas con un cliente o último índice sin sucesor
                    customer = copyIndiv(h).Hub(i).Route([j,j+1],:);
                    copyIndiv(h).Hub(i).Route([j,j+1],:) = [];
                else
                    exclude = true;
                end
            case 'b'
            %Extrae predecesores
                if len ~= j || ~strcmp(Op,'split')
                %Omite último nodo para no eliminar ruta
                    customer = copyIndiv(h).Hub(i).Route(1:j,:);
                    copyIndiv(h).Hub(i).Route(1:j,:) = [];
                else
                    exclude = true;
                end
            case 'f'
            %Extrae sucesores
                if j > 1
                %Omite primer nodo para no eliminar ruta
                    customer = copyIndiv(h).Hub(i).Route(j:end,:);
                    copyIndiv(h).Hub(i).Route(j:end,:) = [];
                else
                    exclude = true;
                end
        end
        
        if isempty(copyIndiv(h).Hub(i).Route) && strcmp(Op,'relocate')
            %Relocate permite cerrar rutas vacías
            copyIndiv(h).Hub(i) = [];
        end
        %Excluye vecindades vacías
        if exclude
            emptyCounter = emptyCounter + 1;
        else
            %Agrega a solución a vecinadario
            s = k - emptyCounter;
            copyIndiv = ActualizeIndiv(copyIndiv);
            nodeIncomplIndiv(s).Customers = customer;
            nodeIncomplIndiv(s).Incomplete = copyIndiv; 
            nodeIncomplIndiv(s).Index = indexList(k,:);
        end
    end
end