function show_chars(num_letters, chars, desc, ind)

if ind == 1
    figure;
end

subplot(num_letters, 3, ind);

    for i = 1:num_letters
        letter = chars(i,:);
        letter = reshape(letter,5,7)'; 

        subplot(5,5,(i));
        colormap('winter')
        imagesc(letter)
        hold on
        axis off
    end
end
