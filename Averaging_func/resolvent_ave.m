function R = resolvent_ave(A, mu, L)
% Resolvent mean of SPD matrices 'A'.
% by Uehara
% algorithm by H.H. Bauschke et al. (2010)

% input
% A: N x N matrices (N x N x n)
% L: weight vector of A (n x 1)
% mu: parameter of average 


%% argument check
n = size(A, 3);
if nargin == 2
	L = inv(n) * ones(n, 1);
elseif nargin == 1
	mu = 1;
	L = inv(n) * ones(n, 1);
end

if PositiveDefiniteCheck(A) == 0
	error('Input sample matrices are NOT positive-definite. They must be SPD.')
end

if abs(sum(L) - 1) > 1e-3
	error('The weights of matrices are not normalized.')
end

%% compute average R
N = size(A, 1);
R = zeros(N, N);

for ii = 1:size(A, 3)
	% J is resolvent of matrix A with parameter mu
	J(:,:,ii) = inv(A(:,:,ii) + inv(mu) * eye(N));
	J(:,:,ii) = (J(:,:,ii) + J(:,:,ii)')/2;
	R = R + L(ii) * J(:,:,ii);
end

R = inv(R) - inv(mu) * eye(N);
R = (R + R')/2;