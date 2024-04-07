% This is 2r CSP filter.
%by Matteo Sartori

function [Y] = CSPfilter( S1, S2, sig, r )
% inputs
% S1, S2: class covariance matrix
% sig: data tensor (time sample x channels x trials)
% r: Number of filter is 2r.

% outputs
% Y: feature vectors (nuber of filter(2r) x trials)


M = size(S1,1);
if r<M
    Y = zeros(2*r, size(sig, 3)); % feature vectors (filters x trials)
else
    Y = zeros(M, size(sig, 3));
end

% build 2r filters
[W, D] = eig(S1, S1+S2);
if r<M
    V = W( :, [1:r M-r+1:M] ); % eigen vectors (channels x filters)
else
    V = W;
end


% apply CSP filters
for k = 1 : size(sig, 3)
    y = var( V' * sig(:,:,k)', 0, 2 ); % feature vector (filters x 1)
    Y(:,k) = y;
end

