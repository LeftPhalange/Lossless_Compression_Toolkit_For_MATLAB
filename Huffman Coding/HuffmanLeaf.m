classdef HuffmanLeaf < HuffmanTree
    %HUFFMANLEAF Holds character value in object.
    
    properties
        Value
    end
    
    methods
        function obj = HuffmanLeaf(freq, char)
            obj@HuffmanTree(freq);
            obj.Value = char;
        end
    end
end

