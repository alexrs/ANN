data_white = importdata('winequality_data/winequality-white.csv');
data_red = importdata('winequality_data/winequality-red.csv');

row_idx = (data_white.data(:, end) == 4);
data_positive = data_white.data(row_idx, :);
%remove last column
data_positive = data_positive(:,1:end-1);

row_idx_2 = (data_red.data(:, end) == 5 | data_red.data(:, end) == 6);
data_negative = data_red.data(row_idx_2, :);
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

numN = 5;
trainAlg = 'trainlm';
net = feedforwardnet(numN, trainAlg);

% set early stopping parameters
net.divideParam.trainRatio = 0.70; % training set [%]
net.divideParam.valRatio = 0.15; % validation set [%]
net.divideParam.testRatio = 0.15; % test set [%]

[net,tr,Y,E] = train(net, P', T');
a = sim(net, P');

%view(net)
threshold = 0.5;
Y = double(Y > threshold)';
correct_classifications = 100*length(find(Y==T))/length(T);

% Compute the eigenvectors and eigenvalues of the covariance matrix of the training
% set. Plot the eigenvalue spectrum. Select a number of Principal Components
% to perform dimensionality reduction via PCA. Motivate your decision.
% Reconstruct all your training, validation and test data using the selected
% principal components. In this way you obtain a new dataset with a lower
% dimension than the original data.

% Using the reconstructed dataset design a new feedforward network to classify
% the data. Again, train this new network to obtain the highest CCR on the new
% validation data. Train different networks, and finally select the network
% that you think is the best for this problem. Compare both networks, the one
% trained using the original data and the one trained using the lower dimensional data
