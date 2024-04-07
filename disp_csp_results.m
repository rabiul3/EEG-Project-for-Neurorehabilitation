% Display the result of classification by CSP algorithm
%by Matteo Sartori

% Input: subject, learner (to compose the path of matlab workspace)

%accuracy: (subject x CV x method x nb. filter)

subject = { 'sa' 'sb' 'sc' 'sd' 'se' ...
             'A01T' 'A03T' 'A07T' 'A08T' 'A09T'...
              'k3b' 'k6b' 'l1b' 'S4b' 'X11b' 'aa' 'al' };
         
learner='LDA';
type='';
        
for s=subject
   
    clearvars -except subject s learner type
    
%     clear;
    addpath(genpath('./'))
    
     SCM = s{1};
     
load(strcat(SCM,'_CSP-',learner,'_workspace',type,'.mat'));



arrange_accuracy;


disp('-------- Results --------')
disp('-------------------------')

disp(date)

fprintf('\nSCM')
disp(['	' SCM ])
fprintf('\nClass')
disp(Class)


disp('cross validation')
disp(sprintf('\t%0.5g fold CV\n', CrossVal))


ave_name = {'Arithmetic_mean' 'Riemannian_Geometric_mean' 'LogEuclidean_Geometric_mean' ...
	'Harmonic_mean' 'Resolvent_mean' ...
	'Euclidean_geometric_median' 'Riemannian_geometric_median' 'LogEuclidean_geometric_median'...
	'trimmed_Riemannian_Geometric_mean' 'trimmed_LogEuclidean_Geometric_mean'...
	'trimmed_Riemannian_Geometric_median' 'trimmed_LogEuclidean_Geometric_median' 'Identity'};

for ii = ave_name
	if ave.(ii{1}) == 1
		
        
        %% ------ display all averages for each trimmed range

%         app=Acc.(ii{1})*100;
%         disp(app)


%% ------ display the mean of all averages for each trimmed range

%         app=mean(Acc.(ii{1})*100, 1);
%         fprintf('%s:\t\t\t %f. \n',ii{1},app);


%% ------ display the max of all averages for each trimmed range

          app=max(Acc.(ii{1})*100);
          fprintf('%s:\t\t\t %f. \n',ii{1},app);
			
    end
end

end

