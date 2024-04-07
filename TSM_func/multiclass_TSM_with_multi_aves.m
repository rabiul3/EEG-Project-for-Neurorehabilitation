function [t1 t2,t3] = multiclass_TSM_with_multi_aves(P, Class, tr_ind, test_ind, ave, Para, learner)
% Tangent space mapping and classification.
% by Matteo Sartori

% input
% P: sample covariance matirces (ch x ch x trial x class)
% Class: class of data (vector: 1 x nb. of class)
% tr_ind, test_ind: (vector)
% ave: (sturct: the name of fields is averaging method)
% Para: the parameter of averaging (struct)
% learner: the name of classifier (string)

% output
% accuracy: (ave_method x dim)
% Aves: averages of SCMs (struct)
% Pg: marged averages of SCMs (ch x ch x ave_method)
% S: (dimensin on TS x trials)
% pval: (method x dim)
% C: confusion matrix

TF=[];
%% ------------ extract training trials ----------------------
t1=[];
t2=[];
P_tr = []; P_comp = [];
for ii = Class
    P_tr = cat(3, P_tr, P(:,:,tr_ind,ii));
    P_comp = cat(3, P_comp, P(:,:,:,ii));
end
I = size(P,3);

%% ----- average SCMs (compute reference points on manifold) ------
if nargin == 5
    Para = [];
end


[Aves Pg] = averaging_SCMs(P_tr, ave, Para, P, tr_ind, Class);



%% -------- Tangent Space mapping --------
for method = 1 : size(Pg, 3) % nb. of averages

    % TSMapping
    load sigS4b;
    tic
    %%%%subband 1
    half_order=2;fs=250;freqband = [4 8];
    [b,a] = butter(half_order, freqband/(fs/2), 'bandpass');
    filtered_signal1 = filter(b,a,sig1(:,:,1));
    CP1 = cov(filtered_signal1);
    TF1=TSMapping(Pg(:,:,method), CP1);
    %subband 2
    half_order=2;fs=250;freqband = [8 12];
    [b,a] = butter(half_order, freqband/(fs/2), 'bandpass');
    filtered_signal2 = filter(b,a,sig1(:,:,1));
    CP2=[];
    CP2 = cov(filtered_signal2);
    TF2=TSMapping(Pg(:,:,method), CP2);
    %subband 3
    half_order=2;fs=250;freqband = [12 16];
    [b,a] = butter(half_order, freqband/(fs/2), 'bandpass');
    filtered_signal3 = filter(b,a,sig1(:,:,1));
    CP3=[];
    CP3 = cov(filtered_signal3);
    TF3=TSMapping(Pg(:,:,method), CP3);
    %subband 4
    half_order=2;fs=250;freqband = [16 20];
    [b,a] = butter(half_order, freqband/(fs/2), 'bandpass');
    filtered_signal4 = filter(b,a,sig1(:,:,1));
    CP4=[];
    CP4 = cov(filtered_signal4);
    TF4=TSMapping(Pg(:,:,method), CP4);    
    %subband 5
    half_order=2;fs=250;freqband = [20 24];
    [b,a] = butter(half_order, freqband/(fs/2), 'bandpass');
    filtered_signal5 = filter(b,a,sig1(:,:,1));
    CP5=[];
    CP5 = cov(filtered_signal5);
    TF5=TSMapping(Pg(:,:,method), CP5);
    %subband 6
    half_order=2;fs=250;freqband = [24 28];
    [b,a] = butter(half_order, freqband/(fs/2), 'bandpass');
    filtered_signal6 = filter(b,a,sig1(:,:,1));
    CP6=[];
    CP6 = cov(filtered_signal6);
    TF6=TSMapping(Pg(:,:,method), CP6);
    
    %subband 7
    half_order=2;fs=250;freqband = [20 24];
    [b,a] = butter(half_order, freqband/(fs/2), 'bandpass');
    filtered_signal5 = filter(b,a,sig1(:,:,1));
    CP5=[];
    CP5 = cov(filtered_signal5);
    TF5=TSMapping(Pg(:,:,method), CP5);
    %subband 8
    half_order=2;fs=250;freqband = [24 28];
    [b,a] = butter(half_order, freqband/(fs/2), 'bandpass');
    filtered_signal6 = filter(b,a,sig1(:,:,1));
    CP6=[];
    CP6 = cov(filtered_signal6);
    TF6=TSMapping(Pg(:,:,method), CP6);    
    
    t1 = [t1 toc]; %.............
    
    S(:,:,method) = TSMapping(Pg(:,:,method), P_comp);
    % pepare indeces and labels
    tr_ind_comp=[]; test_ind_comp=[]; 
    trainingLabels=[]; testLabels=[];
    for ii = 1 : numel(Class)
        tr_ind_comp = cat(2, tr_ind_comp, tr_ind + I*(ii-1));
        test_ind_comp = cat(2, test_ind_comp, test_ind + I*(ii-1));
        trainingLabels = cat(1, trainingLabels, ii*ones(numel(tr_ind), 1));
        testLabels = cat(1, testLabels, ii*ones(numel(test_ind), 1));
    end  

    tic %..............................................
    % PCA
    S0 = PCA_for_TSM(S(:,:,method), Class, tr_ind);

    % sort & reduce variables according to p-value
    [S00, pval(method,:)] = p_value_sort(S0, Class, tr_ind);


%% ----------- Classify ----------------------
    


    [features,weights]=MI(S(:,1:30,method)',trainingLabels(1:30),12);
    [features,weights]=MI(S(:,1:30,method)',trainingLabels(1:30),12);
    [features,weights]=MI(S(:,1:30,method)',trainingLabels(1:30),12);
    [features,weights]=MI(S(:,1:30,method)',trainingLabels(1:30),12);
    [features,weights]=MI(S(:,1:30,method)',trainingLabels(1:30),12);
    [features,weights]=MI(S(:,1:30,method)',trainingLabels(1:30),12);
    [features,weights]=MI(S(:,1:30,method)',trainingLabels(1:30),12);
    [features,weights]=MI(S(:,1:30,method)',trainingLabels(1:30),12);
% %     %Rank=[Rank1 Rank2 Rank3 Rank4 Rank5 Rank6 Rank7 Rank8];
    
    
     
    dim = sum(pval(method,:) < 0.1);
    trainingFeatures = S00(1:dim,1:30)';
    testFeatures = S00(1:dim,1)';
    %4 class test
% %     Mdl = fitcecoc(trainingFeatures, trainingLabels(1:30)); %SVM
% %     resultLabels = predict(Mdl, testFeatures(1,:));
        % classify (MATLAB toolbox)
    %2 class test
      Mdl = fitcsvm(trainingFeatures, trainingLabels(1:30));
      resultLabels = predict(Mdl, testFeatures(1,:));
    
    t2=[t2 toc];    
end %ave method
