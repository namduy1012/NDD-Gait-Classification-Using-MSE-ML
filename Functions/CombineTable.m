function out = CombineTable(in)
    out = [];
    for i = 1:length(in)
        out = [out ; in{i}]; 
    end
end