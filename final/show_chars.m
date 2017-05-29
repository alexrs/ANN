function show_chars(num_letters, chars, desc, ind)

if ind == 1
    figure;
end

subplot(num_letters, 3, ind);

    for i = 1:num_letters
        letter = chars(i,:);
        letter = reshape(letter,5,7)'; 

        subplot(num_letters,3,((i-1)*3)+ind);
        imshow(letter)
        if i == 1
            title(desc)
        end
        hold on
    end

end
