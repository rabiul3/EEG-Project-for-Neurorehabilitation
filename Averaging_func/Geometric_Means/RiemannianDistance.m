function d = RiemannianDistance(P1, P2, method)
% Riemannian distance between SPD matrices, P1 and P2.
% by Uehara

% input
% P1: SPD matrix
% P2: SPD matrices (3-dim; dim x dim x sample)
% output
% d: Riemannian distances (sample x 1)


for ii = 1:size(P2,3)
	P = P1 / P2(:,:,ii);
	P = (P+P')/2;
	lambda = eig(P);
	d(ii,1) = norm(log(lambda));
end


return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% default method is '1'
narginchk(2,3)
if nargin == 2, method =1; end

% mat2cell
n = size(P2,3);
p1 = cell(n, 1);
p2 = cell(n, 1);
p1(:,1) = {P1};
for ii = 1 : n;
	p2(ii, 1) = {P2(:,:,ii)};
end

% This is correct but a little bit slow.
%m = cell(n,1);
%m(:,1) = {method};
%d = cellfun(@RDistance, p1, p2, m);

if method == 1
	%disp('method 1')
	%lambda = eig(P1 \ P2);
	%d = norm(log(lambda), 2);

	p = cellfun(@mldivide, p1, p2, 'UniformOutput', false);
	Lambda = cellfun(@eig, p, 'UniformOutput', false);
	D = cellfun(@log, Lambda, 'UniformOutput', false);
	d = cellfun(@norm, D);

elseif method == 2
	disp('method 2')
	%D = logm(P1 \ P2);
	%d = norm(D,'fro');

	p = cellfun(@mldivide, p1, p2, 'UniformOutput', false);
	D = cellfun(@logm, p, 'UniformOutput', false);
	fro = cell(n, 1);
	fro(:,1) = {'fro'};
	d = cellfun(@norm, D, fro);

elseif method == 3
	
	%RiemannianDistance = @(x, y) Norm(x,Logarithm(x,y));
	%Norm = @(x, v) sqrt(trace((v*inv(x))^2)); % Riemannian norm

	p = cellfun(@Logmap, p1, p2, 'UniformOutput', false);
	d = cellfun(@RiemannianNorm, p1, p);
end