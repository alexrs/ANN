data_white = importdata('winequality_data/winequality-white.csv');

row_idx_pos = (data_white.data(:, end) == 4);
data_positive = data_white.data(row_idx_pos, :);
%remove last column
data_positive = data_positive(:,1:end-1);

row_idx_neg = (data_white.data(:, end) == 5 | data_white.data(:, end) == 6);
data_negative = data_white.data(row_idx_neg, :);
%remove last column
data_negative = data_negative(:,1:end-1);

% Create and train a feedforward neural network. You will need to decide the 
% network architecture, select the transfer functions, and the learning parameters.
% Justify your choices. Train your network with the training data set. Calculate
% the correct classification ratio (CCR) for the validation set. The CCR is
% defined as: CCR = Number of Correctly classified data x 100 / Total number of data

class_positive = 1;
class_negative = -1;
P = [data_positive; data_negative];
T = vertcat(repmat(class_positive, 1, length(data_positive))', ...
repmat(class_negative, 1, length(data_negative))'); 

% divide the set intro training, validation and test
[trainInd,valInd,testInd] = dividerand(length(T));

numN = [20, 8];
trainAlg = 'trainbr'; %traingb trainlm traingd trainbfg %trainbr
net = feedforwardnet(numN, trainAlg);

net.divideFcn = 'divideind';
net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = testInd;
net.layers{2}.transferFcn = 'tansig';
net.trainParam.epochs = 400;

net = train(net, P', T');
Y = sim(net, P');

view(net)
Y(Y < 0) = -1;
Y(Y >= 0) = 1;
correct_classifications = 100 * length(find(Y==T')) / length(T);

% Compute the eigenvectors and eigenvalues of the covariance matrix of the training
% set. Plot the eigenvalue spectrum. Select a number of Principal Components
% to perform dimensionality reduction via PCA. Motivate your decision.
% Reconstruct all your training, validation and test data using the selected
% principal components. In this way you obtain a new dataset with a lower
% dimension than the original data.

[coeff,score,latent] = pca(P);
plot(100*latent/sum(latent))

dims = 4;
P_red = score(:, 1:dims);

% Using the reconstructed dataset design a new feedforward network to classify
% the data. Again, train this new network to obtain the highest CCR on the new
% validation data. Train different networks, and finally select the network
% that you think is the best for this problem. Compare both networks, the one
% trained using the original data and the one trained using the lower dimensional data

net2 = feedforwardnet(numN, trainAlg);

net2.divideFcn = 'divideind';
net2.divideParam.trainInd = trainInd;
net2.divideParam.valInd = valInd;
net2.divideParam.testInd = testInd;
net2.layers{2}.transferFcn = 'tansig';
net2.trainParam.epochs = 400;

net2 = train(net2, P_red', T');
Y_red = sim(net2, P_red');

%view(net)
Y_red(Y_red < 0) = -1;
Y_red(Y_red >= 0) = 1;
correct_classifications2 = 100 * length(find(Y_red==T'))/length(T);
