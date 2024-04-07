%CSP + LDA / SVM algorithm with covariance averaging methods
%by Matteo Sartori

%Input: covariance matrix relative to specific subject 
%choose the learner (SVM / LDA)

subject = { 'k6b' 'l1b'};
    
%              'sa' 'sb' 'sc' 'sd' 'se' ...
%              'A01T' 'A03T' 'A07T' 'A08T' 'A09T'...
%              'S4b' 'X11b' 'aa' 'al' };
        
for s=subject
   
    clearvars -except subject s
    
%     clear;
    addpath(genpath('./'))
    addpath(genpath('../'))

    %% ------- set up the condition of experiment ----------

%     SCM = 'A01T';
    SCM = s{1};

    learner='LDA';
    fprintf('------- START: %s -------. \n', SCM);

    load (strcat('SCM_',SCM,'.mat'));

        %% ------- settare le classi / sotto classi da studiare col CSP
        if class_number==4
             Class=[3 4];
        else
             Class=[1 2];
        end
    
    switch class_number
        case 2
            P(:,:,:,1)=P1;
            P(:,:,:,2)=P2;
        case 3
            P(:,:,:,1)=P1;
            P(:,:,:,2)=P2;
            P(:,:,:,3)=P3;          
        case 4
            P(:,:,:,1)=P1;
            P(:,:,:,2)=P2;
            P(:,:,:,3)=P3;
            P(:,:,:,4)=P4;
        case 5
            P(:,:,:,1)=P1;
            P(:,:,:,2)=P2;
            P(:,:,:,3)=P3;
            P(:,:,:,4)=P4;
            P(:,:,:,5)=P5;          
     end

    %% ------- number of trials per class
    I=size(P,3);

if mod(I,10)==0
    CrossVal = 10;
elseif mod(I,12)==0
    CrossVal = 12;
elseif mod(I,9)==0
    CrossVal = 9; 
end

r = [1:10]; % number of CSP filters (2*r filter will be applied.)

% set up the condition of averaging methods
[ave, Para] = setup_averaging_conditions;

 P1 = P(:,:,:,Class(1)); 
 P2 = P(:,:,:,Class(2));
 sig = cat(3, sig(:,:,:,Class(1)), sig(:,:,:,Class(2)));

%% cross validation -------------------------------------
for CV = 1:CrossVal
    fprintf('------- Subject: %s -------. \n', SCM);
     fprintf('------- CV: %d -------. \n', CV);
    
    test_ind = (CV - 1)*I/CrossVal+1 : CV*I/CrossVal;
    tr_ind = setdiff(1:I, test_ind);
    
    tr_P1 = P1(:,:,tr_ind);
    tr_P2 = P2(:,:,tr_ind);
    test_P1 = P1(:,:,test_ind);
    test_P2 = P2(:,:,test_ind);

    testLabels = [ones(I/CrossVal, 1); 2*ones(I/CrossVal, 1)];
    trainingLabels = [ones(I/CrossVal*(CrossVal-1), 1); 2*ones(I/CrossVal*(CrossVal-1), 1)];
    
    % averaging data
    [Aves1 Pg1] = averaging_SCMs(tr_P1, ave, Para);
    [Aves2 Pg2] = averaging_SCMs(tr_P2, ave, Para);
    
    for method = 1:size(Pg1, 3)
        % CSP filter
        Y = CSPfilter( Pg1(:,:,method), Pg2(:,:,method), sig, max(r) );
        Y = log(Y);
        filters=size(Y,1);
        
        for R = r
            if max(r)<filters
                trainingFeatures = Y([1:R end-R+1:end], [tr_ind tr_ind+I])';
                testFeatures = Y([1:R end-R+1:end], [test_ind test_ind+I])';
            else
                trainingFeatures = Y(:, [tr_ind tr_ind+I])';
                testFeatures = Y(:, [test_ind test_ind+I])';
            end

            % classify with LDA, select metodies, scegliere fitdiscr o myLDA
            if strcmp(learner,'LDA')
                 resultLabels = predict(fitcdiscr(trainingFeatures, trainingLabels),testFeatures); %LDA
    %            [resultLabels, w] = myLDA(trainingFeatures, trainingLabels, testFeatures);
            elseif strcmp(learner,'SVM')
                resultLabels = predict(fitcsvm(trainingFeatures, trainingLabels),testFeatures); %SVM
            end
            accuracy(1, CV, method, R) = mean(resultLabels == testLabels);
            % (subject x CV x method x nb. filter)
        end
    end % ave methods
end %CV


 disp('-------- Complete!! --------')
    disp('Run "disp_csp_results.m" to see results.')

    
    if strcmp(learner,'LDA')
        save (strcat('./Workspaces CSP/CSP-LDA/',SCM,'_CSP-LDA_workspace'));
    elseif strcmp(learner,'SVM')
        save (strcat('./Workspaces CSP/CSP-SVM/',SCM,'_CSP-SVM_workspace'));
    end
    
end
