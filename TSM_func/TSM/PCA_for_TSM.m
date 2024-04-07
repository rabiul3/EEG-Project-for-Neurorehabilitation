%by Uehara

function S0 = PCA_for_TSM(S, Class, tr_ind)


% input
% S: (dim x trial*class)

% output
% S0: 

%% --------- set up ----------
I = size(S,2)/numel(Class);
if mod(size(S,2), numel(Class)) ~= 0
	error('the number of trial is wrong.')
end


%% --------- extract training data -----------
tr_ind_comp = [];
for ii = 1 : numel(Class)
	tr_ind_comp = cat(2, tr_ind_comp, tr_ind + I*(ii-1));
end
S_tr = S(:,tr_ind_comp); % (variable x 180)
%size(S_tr)

%% ---------- PCA ---------------
[U, R, V] = svd(S_tr);
S0 = U.' * S;
%size(S0)


%% -------- dimension reduction -----------
dim = min(size(S_tr, 2), size(S_tr, 1));
S0 = S0(1:dim, :);
%size(S0)