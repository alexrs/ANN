% What options would you have when you need to store 25 characters with the 
% matlab routines in such a way that characters with three random inversions
% can be retrieved perfectly? Demonstrate a method using the first 25
% characters of your collection as a basis.

num_letters = 25;
error = [];

% get original alphabet and targets for training
[alphabet, target] = get_alphabet();
T = target(1:num_letters, 1:num_letters);
P = alphabet(:, 1:num_letters)';

% get noisy alphabet and targets for training 
[noisy_alphabet, noisy_target] = get_alphabet();
noisy_alphabet = gen_noisy_chars(noisy_alphabet')';
noisy_T = noisy_target(1:num_letters, 1:num_letters);

P = vertcat(P, noisy_alphabet(:, 1:num_letters)');
T = vertcat(T, noisy_T);

%Create network
numNN = 10;
numN = [50];
nets = cell(1, numNN);
trainAlg = 'trainbr';
net = feedforwardnet(numN, trainAlg);
net.layers{2}.transferFcn = 'tansig';
net.trainParam.epochs = 5000;

for i = 1:numNN
  fprintf('Training %d/%d\n', i, numNN)
  nets{i} = train(net, P', T');
end

Pn = gen_noisy_chars(alphabet');
Pn = Pn(1:num_letters, :);

Y_total = 0;
for i = 1:numNN
    neti = nets{i};
    Y = sim(neti, Pn');
    Y_total = Y_total + Y;
end

Y_avg = Y_total / numNN;
Y_avg = compet(Y_avg);

output = [];
for i = 1:size(Y_avg,2)
     index = find(Y_avg(:,i));
     output(:,i) = alphabet(:,index); 
end

show_chars(num_letters, alphabet(:, 1:num_letters)', 'Original letters', 1);
show_chars(num_letters, Pn, 'Noisy letters', 2);
show_chars(num_letters, output', 'Reconstructed noisy letters', 3);

length(find(P(1:num_letters, :) ~= output'))