function [M] = EuclideanGeometricMedian(x)
% Geometric median of SPD matrices in Euclidean space
% by Uehara

% Weiszfeld's algorithm

disp('Computing Euclidean geometric median.')

if PositiveDefiniteCheck(x) == 0
	error('Input sample matrices are NOT positive-definite. They must be SPD.')
end


M = eye(size(x, 1));
%epsilon = 1E-7;
%epsilon = 1E-5;
epsilon = 1E-3;
e = 1;

%disp('Current error in Euclidean geometric median is ...')
while e > epsilon
	% compute new median 'y' from data 'x' and current median 'M'
	a = zeros(size(x, 1));
	b = 0;
	for ii = 1:size(x, 3)
		dis(ii) = norm(x(:,:,ii) - M, 'fro');
		a = a + x(:,:,ii)/dis(ii);
		b = b + 1/dis(ii);
	end
	y = a/b;

	% error
	e = norm(y-M, 'fro');
	%disp(sprintf('Current error in Euclidean geometric median is %#10.4e. %e', e, sum(dis)))

	% updata geometric median 'M'
	M = y;
end

M = (M+M')/2;