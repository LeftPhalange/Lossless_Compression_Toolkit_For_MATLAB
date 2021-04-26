classdef huffman_util
    %HUFFMAN_UTIL Helper class for huffman.m.
    
    methods (Static)
        function symbol_map = print_codes (tree, prefix, symbol_map)
            if huffman_util.is_leaf(tree)
                % tree is an instance of HuffmanLeaf
                fprintf('%c\t%d\t%s\n', tree.Value, tree.Frequency, prefix);
                symbol_map(tree.Value) = prefix.toString();
            elseif huffman_util.is_node(tree)
                % traverse left
                prefix.append('0');
                symbol_map = huffman_util.print_codes (tree.Left, prefix, symbol_map);
                prefix.deleteCharAt(prefix.length()-1);
                % traverse right
                prefix.append('1');
                symbol_map = huffman_util.print_codes (tree.Right, prefix, symbol_map);
                prefix.deleteCharAt(prefix.length()-1);
            end
        end
        function out = is_leaf (tree)
            out = 1;
            try
                tree.Value;
            catch
                out = 0;
            end
        end
        function out = is_node (tree)
            out = 1;
            try
                tree.Left;
            catch
                out = 0;
            end
        end
        function map = generate_frequency_map(str)
            %GENERATE_FREQUENCY_MAP Generate frequency map based on each char in the
            %string.
            % Used in conjunction with huffman.m (encode) to get the frequency of each char to
            % build up the tree with these leaf nodes.
            verbose = 1;
            frequency_map = containers.Map();
            newl = '\n';
            
            char_len = size(str);
            for i=1:char_len(2)
                ch = str(i);
                if ~frequency_map.isKey(ch)
                    frequency_map(ch) = 1;
                    if (verbose) fprintf('adding character %c to frequency map...\n', ch); end
                else
                    frequency_map(ch) = frequency_map(ch) + 1;
                    if (verbose) fprintf('updating character count of %c to frequency map...\n', ch); end
                end
            end
            keys = frequency_map.keys();
            map_size = size(keys);
            for i=1:map_size(2)
                key = keys{1, i};
                if (verbose) fprintf ('char %c, count: %d\n', key, frequency_map(key)); end
            end
            map = frequency_map;
        end
        function frequency = compare_obj(a, b)
            %COMPARE_OBJ Compares two HuffmanNode objects.
            %   Returns a difference between two frequencies.
            frequency = le(a.Frequency, b.Frequency);
        end
    end
end
    
