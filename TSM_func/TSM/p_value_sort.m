%by Uehara

function [S00, p_sorted] = p_value_sort(S0, Class, tr_ind)

% input
% S0: (variable x sample*class)


%% --------- divide S0 to each class --------
I = size(S0,2)/numel(Class);
if mod(size(S0,2), numel(Class)) ~= 0
	error('the number of trial is wrong.')
end

for ii = 1:numel(Class)
	S0_class(:,:,ii) = S0(:, 1+I*(ii-1):I*ii); %(variable x trial x class)
end


%% -------- applay 1way anova -----------
for ii = 1:size(S0,1)
	p(ii) = anova1way(permute(S0_class(ii, tr_ind, :), [2 3 1]));
end

%% -------- sort variables according to p-value ----------
[p_sorted, ind] = sort(p, 'ascend');
S00 = S0(ind, :);

