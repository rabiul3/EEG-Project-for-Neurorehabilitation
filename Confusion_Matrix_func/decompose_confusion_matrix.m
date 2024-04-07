%Organize the confusion matrix for whole means
%by Matteo Sartori

function [ ConfusionMatrix ] = decompose_confusion_matrix( confusion_matrix , ave , Para )

k = 1; % index of averages


% means
if ave.Arithmetic_mean == 1
	ConfusionMatrix.Arithmetic_mean = confusion_matrix(:,:,k);
	k = k+1;
end
if ave.Riemannian_Geometric_mean == 1;
	ConfusionMatrix.Riemannian_Geometric_mean = confusion_matrix(:,:,k);
	k = k+1;
end
if ave.LogEuclidean_Geometric_mean == 1;
	ConfusionMatrix.LogEuclidean_Geometric_mean = confusion_matrix(:,:,k);
	k = k+1;
end
if ave.Harmonic_mean == 1
	ConfusionMatrix.Harmonic_mean = confusion_matrix(:,:,k);
	k = k+1;
end
if ave.Resolvent_mean == 1
	k = [k : k-1+numel(Para.Resolvent_mean)];
    max=0;
    for ii=k
        mean_diag=trace(confusion_matrix(:,:,ii))/size(confusion_matrix(:,:,ii),1);
        if mean_diag>max
            max=ii;
        end
    end
	ConfusionMatrix.Resolvent_mean = confusion_matrix(:,:,max);
	k = k(end)+1;
end


% medians
if ave.Euclidean_geometric_median == 1
	ConfusionMatrix.Euclidean_geometric_median = confusion_matrix(:,:,k);
	k = k+1;
end
if ave.Riemannian_geometric_median == 1
	ConfusionMatrix.Riemannian_geometric_median = confusion_matrix(:,:,k);
	k = k+1;
end
if ave.LogEuclidean_geometric_median == 1
	ConfusionMatrix.LogEuclidean_geometric_median = confusion_matrix(:,:,k);
	k = k+1;
end


% trimmed means
if ave.trimmed_Riemannian_Geometric_mean == 1
	k = [k : k-1+numel(Para.trimmed_Riemannian_Geometric_mean)];
    max=0;
    for ii=k
        mean_diag=trace(confusion_matrix(:,:,ii))/size(confusion_matrix(:,:,ii),1);
        if mean_diag>max
            max=ii;
        end
    end
	ConfusionMatrix.trimmed_Riemannian_Geometric_mean = confusion_matrix(:,:,max);
	k = k(end)+1;
end
if ave.trimmed_LogEuclidean_Geometric_mean == 1
	k = [k : k-1+numel(Para.trimmed_LogEuclidean_Geometric_mean)];
    max=0;
    for ii=k
        mean_diag=trace(confusion_matrix(:,:,ii))/size(confusion_matrix(:,:,ii),1);
        if mean_diag>max
            max=ii;
        end
    end
	ConfusionMatrix.trimmed_LogEuclidean_Geometric_mean = confusion_matrix(:,:,max);
	k = k(end)+1;
end



% trimmed median
if ave.trimmed_Riemannian_Geometric_median == 1
	k = [k : k-1+numel(Para.trimmed_Riemannian_Geometric_median)];
    max=0;
    for ii=k
        mean_diag=trace(confusion_matrix(:,:,ii))/size(confusion_matrix(:,:,ii),1);
        if mean_diag>max
            max=ii;
        end
    end
	ConfusionMatrix.trimmed_Riemannian_Geometric_median = confusion_matrix(:,:,max);
	k = k(end)+1;
end
if ave.trimmed_LogEuclidean_Geometric_median == 1
	k = [k : k-1+numel(Para.trimmed_LogEuclidean_Geometric_median)];
    max=0;
    for ii=k
        mean_diag=trace(confusion_matrix(:,:,ii))/size(confusion_matrix(:,:,ii),1);
        if mean_diag>max
            max=ii;
        end
    end
	ConfusionMatrix.trimmed_LogEuclidean_Geometric_median = confusion_matrix(:,:,max);
	k = k(end)+1;
end


% identity matrix
if ave.Identity == 1
	ConfusionMatrix.Identity = confusion_matrix(:,:,k);
	k = k+1;
end



end

