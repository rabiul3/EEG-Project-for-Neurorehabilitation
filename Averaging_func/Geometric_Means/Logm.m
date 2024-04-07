function S = Logm(P)
% Logarithm of symmetric positive definite matrix P.
% This is faster than logm.m for SPD matrices.
% by Uehara


% eigenvalue decomposition
[V D] = eig(P);
D = diag(D);

if isreal(D) == 0
	disp(rank(P_sym(:,:,ii)))
	disp(D)
	error('Eigenvalues of input matrix is complex. Input of ''Logm'' must be SPD matrix.')
elseif sum(D < 0) > 0
	disp(D)
	error('Eigenvalues of input matrix include negative. Input of ''Logm'' must be SPD matrix.')
end


% logarithm of eigenvalues
%D = max(D, 0);
%L = reallog(D);
L = log(D);
L = diag(L);

% compute log of P
S = V*L*V';
S = (S + S')/2;


if isequal(S, S') == 0
	disp('Output of ''Logm.m'' is not symmetric.')
	if mean(mean(S-S')) < 10E-5
		disp('but, almost symmetric.')
	end
end
