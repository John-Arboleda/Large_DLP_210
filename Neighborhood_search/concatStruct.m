
    function newStruct = concatStruct(prevStruct,addStruct,Op)
    %Construye un nuevo Struct o concatena dos struct en la estructura
        %de vecindades
        if isempty(prevStruct)
            newStruct = struct('Neighbor',addStruct,'Operator',Op,'TotalCost',0);
        else
            newStruct = struct('Neighbor',addStruct,'Operator',Op,'TotalCost',0);
            newStruct = [prevStruct,newStruct];
        end
    end