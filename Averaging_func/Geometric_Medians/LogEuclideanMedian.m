function [M dis] = LogEuclideanMedian(P)
% Log-Euclidean geometric median of SPD matrices 'P'.
% See "RiemannianGeometricMedian.m" and "EuclideanGeometricMedian.m".
% coded by Uehara

disp('Computing Log-Euclidean geometric median.')

if PositiveDefiniteCheck(P) == 0
	error('Input sample matrices are NOT positive-definite. They must be SPD.')
end

I = eye(size(P,1));
V = zeros(size(P,1)); % initial of median on tangent space
n = size(P, 3); % number of samples
w = ones(n,1)*(1/n); % weights

epsilon = 1E-3;
%epsilon = 1E-5;
e = 1;

%disp('Current error in Log-Euclidean geometric median is ...')
l = Logmap(I, P); %logarithm of Ps
while e > epsilon

	% compute median on tangent space 'v'
	A = zeros(size(P, 1));
	B = 0;
	for ii = 1:n
		logdis(ii) = norm(V - l(:,:,ii), 'fro');
		d = w(ii) / logdis(ii); %used like weight for l
		A = A + d * l(:,:,ii);
		B = B + d;
	end
	v = A / B; % median on TS
	v = (v+v')/2;

	% compute error
	e = norm(v-V, 'fro');
	%disp(sprintf('Current error in Log-Euclidean median is %10.4e. %e', e, sum(logdis)))

	% update median on TS
	V = v;
end

% compute median on manifold
M = expm(V);

dis = RiemannianDistance(M, P);


