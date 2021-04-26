classdef lzw
    % LZW Class for the LZW encoding.
    %   Encodes or decodes a string using LZW.
    
    methods(Static)
        function encoded = encode(uncompressed)
            dictSize = 256;
            dictionary = containers.Map();
            
            %Populate first 256 characters in dictionary
            for i = 0:1:255
                dictionary(char(i)) = i;
            end
            
            %String to char cell array
            chars = char(uncompressed);
            
            %Encode
            w = "";
            listResult = java.util.ArrayList();
            for i=1:1:length(chars)
                c = chars(i);
                wc = "" + w + c; % append w and c
                if(isKey(dictionary, wc) == 1)
                    w = "" + wc;
                else
                    listResult.add(dictionary(w));
                    % Add wc to the dictionary.
                    dictionary(wc) = dictSize;
                    dictSize = dictSize + 1; % increment because postfix
                    w = "" + c;
                end
            end
            if (w ~= "")
                listResult.add(dictionary(w));
                disp (dictionary(w));
            end
            
            encoded = listResult;
            fprintf("size of encoded: %d\n", encoded.size());
        end
        
        function decoded = decode(compressed)
            % start decode
            dictSize = 256;

            % Initialize code table
            dictionary = containers.Map();
            for i=0:1:255
                dictionary("" + i) = char(i);
            end
            % Start decoding process using dict
            w = "" + char(compressed.remove(0));
            decoded = "" + w;
            for i=0:1:compressed.size()-1
                clear entry;
                entry = ""; % initialize entry
                k = compressed.get(i);
                if isKey(dictionary, k + "")
                    entry = "" + dictionary("" + k);
                elseif k == dictSize
                    entry = w + w(1);
                end
                
                decoded = "" + decoded + entry;
                
                % add w + entry(1) to the dictionary
                first_entry_char = entry{1}(1); % tricky MATLAB indexing of a string
                dictionary("" + dictSize) = "" + w + first_entry_char;
                dictSize = dictSize + 1; % postfix increment so this goes here
                w = entry;
            end
        end
    end
end

