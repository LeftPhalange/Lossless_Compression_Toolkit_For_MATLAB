classdef HuffmanNode < HuffmanTree
    %HUFFMANNODE Holds left and right tree node pointers.    
    properties
        Left
        Right
    end
    
    methods
        function obj = HuffmanNode(left, right)
            obj@HuffmanTree(left.Frequency + right.Frequency);
            obj.Left = left;
            obj.Right = right;
        end
    end
end

