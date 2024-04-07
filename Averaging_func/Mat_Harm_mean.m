function Ph = Mat_Harm_mean(P)
% Harmonic mean of SPD matrices 'P'.
% by Uehara

if PositiveDefiniteCheck(P) == 0
	error('Input sample matrices are NOT positive-definite. They must be SPD.')
end


N = size(P, 3);
%w = ones(1, N)/N;
H = zeros(size(P,1));

for n = 1:N
	PI = inv(P(:,:,n));
	H = H + (PI+PI')/2;
	%H = H + w(n) * inv(P(:,:,n));
end
H = H/N;
H = (H+H')/2;

Ph = inv(H);

