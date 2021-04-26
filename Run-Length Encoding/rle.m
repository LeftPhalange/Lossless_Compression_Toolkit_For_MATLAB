classdef rle
    %RLE Class for run-length encoding.
    %   Uses the run-length encoding standard to compress given data by
    %   counting consecutive characters. Done by Neil Nguyen.
    
    methods (Static)
        function encoded = encode(str)
            prev_char = "";
            count = 0;
            encoded_str = "";
            str = char(str); % we need to convert it to a char array to use the indexer
            for i=1:strlength(str)
                current_char = str(i);
                %fprintf ('Current character: %s\n', current_char);
                if (prev_char == "")
                    prev_char = current_char;
                    count = 1;
                else
                    if (prev_char == current_char)
                        count = count + 1;
                    else
                        % fprintf('Appending to encoding: %d%s\n', count, prev_char)
                        encoded_str = encoded_str + count + prev_char;
                        prev_char = current_char;
                        count = 1;
                    end
                end
            end
            encoded = encoded_str + count + prev_char;
        end
        function decoded = decode(str)
            arr=split(str,'');
            decoded = "";
            for i=2:2:size(arr)-1
                frequency = str2double(arr(i));
                character = arr(i+1);
                for j=1:frequency
                    decoded = decoded + character;
                end
            end
        end
    end
end

