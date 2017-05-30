% Build a Hopfield neural network that is capable of retrieving the first 5 
% of these characters. Distort each character by inverting three randomly 
% chosen pixels (so you change 1 to -1 and viceversa) and check if the network
% is able to recall these distorted patterns. Discuss the existence of spurious patterns.
[alphabet, ~] = get_alphabet();

a = alphabet(:, 1)';
l = alphabet(:, 2)';
e = alphabet(:, 3)';
j = alphabet(:, 4)';
n = alphabet(:, 5)';

num_letters = 5;
index_dig = [1,2,3,4,5];
T = [a;l;e;j;n]';
%Create network
net = newhop(T);

%Check if digits are attractors
[Y,~,~] = sim(net,num_letters,[],T);

show_chars(num_letters, Y','Attractors', 1);

Xn = gen_noisy_chars(T);

%Show noisy digits:
noisy_a = Xn(:, 1)';
noisy_l = Xn(:, 2)';
noisy_e = Xn(:, 3)';
noisy_j = Xn(:, 4)';
noisy_n = Xn(:, 5)';

Tn = [noisy_a; noisy_l; noisy_e; noisy_j; noisy_n];

subplot(num_letters,3,2);
show_chars(num_letters, Tn, 'Noisy letters', 2);

num_steps = 8;

Tn = Tn';
[Yn,~,~] = sim(net,{num_letters num_steps},{},Tn);
Yn = Yn{1,num_steps};
Yn = Yn';

subplot(num_letters,3,3);

show_chars(num_letters, Yn, 'Reconstructed noisy letters', 3);