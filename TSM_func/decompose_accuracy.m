%Organize the results
%by Matteo Sartori

function [Acc] = decompose_accuracy(accuracy, ave, Para, dim)

% input
% accuracy: e.g. (sub x CV x methods x dim), (CV x sub x para)
% ave: (struct)
% Para: (struct)
% dim: separete accracy for this direction (scalar)

switch dim
case 1
	ind = [1 2 3 4];
case 2
	ind = [2 1 3 4];
case 3
	ind = [3 2 1 4];
case 4
	ind = [4 2 3 1];
end
accuracy = permute(accuracy, ind);

k = 1; % index of averages


% means
if ave.Arithmetic_mean == 1
	Acc.Arithmetic_mean = permute(accuracy(k,:,:,:), ind);
	k = k+1;
end
if ave.Riemannian_Geometric_mean == 1;
	Acc.Riemannian_Geometric_mean = permute(accuracy(k,:,:,:), ind);
	k = k+1;
end
if ave.LogEuclidean_Geometric_mean == 1;
	Acc.LogEuclidean_Geometric_mean = permute(accuracy(k,:,:,:), ind);
	k = k+1;
end
if ave.Harmonic_mean == 1
	Acc.Harmonic_mean = permute(accuracy(k,:,:,:), ind);
	k = k+1;
end
if ave.Resolvent_mean == 1
	k = [k : k-1+numel(Para.Resolvent_mean)];
	Acc.Resolvent_mean = permute(accuracy(k,:,:,:), ind);
	k = k(end)+1;

	[max_acc, max_ind] = max(Acc.Resolvent_mean, [], dim);
	BestAcc.Resolvent_mean = max_acc;
end


% medians
if ave.Euclidean_geometric_median == 1
	Acc.Euclidean_geometric_median = permute(accuracy(k,:,:,:), ind);
	k = k+1;
end
if ave.Riemannian_geometric_median == 1
	Acc.Riemannian_geometric_median = permute(accuracy(k,:,:,:), ind);
	k = k+1;
end
if ave.LogEuclidean_geometric_median == 1
	Acc.LogEuclidean_geometric_median = permute(accuracy(k,:,:,:), ind);
	k = k+1;
end


% trimmed means
if ave.trimmed_Riemannian_Geometric_mean == 1
	k = [k : k-1+numel(Para.trimmed_Riemannian_Geometric_mean)];
	Acc.trimmed_Riemannian_Geometric_mean = permute(accuracy(k,:,:,:), ind);
	k = k(end)+1;
end
if ave.trimmed_LogEuclidean_Geometric_mean == 1
	k = [k : k-1+numel(Para.trimmed_LogEuclidean_Geometric_mean)];
	Acc.trimmed_LogEuclidean_Geometric_mean = permute(accuracy(k,:,:,:), ind);
	k = k(end)+1;
end



% trimmed median
if ave.trimmed_Riemannian_Geometric_median == 1
	k = [k : k-1+numel(Para.trimmed_Riemannian_Geometric_median)];
	Acc.trimmed_Riemannian_Geometric_median = permute(accuracy(k,:,:,:), ind);
	k = k(end)+1;
end
if ave.trimmed_LogEuclidean_Geometric_median == 1
	k = [k : k-1+numel(Para.trimmed_LogEuclidean_Geometric_median)];
	Acc.trimmed_LogEuclidean_Geometric_median = permute(accuracy(k,:,:,:), ind);
	k = k(end)+1;
end


% identity matrix
if ave.Identity == 1
	Acc.Identity = permute(accuracy(k,:,:,:), ind);
	k = k+1;
end




