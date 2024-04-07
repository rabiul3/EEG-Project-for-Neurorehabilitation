function [ave, Para] = setup_averaging_conditions

% {choose the averages --- 0: not use, 1: use}
%by Matteo Sartori

% mean
ave.Arithmetic_mean = 1;
ave.Riemannian_Geometric_mean = 1;
ave.LogEuclidean_Geometric_mean = 1;
ave.Harmonic_mean = 1;
ave.Resolvent_mean = 1;
Para.Resolvent_mean = 10.^[0:5]; % parameter mu [0:inf]

% median
ave.Euclidean_geometric_median = 1;
ave.Riemannian_geometric_median = 1;
ave.LogEuclidean_geometric_median = 1;

% trimmed averaging parameter
%Para.trim_range = [.5:.025:1]; % similar to the percentile
Para.trim_range = [.05:.05:1];
Para.trimmed_Riemannian_Geometric_mean = sort(Para.trim_range, 'descend');
Para.trimmed_LogEuclidean_Geometric_mean = sort(Para.trim_range, 'descend');
Para.trimmed_Riemannian_Geometric_median = sort(Para.trim_range, 'descend');
Para.trimmed_LogEuclidean_Geometric_median = sort(Para.trim_range, 'descend');

% trimmed mean (include standard means)
ave.trimmed_Riemannian_Geometric_mean = 1;
ave.trimmed_LogEuclidean_Geometric_mean = 1;


% trimmed median (include standard medians)
ave.trimmed_Riemannian_Geometric_median = 1;
ave.trimmed_LogEuclidean_Geometric_median = 1;

% other method to determine reference point
ave.Identity = 1;