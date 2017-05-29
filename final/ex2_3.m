% What options would you have when you need to store 25 characters with the 
% matlab routines in such a way that characters with three random inversions
% can be retrieved perfectly? Demonstrate a method using the first 25
% characters of your collection as a basis.


% [w, pc, ev] = pca(alphabet);
% mu = mean(alphabet);
% xhat = alphabet - mu; % subtract the mean
% norm(pc * w' - xhat)
% plot(mu)
% title('mean')

num_letters = 25;
error = [];

[alphabet, target] = get_alphabet(1);
T = eye(num_letters); % identity matrix
P = [];
for i=1:num_letters
    P = vertcat(P, alphabet(:, i)');
end
%Create network
numN = [100 60];
trainAlg = 'trainbr';
net = feedforwardnet(numN, trainAlg);
net.layers{2}.transferFcn = 'tansig';
net.trainParam.epochs = 5000;

net = train(net, P', T');

Pn = gen_noisy_chars(P');

Y = sim(net, Pn);
Y = compet(Y);

output = [];
for i = 1:size(Y,2)
     index = find(Y(:,i));
     output(:,i) = alphabet(:,index); 
end

show_chars(num_letters, P, 'Original letters', 1);
show_chars(num_letters, Pn', 'Noisy letters', 2);
show_chars(num_letters, output', 'Reconstructed noisy letters', 3);