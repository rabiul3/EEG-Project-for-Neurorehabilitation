function [S1, S2, p, q, label, q0] = FDRmethod(S01, S02, tr_ind, flag)
% by Matteo Sartori

% S01, S02 have m hypothesis in row.
% third input 'flag'
% 1: only sorting variables.
% 2: sort and reduce variables according to p-value.
% 3: sort and reduce variables according to q-value.

% make hypothesis cell
m = size(S01, 1); % number of hypothesis
H = cell(m, 1);
for ii = 1:m
	H(ii, 1) = {cat(2, S01(ii, tr_ind)', S02(ii, tr_ind)')};
end

% compute p-value
p0 = cellfun(@anova1way, H);
[p, ind] = sort(p0);

% compute q-value
i = [1:m]';
q0 = m*p ./ i ;
q = zeros(m,1);
q(m) = q0(m);
for ii = 1:m-1
	q(m-ii) = min(q0(m-ii), q(m-ii+1));
end

% select flag
if flag == 1
	value = zeros(m,1);
elseif flag == 2
	value = p;
elseif flag == 3
	value = q;
end

% reject hypothesis
alpha = 0.05;
label = ones(m,1);
for ii = 1:m
	if value(ii) >= alpha % p or q?
		label(ii) = 0;
	end
end

% reconstruct S
S1 = S01(ind(label ~= 0), :);
S2 = S02(ind(label ~= 0), :);
%S = cat(2, S1, S2);
