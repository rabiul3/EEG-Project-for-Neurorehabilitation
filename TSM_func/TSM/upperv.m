function x = upperv(S)
% weighted vecterize S to x
% by Matteo Sartori

% input
% S: symmetric matrix
% output
% x: vecterized matrix

D = diag(S);
d = reshape(D, size(S, 1), 1);

%T = triu(S,1) * sqrt(2);
T = triu(S,1);
t = reshape(T, size(S, 1)^2, 1);

x = vertcat(d, t(t ~= 0));