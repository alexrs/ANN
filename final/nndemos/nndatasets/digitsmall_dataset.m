function [inputs,targets] = digitsmall_dataset
% digitsmall_dataset   Small synthetic handwritten digit dataset
%   [inputs, targets] = digitsmall_dataset will load a dataset of synthetic
%   handwritten digits, where inputs will be a 1-by-500 cell array, with
%   each cell containing a 28-by-28 matrix representing a synthetic image
%   of a handwritten digit, and targets will be a 10-by-500 matrix
%   containing the labels for the images in 1-of-K format. This dataset is
%   a subset of digittrain_dataset.
%
%   Example:
%       Train a sparse autoencoder on images of handwritten digits and
%       visualize the learned features.
%
%       x = digitsmall_dataset;
%       hiddenSize = 25;
%       autoenc = trainAutoencoder(x, hiddenSize, ...
%           'L2WeightRegularization', 0.004, ...
%           'SparsityRegularization', 4, ...
%           'SparsityProportion', 0.2);
%       plotWeights(autoenc);
%
%   See also digittrain_dataset, digittest_dataset

% Copyright 2015 The MathWorks, Inc.

load digittrain_dataset;
inputs = xTrainImages(1:500);
targets = tTrain(:,1:500);

end