classdef HuffmanTree
    %HUFFMANTREE Class structure for generating a Huffman tree.
    %   A Huffman Tree holds a frequency value and has a function to
    %   compare with another Tree.
    
    properties
        Frequency % frequency of this tree
    end
    
    methods
        function obj = HuffmanTree (freq)
            obj.Frequency = freq;
        end
    end
end

