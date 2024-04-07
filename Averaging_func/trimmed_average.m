function [M tr_ind_method_trimmed trim_num] = trimmed_average(func, P, range, tr_ind_method)
% Trimmed averages of SPD matrices
% coded by Uehara

%input
% P: SPD matrices
% range: the rage [0, 1] of eliminating point
%	The sample that has distance rate 0 is the closest to the average of whole samples.
%	The sample thet has distance rate 1 is the farthest to the average of whole samples. 	
%	If range = 0.7, the samples which have the distance rate 0 to 0.7 are used for trimmed averaging.
% 	If range = [0.7 : 0.025: 1], the samples which have the distance rate 0 to [0.7 : 1]
%	are used for trimmed averageing.

% output
% M: trimmed averages


% average of whole samples
[G, dis] = func(P);

% sort samples according to the distance from 'G' and get indices
[sortd ind] = sort(dis); % ascend

% obtain the number of averaged matrices at trimming method
range = sort(range, 'descend');
trim_num = round(range * numel(ind));

for ii = trim_num
	Pind = ind(1 : ii);
    if size(Pind)==1
        Pind=ind(1:2);
        M(:,:,trim_num==ii) = func(P(:,:,Pind));
    else
        M(:,:,trim_num==ii) = func(P(:,:,Pind));
    end
end
