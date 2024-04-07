%Arrange results of CSP classification
%by Matteo Sartori

accuracy = mean(accuracy, 2);
%  accuracy = max(permute(accuracy, [4 1 3 2]));
  accuracy = min(permute(accuracy, [4 1 3 2]));
% accuracy = mean(permute(accuracy, [4 1 3 2]),1);
accuracy = permute(accuracy, [3 2 4 1]);


k = 1; % index of averages


% means
if ave.Arithmetic_mean == 1
	Acc.Arithmetic_mean = accuracy(k,:,:,:);
	k = k+1;
end
if ave.Riemannian_Geometric_mean == 1;
	Acc.Riemannian_Geometric_mean = accuracy(k,:,:,:);
	k = k+1;
end
if ave.LogEuclidean_Geometric_mean == 1;
	Acc.LogEuclidean_Geometric_mean = accuracy(k,:,:,:);
	k = k+1;
end
if ave.Harmonic_mean == 1
	Acc.Harmonic_mean = accuracy(k,:,:,:);
	k = k+1;
end
if ave.Resolvent_mean == 1
	k = [k : k-1+numel(Para.Resolvent_mean)];
	Acc.Resolvent_mean = accuracy(k,:,:,:);
	k = k(end)+1;
end


% medians
if ave.Euclidean_geometric_median == 1
	Acc.Euclidean_geometric_median = accuracy(k,:,:,:);
	k = k+1;
end
if ave.Riemannian_geometric_median == 1
	Acc.Riemannian_geometric_median = accuracy(k,:,:,:);
	k = k+1;
end
if ave.LogEuclidean_geometric_median == 1
	Acc.LogEuclidean_geometric_median = accuracy(k,:,:,:);
	k = k+1;
end


% trimmed means
if ave.trimmed_Riemannian_Geometric_mean == 1
	k = [k : k-1+numel(Para.trimmed_Riemannian_Geometric_mean)];
	Acc.trimmed_Riemannian_Geometric_mean = accuracy(k,:,:,:);
	k = k(end)+1;
end
if ave.trimmed_LogEuclidean_Geometric_mean == 1
	k = [k : k-1+numel(Para.trimmed_LogEuclidean_Geometric_mean)];
	Acc.trimmed_LogEuclidean_Geometric_mean = accuracy(k,:,:,:);
	k = k(end)+1;
end



% trimmed median
if ave.trimmed_Riemannian_Geometric_median == 1
	k = [k : k-1+numel(Para.trimmed_Riemannian_Geometric_median)];
	Acc.trimmed_Riemannian_Geometric_median = accuracy(k,:,:,:);
	k = k(end)+1;
end
if ave.trimmed_LogEuclidean_Geometric_median == 1
	k = [k : k-1+numel(Para.trimmed_LogEuclidean_Geometric_median)];
	Acc.trimmed_LogEuclidean_Geometric_median = accuracy(k,:,:,:);
	k = k(end)+1;
end


% identity matrix
if ave.Identity == 1
	Acc.Identity = accuracy(k,:,:,:);
	k = k+1;
end
