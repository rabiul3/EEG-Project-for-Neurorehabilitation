subject = {'S4b'};  %%For data set III_IIIb
for s=subject
   
    clearvars -except subject s
    
%     clear;
    addpath(genpath('../'))
    addpath(genpath('./'))


    %% ------- set up the condition of experiment ----------

%     SCM = 'al';
    SCM = s{1};
    
    fprintf('------- START: %s -------. \n', SCM);

    load (strcat('RSCM_',SCM,'.mat'));

    switch class_number
        case 2
            P(:,:,:,1)=P1;RP(:,:,:,1)=RP1;SP(:,:,:,1)=SP1;BP(:,:,:,1)=BP1;LP(:,:,:,1)=LP1;  LN(:,:,:,1)=LN1; LM(:,:,:,1)=LM1;LG(:,:,:,1)=LG1;
            P(:,:,:,2)=P2;RP(:,:,:,2)=RP2;SP(:,:,:,2)=SP2;BP(:,:,:,2)=BP2;LP(:,:,:,2)=LP2;  LN(:,:,:,2)=LN2; LM(:,:,:,2)=LM2;LG(:,:,:,2)=LG2;
            Class=[1 2];
        case 3
            P(:,:,:,1)=P1;
            P(:,:,:,2)=P2;
            P(:,:,:,3)=P3;
            Class=[1 2 3];
        case 4
            P(:,:,:,1)=P1;RP(:,:,:,1)=RP1;SP(:,:,:,1)=SP1;BP(:,:,:,1)=BP1;LP(:,:,:,1)=LP1;  LN(:,:,:,1)=LN1;LM(:,:,:,1)=LM1;LG(:,:,:,1)=LG1;
            P(:,:,:,2)=P2;RP(:,:,:,2)=RP2;SP(:,:,:,2)=SP2;BP(:,:,:,2)=BP2;LP(:,:,:,2)=LP2;  LN(:,:,:,2)=LN2;LM(:,:,:,2)=LM2;LG(:,:,:,2)=LG2;
            P(:,:,:,3)=P3;RP(:,:,:,3)=RP3;SP(:,:,:,3)=SP3;BP(:,:,:,3)=BP3;LP(:,:,:,3)=LP3;  LN(:,:,:,3)=LN3;LM(:,:,:,3)=LM3;LG(:,:,:,3)=LG3;
            P(:,:,:,4)=P4;RP(:,:,:,4)=RP4;SP(:,:,:,4)=SP4;BP(:,:,:,4)=BP4;LP(:,:,:,4)=LP4;  LN(:,:,:,4)=LN4;LM(:,:,:,4)=LM4;LG(:,:,:,4)=LG4;
            Class=[1 2 3 4];
        case 5
            P(:,:,:,1)=P1;
            P(:,:,:,2)=P2;
            P(:,:,:,3)=P3;
            P(:,:,:,4)=P4;
            P(:,:,:,5)=P5;
            Class=[1 2 3 4 5];
    end

    %% ------- reset Class for eventual others tests with subclasses
%     Class=[3 4];

    %% ------- number of trials per class
    I=size(P,3);

    %% ------- cross validation
    if mod(I,12)==0
        CrossVal = 10;
%     elseif mod(I,12)==0
%         CrossVal = 12;
    elseif mod(I,9)==0
        CrossVal = 9; 
    elseif mod(I,4)==0
        CrossVal = 4;         
    end
    few_training = 0;
    training = 0; % the amount of training trials
    if training ~= 0
        CrossVal = 1;
    end
    % select averaging methods (how to determine the reference point)
    [ave, Para] = setup_averaging_conditions;

    % select classifier ('SVM' or 'LDA')
     learner = 'SVM';
    %learner = 'LDA';
    %learner = 'myLDA';


    %% -------- simulation starts --------
    tstart = tic;

    %% ------ start cross validation ------------
    disp('---------- start CV ----------')
time1=[];
time2=[];
    for CV = 1:200
        fprintf('------- Subject: %s -------. \n', SCM);
        fprintf('------- CV: %d -------. \n', CV);

        % prepare indeces
        test_ind = [(CV - 1)*I/CrossVal+1 : CV*I/CrossVal];
        tr_ind = setdiff(1:I, test_ind);

    %% -------------- TSM ---------------------
        % apply TSM to SCMs
        [t1 t2] = multiclass_TSM_with_multi_aves(P, Class, tr_ind, test_ind, ave, Para, learner);
        time1=[time1 t1];
        time2=[time2 t2];
    end %CV

    time=time1+time2;
    mean(time)
    %% ----- organize results ---------        
end

