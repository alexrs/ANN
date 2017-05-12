
x = randn(50,500);
m = mean(x);
%covariance matrix with zero-mean
cov_mat = cov(x);
%get the k largest eigenvalues and corresponding eigenvectors of v
[v, d] = eigs(cov_mat, 50);
d = diag(d);
% new data
z = x * v;
% recover data
xhat = z * v';
% add the mean (?)
xhat = xhat + m;
% calculate the error
sqrt(mean(mean((x-xhat).^2)));

a = pca(x);

