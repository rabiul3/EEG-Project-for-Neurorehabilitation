function [Pg, dis] = LogEuclideanMean(P)
% Karcher mean using Log Euclidean distance, Frobenius norm of log(x)-log(y).
% by Uehara

% Algorithm by S. Fiori, T. Tanaka
% "An Algorithm to Compute Averages on Matrix Lie Groups"

% input
% P: 3-dim matrices; SPD matrices
% output
% Pg: LogEuclidean mean of P

disp('Computing Log-Euclidean mean.')

%% input check
if PositiveDefiniteCheck(P) == 0
	error('Input sample matrices are NOT positive-definite. They must be SPD.')
end


%% compute the mean (for state is used, but fastest)
m = size(P, 1);
t = tic;
N = size(P,3); X = zeros(size(P,1));
for ii = 1:N
	X = X + Logm(P(:,:,ii));
end
Pg = expm(X/N); Pg = (Pg+Pg')/2;
time = toc(t);
%disp(sprintf('Elapsed time to compute the Log Euclidean Mean is %0.5f seconds.', time))


%% compute distance from the mean to samples
t = tic;
dis = RiemannianDistance(Pg, P);
time = toc(t);
%disp(sprintf('Elapsed time to compute the distance from the mean to samples is %0.5f seconds.', time))

return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% not use for state, but use Logmap.m. (little slow)
%Pg = expm(mean(Logmap(eye(m), P), 3));


%% use weight
tic
N = size(P,3);
w = ones(N,1) ./ N;
X = linearsum(w, Logmap(eye(m), P));
Pg0 = expm(X);
toc
%return



%% use for
disp('for')
tic
N = size(P,3);
w = ones(N,1) ./ N;
X = zeros(m);
for ii = 1:N
	X = X + w(ii)*Logm(P(:,:,ii));
end
%X = X/N;
Pg1 = expm(X);
toc


%% compute errors
norm(Pg-Pg0) % little different
norm(Pg0-Pg1) % same
norm(Pg1-Pg) % little different, same as the first
return


