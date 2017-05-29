% In this part you must determine the critical loading capacity of the
% network. Choose a number P, and store P characters from your collection
% in a Hopfield neural network. Distort these characters by inverting three
% randomly chosen pixels and try to retrieve them. Do this by iterating the
% network for a chosen number of iterations and clipping (rounding) the
% pixels of the final state to +1 and -1. Calculate the error for several
% values of P and plot this error as a function of P. The error is the total
% number of wrong pixels over all the retrieved characters. Estimate the
% critical loading capacity. Compare your estimated capacity to the
% theoretical loading capacity of the Hopfield neural network that uses the
% Hebb-rule for uncorrelated patterns. Discuss the existence of spurious patterns.

[alphabet, ~] = get_alphabet(1);

letters = 5:20;
error = [];
for num_letters = letters
    index_dig = 1:num_letters;

    T = [];
    for i=1:num_letters
        T = vertcat(T, alphabet(:, i)');
    end
    T = T';
    %Create network
    net = newhop(T);

    %Check if digits are attractors
    [Y,~,~] = sim(net,num_letters,[],T);

    %show_chars(num_letters, Y', 'Attractors', 1);
    
    Xn = gen_noisy_chars(T);

    %Show noisy digits:
    Tn = [];
    for i=1:num_letters
        Tn = vertcat(Tn, Xn(:, i)');
    end

    %show_chars(num_letters, Tn, 'Noisy letters', 2);

    Tn = Tn';
    step = 30;
    T = T';

        [Yn,~,~] = sim(net,{num_letters step},{},Tn);
        Yn = Yn{1,step};
        Yn = Yn';

        %show_chars(num_letters, Yn, 'Reconstructed noisy letters', 3);

        Yn(Yn < 0) = -1;
        Yn(Yn >= 0) = 1;

        diffs = sum(sum((T == Yn) == 0));
        error = [error, diffs];
end

view(net);
figure;
plot(letters, error);
title('Error reconstructing characters');
xlabel('Characters');
ylabel('Error (in pixels)');