function[noisy_alphabet] = gen_noisy_chars(alphabet)

noisy_alphabet = alphabet;
    for i = 1:size(noisy_alphabet, 2)
        rands = randperm(length(noisy_alphabet),3);
        for j = 1:3
            if noisy_alphabet(rands(j),i) == 1
                noisy_alphabet(rands(j),i) = -1;
            else
                noisy_alphabet(rands(j),i) = 1;
            end
        end
    end

end