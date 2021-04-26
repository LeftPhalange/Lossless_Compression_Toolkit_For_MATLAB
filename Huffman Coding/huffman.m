% Principal class to access Huffman coding functions (encode, decode)
% Encoding uses Rosetta Code's Java implementation, linked below:
% https://rosettacode.org/wiki/Huffman_coding#Java
% HuffmanTree, HuffmanNode, and HuffmanLeaf were borrowed from said code.

% PQueue and Queue classes credits goes to Dimitri Shvorob
% The encoding routine uses the Priority Queue to easily sort tree
% subclass objects of frequencies (in ascending order using a custom
% comparator function)

% Done by Ethan Bovard for Dr. Weeks' MATLAB course at Georgia State University.

classdef huffman
    % Class file for Huffman coding. Uses object orientation for the tree,
    % the nodes, and leaves (containing letters and their frequencies).
    methods (Static)
        function [final_tree, symbol_map, encoded] = encode (str)
            % Generates an encoded Huffman string, str must be made in
            % single quotes or otherwise can be converted to a char vector
            % generate frequency map
            if isa(str, 'string')
                str = char(str);
            end
            frequency_map = huffman_util.generate_frequency_map(str);
            % create leaves based on frequency map
            priority_queue = PQueue('HuffmanTree', @huffman_util.compare_obj);
            % start buildTree routine
            disp ('Building Huffman tree...');
            keys = frequency_map.keys(); % keys should be a [1, N] vector
            key_len = size(keys);
            for i=1:key_len(2)
                % fprintf('priority_queue count: %d\n', priority_queue.size);
                key = keys{1, i};
                fprintf('Adding key to priority queue: %s\n', key);
                freq = frequency_map(key);
                if freq > 0
                    obj = HuffmanLeaf(freq, key);
                    priority_queue.offer(obj);
                end
            end
            while (priority_queue.size() > 1)
                tree_a = priority_queue.poll();
                tree_b = priority_queue.poll();
                priority_queue.offer(HuffmanNode(tree_a, tree_b));
            end
            string_buffer = java.lang.StringBuffer();
            final_tree = priority_queue.poll();
            fprintf('Symbol\tWeight\tHuffman Code\n');
            symbol_map = containers.Map();
            symbol_map = huffman_util.print_codes(final_tree, string_buffer, symbol_map);
            % encode the string
            encoded = "";
            str_size = size(str);
            for i=1:str_size(1)
                for j=1:str_size(2)
                    ch = str(i, j);
                    encoded = encoded + string(symbol_map(ch));
                end
            end
        end
        function out = decode (encoded, tree)
            decoded = "";
            % The encoded string should be a [1,N] vector when converted to
            % a char array
            encoded_char_arr = char(encoded);
            arr_size = size(encoded_char_arr);
            curr_node = tree;
            for i=1:arr_size(2)
                if encoded_char_arr(i) == '0'
                	curr_node = curr_node.Left;
                	fprintf('%c', '0');
                elseif encoded_char_arr(i) == '1'
                	curr_node = curr_node.Right;
                	fprintf('%c', '1');
                end
                if huffman_util.is_leaf(curr_node)
                    fprintf('\n');
                    fprintf('Found leaf node with character %c...\n', curr_node.Value);
                    decoded = decoded + curr_node.Value;
                    curr_node = tree; % back to the root node
                end
            end
            out = decoded;
        end
    end
end