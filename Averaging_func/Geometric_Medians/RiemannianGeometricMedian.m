function [m dis] = RiemannianGeometricMedian(P)
% Riemannian geometric median of SPD matrices 'P'.
% algorithm by P. Fletcher
% "The geometric median on Riemannian manifolds with application to robust atlas estimation"
% coded by Uehara

disp('Computing Riemannian geometric median.')

if PositiveDefiniteCheck(P) == 0
	error('Input sample matrices are NOT positive-definite. They must be SPD.')
end


alpha = 1; % step size
m = eye(size(P,1)); % initial of median 
%m = P(:,:,1);
n = size(P, 3); % number of samples
w = ones(n,1)*(1/n); % weights
%epsilon = 1E-7;
%epsilon = 1E-5;
epsilon = 1E-3;
e = 1;

a = 0;
%disp('Current error in Riemannian geometric median is ...')
while e > epsilon
	a = a+1;
    d = w ./ RiemannianDistance(m, P);
    l = Logmap(m, P);

    A = zeros(size(P,1));
    for ii = 1:n
        A = A + d(ii, 1) * l(:,:,ii);
    end
    B = sum(d);

    v = A / B; % median on TS
    v = (v+v')/2;


	%e = norm(v,'fro');
    e = trace((v/m)^2); % Riemannian norm at m
	disp(sprintf('\tCurrent error in Riemannian median is %10.4e. %#.3d', e, a))

    m = Expmap(m, alpha*v); % median on manifold
end

dis = RiemannianDistance(m, P);

