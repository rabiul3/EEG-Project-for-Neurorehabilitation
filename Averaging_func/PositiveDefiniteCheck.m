function [Result, P_sym, P_pos, nonPDeig] = PositiveDefiniteCheck(P)
% This code confirms input matrices 'P' is symmetric positeve-definite (SPD) or not.
% by Uehara

% input
% P: 3-dim array (matrices)

% output
% Result: 2-dim array of results (1: positive definite, 0: non-positive definite)
% P_sym: converted matrices to SPD
% P_pos: extracted positive-definite matrices from P
% nonPDeig: eigenvalues of non-positive-definite matrices P

%tic
n = size(P,3);
m = size(P,1);

lambda = zeros(m, n);
Result = ones(1,n);
P_sym = P;
for ii = 1:n
	
	% confirm P is "real symmetric" or not
	if isreal(P(:,:,ii)) == 0
		Result(ii) = 0;
		disp('input matrix is complex.')
	elseif isequal(P(:,:,ii), P(:,:,ii)') == 0
		if mean(mean(P(:,:,ii) - P(:,:,ii)')) < 1e-6
			Result(ii) = 0;
			disp('Input matirx is almost symmetric, but NOT exactly symmetric.')
			%disp('Input matrix was comverted into symmetric bacause it was alomost symmetric.')
			P_sym(:,:,ii) = (P(:,:,ii) + P(:,:,ii)') / 2;
		else
			Result(ii) = 0;
			disp('input matrix is not symmetric.')
			P(:,:,ii) - P(:,:,ii)'
			norm(P(:,:,ii) - P(:,:,ii)', 'fro')
		end
	end

	% confirm P is "positive-definite" or not
	lambda(:,ii) = eig(P_sym(:,:,ii));
	if isreal(lambda(:,ii)) == 0
		Result(ii) = 0;
		disp('eigenvalues of input matrix is complex.')
		disp(rank(P_sym(:,:,ii)))
		disp(lambda(:, ii))
	%elseif sum(lambda(:,ii) <= 0.1) > 0
	elseif sum(lambda(:,ii) < 0) > 0
		Result(ii) = 0;
		disp('eigenvalues of input matrix include negative numbers.')
	end
end

P_pos = P(:,:,find(Result == 1));
non_positive_ind = find(Result == 0);
nonPDeig = lambda(:,non_positive_ind);

%toc

%disp(sum(Result))
%disp(ind)