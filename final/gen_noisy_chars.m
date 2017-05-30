function[noisy_alphabet] = gen_noisy_chars(alphabet)

    noisy_alphabet = alphabet;
    for i = 1:size(noisy_alphabet, 2)
        %get three random numbers between 1 and 35 (number of px in each
        %imgage
        rands = randperm(length(noisy_alphabet),3);
        for j = 1:3
            if noisy_alphabet(rands(j), i) == 1
                noisy_alphabet(rands(j), i) = -1;
            else
                noisy_alphabet(rands(j), i) = 1;
            end
        end
    end
end
