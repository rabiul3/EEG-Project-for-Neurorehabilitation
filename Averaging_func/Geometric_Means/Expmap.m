function [P] = Expmap(S, S_i)
% Exponential map of symmetric matrix 'S_i' to Riemannian manifold.
% by Uehara

% P and S is PSD matix on Riemannian manifold.
% S is a reference point of the tangent space.


if isequal(S_i, S_i') == 0
	disp('Input of ''Expmap.m'' is not symmetric.')
end

R = sqrtm(S);

S0 = R \ S_i / R;
S0 = (S0 + S0')/2;
P = R * expm(S0) * R;
P = (P+P')/2;


%S = sqrtm(P) * expm(inv(sqrtm(P)) * S_i * inv(sqrtm(P))) * sqrtm(P);