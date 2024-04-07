function [Pg, dis] = RiemannianGeometricMean(P, method)
% Riemannian geometric mean of SPD matrices
% algorithm by P.T. Fletcher and S. Joshi
% "Principal Geodesic Analysis on Symmetric Spaces: Statistics of Diffusion Tensors"
% coded by Uehara

%input
% P: 3D matrices; symmetric positive definete matrices
%output
% Pg: Riemannian geometric mean of P


disp('Computing Riemannian mean.')

% defalut method to compute log of SPD matrices is eig.m.
if nargin == 1
	method = 'EIG';
end
% if PositiveDefiniteCheck(P) == 0
% 	error('Input sample matrices are NOT positive-definite. They must be SPD.')
% end

e = 1;
epsilon = 10^(-3); % threshold of error
%epsilon = 10^(-7);
%Pg = P(:,:,1); % initial of geometric mean
Pg = eye(size(P,1));

while e > epsilon
	X = mean(Logmap(Pg, P, method), 3);

	e = norm(X,'fro');
	%disp(['Current error in Riemannian mean is ', num2str(e), '.'])
	disp(sprintf('\tCurrent error in Riemannian mean is %#10.4e.', e))

	Pg = Expmap(Pg, X);
	%X = mean(Lifting_median(Pg, P), 3);
	%Pg = Retraction_median(Pg, X);	
end

if PositiveDefiniteCheck(Pg) == 0 
	error('''Pg'' is NOT positive-definite. It must be SPD.')
end


% compute distance from the mean to samples
t = tic;
dis = RiemannianDistance(Pg, P);
time = toc(t);
%disp(sprintf('Elapsed time to compute the distance from the mean to samples is %0.5f seconds.', time))
