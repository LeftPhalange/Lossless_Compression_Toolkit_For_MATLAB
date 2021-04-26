% Huffman coding
disp ("Huffman:")
[final_tree, symbol_map, encoded] = huffman.encode("This is a test");
decoded_string = huffman.decode(encoded, final_tree)

% LZW encoding
disp ("LZW:")
encoded_string = lzw.encode("TOBEORNOTTOBEORTOBENOT");
decoded_string = lzw.decode(encoded_string)

% Run-lemgth encoding
disp ("RLE:");
encoded_string = rle.encode("TOBEORNOTTOBEORNOT");
decoded_string = rle.decode(encoded_string)