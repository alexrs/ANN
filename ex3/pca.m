
x = randn(50,500);

%covariance matrix with zero-mean
cov_mat = cov(x);
%eigenvectors and eigenvalues of the covariance matrix
[v, d] = eig(cov_mat);
%get the k largest eigenvalues and corresponding eigenvectors of v
[v_red, d_red] = eigs(v,100);
% new data
z = x * v_red';

% recover data
xhat = z * v_red;
% add the mean (?)

% calculate the error
sqrt(mean(mean((x-xhat).^2)))