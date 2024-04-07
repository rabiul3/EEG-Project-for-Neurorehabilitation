% 2 class  Fisher's LDA
% by Uehara
% data: sample x dimentions

function [resultlabels, w] = myLDA(trainingdata, traininglabels, testdata)
%% learning
labels = unique(traininglabels);
training1 = trainingdata(traininglabels == labels(1), :);
training2 = trainingdata(traininglabels == labels(2), :);

% sample size
n1 = size(training1, 1);
n2 = size(training2, 1);

% mean of data
mean1 = mean(training1, 1)';
mean2 = mean(training2, 1)';

% covariance matrices of each class
cov1 = cov(training1);
cov2 = cov(training2);

% Commom covariance matrix
Cov = ((n1 - 1)*cov1 + (n2 - 1)*cov2) / (n1 + n2 - 2);

% weight vector
w = Cov \ ( mean1 - mean2 );

% threshold
%M = (mean1 - mean2)' * (Cov \ ( mean1 + mean2 )) / 2;
M = w' * ( mean1 + mean2 ) / 2;

%% classify
resultlabels = zeros(size(testdata, 1), 1);
for ii = 1 : size(testdata, 1)
    % projection onto optimal axis
    y = w' * testdata(ii, :)';
    
    if y >= M
        resultlabels(ii, 1) = labels(1);
    else
        resultlabels(ii, 1) = labels(2);
    end
end
