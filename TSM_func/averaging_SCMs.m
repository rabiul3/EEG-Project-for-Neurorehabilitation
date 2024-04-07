function [Aves Pg] = averaging_SCMs(P_tr, ave, Para, P, tr_ind, Class)
% Compute averages of 'P_tr' using several averageing methods.
% by Matteo Sartori

% input
% P_tr: SPD matrices (3-dim array: ch x ch x trial)
% ave: averaging methods (struct)
% Para: parameters of averaging methods (struct)

% output
% Aves: averages of each methods (struct)
% Pg: marged averages of all methods (3-dim array)


Pg = [];

%% means
if ave.Arithmetic_mean == 1
	Aves.Arithmetic_mean = mean(P_tr, 3);
	Pg = cat(3, Pg, Aves.Arithmetic_mean);
end
% % if ave.Riemannian_Geometric_mean == 1;
% % 	Aves.Riemannian_Geometric_mean = RiemannianGeometricMean(P_tr);
% % 	Pg = cat(3, Pg, Aves.Riemannian_Geometric_mean);
% % end
% % if ave.LogEuclidean_Geometric_mean == 1;
% % 	Aves.LogEuclidean_Geometric_mean = LogEuclideanMean(P_tr);
% % 	Pg = cat(3, Pg, Aves.LogEuclidean_Geometric_mean);
% % end
% % if ave.Harmonic_mean == 1
% % 	Aves.Harmonic_mean = Mat_Harm_mean(P_tr);
% % 	Pg = cat(3, Pg, Aves.Harmonic_mean);
% % end
% % if ave.Resolvent_mean == 1
% % 	%Aves.Resolvent_mean = SPD_Resolvent_mean(P_tr);
% % 	for mu = Para.Resolvent_mean
% % 		Aves.Resolvent_mean(:,:,find(Para.Resolvent_mean == mu)) = resolvent_ave(P_tr, mu);
% % 	end
% % 	Pg = cat(3, Pg, Aves.Resolvent_mean);
% % end
% % 
% % 
% % %% medians
% % if ave.Euclidean_geometric_median == 1
% % 	Aves.Euclidean_geometric_median = EuclideanGeometricMedian(P_tr);
% % 	Pg = cat(3, Pg, Aves.Euclidean_geometric_median);
% % end
% % if ave.Riemannian_geometric_median == 1
% % 	Aves.Riemannian_geometric_median = RiemannianGeometricMedian(P_tr);
% % 	Pg = cat(3, Pg, Aves.Riemannian_geometric_median);
% % end
% % if ave.LogEuclidean_geometric_median == 1
% % 	Aves.LogEuclidean_geometric_median = LogEuclideanMedian(P_tr);
% % 	Pg = cat(3, Pg, Aves.LogEuclidean_geometric_median);
% % end
% % 
% % if Para.trim_each_class==1
% %     %% trimmed means
% %     if ave.trimmed_Riemannian_Geometric_mean == 1
% %         P_trimmed_class=[];
% %         for ii = Class
% %             P_trimmed(:,:,:,ii) = trimmed_average(@RiemannianGeometricMean, P(:,:,tr_ind,ii) , Para.trimmed_Riemannian_Geometric_mean);
% %         end
% %         for ii=1:size(P_trimmed,3)
% %             appoggio=[];
% %             for jj = Class
% %                 appoggio=cat(3,appoggio,P_trimmed(:,:,ii,jj));
% %             end
% %             P_trimmed_class=cat(3,P_trimmed_class, RiemannianGeometricMean(appoggio));
% %         end
% %         Aves.trimmed_Riemannian_Geometric_mean = P_trimmed_class;
% %         Pg = cat(3, Pg, Aves.trimmed_Riemannian_Geometric_mean);
% %     end
% %     if ave.trimmed_LogEuclidean_Geometric_mean == 1
% %          P_trimmed_class=[];
% %         for ii = Class
% %             P_trimmed(:,:,:,ii) = trimmed_average(@LogEuclideanMean, P(:,:,tr_ind,ii) ,  Para.trimmed_LogEuclidean_Geometric_mean);
% %         end
% %         for ii=1:size(P_trimmed,3)
% %             appoggio=[];
% %             for jj = Class
% %                 appoggio=cat(3,appoggio,P_trimmed(:,:,ii,jj));
% %             end
% %             P_trimmed_class=cat(3,P_trimmed_class, RiemannianGeometricMean(appoggio));
% %         end
% %         Aves.trimmed_LogEuclidean_Geometric_mean = P_trimmed_class;
% %         Pg = cat(3, Pg, Aves.trimmed_LogEuclidean_Geometric_mean);
% %     end
% % 
% %     %% trimmed medians
% %     if ave.trimmed_Riemannian_Geometric_median == 1
% %         P_trimmed_class=[];
% %         for ii = Class
% %             P_trimmed(:,:,:,ii) = trimmed_average(@RiemannianGeometricMedian, P(:,:,tr_ind,ii) , Para.trimmed_Riemannian_Geometric_median);
% %         end
% %         for ii=1:size(P_trimmed,3)
% %             appoggio=[];
% %             for jj = Class
% %                 appoggio=cat(3,appoggio,P_trimmed(:,:,ii,jj));
% %             end
% %             P_trimmed_class=cat(3,P_trimmed_class, RiemannianGeometricMean(appoggio));
% %         end
% %         Aves.trimmed_Riemannian_Geometric_median = P_trimmed_class;
% %         Pg = cat(3, Pg, Aves.trimmed_Riemannian_Geometric_median);
% %     end
% %     if ave.trimmed_LogEuclidean_Geometric_median == 1
% %         P_trimmed_class=[];
% %         for ii = Class
% %             P_trimmed(:,:,:,ii) = trimmed_average(@LogEuclideanMedian, P(:,:,tr_ind,ii) , Para.trimmed_LogEuclidean_Geometric_median);
% %         end
% %         for ii=1:size(P_trimmed,3)
% %             appoggio=[];
% %             for jj = Class
% %                 appoggio=cat(3,appoggio,P_trimmed(:,:,ii,jj));
% %             end
% %             P_trimmed_class=cat(3,P_trimmed_class, RiemannianGeometricMean(appoggio));
% %         end
% %         Aves.trimmed_LogEuclidean_Geometric_median = P_trimmed_class;
% %         Pg = cat(3, Pg, Aves.trimmed_LogEuclidean_Geometric_median);
% %     end
% % end
% % 
% % 
% % if Para.trim_each_class==0;
% %     %% trimmed means
% %     if ave.trimmed_Riemannian_Geometric_mean == 1
% %         Aves.trimmed_Riemannian_Geometric_mean = trimmed_average(@RiemannianGeometricMean, P_tr, Para.trimmed_Riemannian_Geometric_mean);
% %         Pg = cat(3, Pg, Aves.trimmed_Riemannian_Geometric_mean);
% %     end
% %     if ave.trimmed_LogEuclidean_Geometric_mean == 1
% %         Aves.trimmed_LogEuclidean_Geometric_mean = trimmed_average(@LogEuclideanMean, P_tr, Para.trimmed_LogEuclidean_Geometric_mean);
% %         Pg = cat(3, Pg, Aves.trimmed_LogEuclidean_Geometric_mean);
% %     end
% % 
% %     %% trimmed medians
% %     if ave.trimmed_Riemannian_Geometric_median == 1
% %         Aves.trimmed_Riemannian_Geometric_median = trimmed_average(@RiemannianGeometricMedian, P_tr, Para.trimmed_Riemannian_Geometric_median);
% %         Pg = cat(3, Pg, Aves.trimmed_Riemannian_Geometric_median);
% %     end
% %     if ave.trimmed_LogEuclidean_Geometric_median == 1
% %         Aves.trimmed_LogEuclidean_Geometric_median = trimmed_average(@LogEuclideanMedian, P_tr, Para.trimmed_LogEuclidean_Geometric_median);
% %         Pg = cat(3, Pg, Aves.trimmed_LogEuclidean_Geometric_median);
% %     end
% % end
% % 
% % 
% % %% identity matrix
% % if ave.Identity == 1
% % 	Aves.Identity = eye(size(P_tr, 1));
% % 	Pg = cat(3, Pg, Aves.Identity);
% % end