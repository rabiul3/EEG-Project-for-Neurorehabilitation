% Display the result of classification by TSM algorithm
%by Matteo Sartori

% Input: subject, learner (to compose the path of matlab workspace)

% subject = { 'sa' 'sb' 'sc' 'sd' 'se' ...
%              'A01T' 'A03T' 'A07T' 'A08T' 'A09T'...
%               'k3b' 'k6b' 'l1b' ...
%           'S4b' 'X11b' 'aa' 'al' };
%          
% learner='SVM';
% type='';
%         
% for s=subject
%    
%     clearvars -except subject s learner type
%     
%     
%     addpath(genpath('./'))
%   %  SCM='A01T';
%      SCM = s{1};
%      
% load(strcat(SCM,'_TSM-',learner,'_workspace',type,'.mat'));


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

%         app=permute(Acc_mean.(ii{1})*100, [3 2 1]);
%         disp(app)


%% ------ display the mean of all averages for each trimmed range

%         app=mean(permute(Acc_mean.(ii{1})*100, [3 2 1]), 1);
%         fprintf('%s:\t\t\t %f. \n',ii{1},app(:,1,:) );


%% ------ display the max of all averages for each trimmed range

          app=max(permute(Acc_mean.(ii{1})*100, [3 2 1]));
          fprintf('%s:\t\t\t %f. \n',ii{1},app(:,1,:) );
		
	end
end

%  end