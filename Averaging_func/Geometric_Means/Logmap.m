function [S] = Logmap(P, P_i, method)
% Logarithm map of SPD matrice 'P_i' to the tangent space at 'P'.
% P and P_i is PSD matix on Riemannian manifold.
% by Uehara
% Algorithm is Affine invariant.


%% check input arguments
if nargin == 2
	method = 'EIG';
end
if strcmp(method, 'EIG') + strcmp(method, 'logm') == 0
	error('3rd argument must be ''EIG'' or ''logm''.');
end


%% compute logarithm maps
n = size(P_i, 3);
R = sqrtm(P);

for ii = 1:n
	P0 = R \ P_i(:,:,ii) / R;
	P0 = (P0 + P0') / 2;
	%[Pchk(1,ii), P0] = PositiveDefiniteCheck(P0);

	switch method
		case 'EIG'
			S(:,:,ii) = R * Logm(P0) * R;
		case 'logm'
			L = logm(P0);
			L = (L+L')/2;
			S(:,:,ii) = R * L * R;
	end
	S(:,:,ii) = (S(:,:,ii)+S(:,:,ii)')/2;
end
%real_SPD_check_before_log = prod(Pchk)



return


%% cell use %%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_icell = cell(n, 1);
Rcell = cell(n, 1);
for ii = 1:n
	P_icell(ii, 1) = {P_i(:,:,ii)};
	Rcell(ii, 1) = {R};
end

tic
A1 = cellfun(@mldivide, Rcell, P_icell, 'UniformOutput', false); % R\P_i
A2 = cellfun(@mrdivide, A1, Rcell, 'UniformOutput', false); % R\P_i/R
[a b] = cellfun(@PositiveDefiniteCheck, A2, 'UniformOutput', false);
b
toc
tic
%A3 = cellfun(@logm, A2, 'UniformOutput', false); % logm(R\P_i/R)
for ii = 1:n
	A3{ii,1} = logm(A2{ii,1});
end
toc
tic
A4 = cellfun(@mtimes, Rcell, A3, 'UniformOutput', false); % R*logm(R\P_i/R)
A5 = cellfun(@mtimes, A4, Rcell, 'UniformOutput', false);
toc

S = zeros(size(P,1), size(P,1), n);
for ii = 1:n
	S(:,:,ii) = cell2mat(A5(ii,1));
end