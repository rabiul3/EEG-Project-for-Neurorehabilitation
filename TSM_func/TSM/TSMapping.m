function S = TSMapping(Pg, P)
% Map the SPD matrices 'P' to the Tangent Space at 'Pg'.
% by Matteo Sartori

%input
% Pg: reference point of the tangent space.
% P: mapped SPD matrices (dim x dim x trial)
%output
% S: mapped vectors (dim(dim+1)/2 x trial)
% S = upperv(logm(sqrtm(Pg) \ P / sqrtm(Pg)))


I = size(P, 3);
R = sqrtm(Pg);

for ii = 1:I
	P0 = R \ P(:,:,ii) / R;
	P0 = (P0 + P0') / 2;
	L = Logm(P0);
	S(:,ii) = upperv(L);
end

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use cell 
Pcell = cell(1,I);
Pgcell = cell(1,I);
Rcell = cell(1,I);
for i = 1:I
    Pcell(1,i) = {P(:,:,i)};
    %Pgcell(1,i) = {Pg};
    Rcell(1,i) = {R};
end

L = cellfun(@mldivide, Rcell, Pcell, 'UniformOutput', false); % R\P
L1 = cellfun(@mrdivide, L, Rcell, 'UniformOutput', false); % R\P/R
L2 = cellfun(@logm, L1, 'UniformOutput', false); % log(R\P/R)
L2 = cellfun(@real, L2, 'UniformOutput', false);
Scell = cellfun(@upperv, L2, 'UniformOutput', false);

%S = zeros(size(P,1)*(size(P,1)+1)/2, I);
%for i = 1:I
%	S(:,i) = cell2mat(Scell(1,i));
%end

S = cell2mat(Scell);
