%function [] = arrange_accuracy(accuracy, pval)

% arrange accuracy tensor into results.
% by Matteo Sartori

% Welcome to processing results.
% We have 'accuracy (sub x CV x methods x dim)' now.
% and will arrange it.


% STEP 1: determine dim
% from (sub x CV x methods x dim)
% to (sub x CV x methods) by using [fix or pval]
% and to (sub x methods) by averaging over CV
% or
% from (sub x CV x methods x dim)
% to (sub x methods x dim) by averaging over CV
% and to (sub x methods) by using [max]


% STEP 2: separate the accuracy into every averaging method
% from (sub x methods)
% to (para x sub)
% and
% from (sub x CV x methods)
% to (sub x CV x para)
% from (sub x CV x mathods x dim)
% to (sub x CV x para x dim)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inputs
% accuracy: (sub x CV x method x dim)
% pval: (sub x CV x para x dim)

% outputs
% acc_CVmean: (dim x sub x method)
% acc_max_CVmean: (method x sub)
% max_ind: (method x sub)
% acc_max: (sub x CV x method)
% acc_max_mean: (method x sub)

% pval_ind: (sub x CV x method)
% acc_pval: (sub x CV x method)
% acc_pval_mean: (method x sub)
% acc_fix: (sub x CV x method)
% acc_fix_mean: (method x sub)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define new function
addmean = @(a, b) cat(b, a, mean(a, b));


%% averaging accuracy over CV test sets --------------

% (dim x subject x method)
acc_CVmean = permute(mean(accuracy, 2), [4 1 3 2]);
acc_CVmean = addmean(acc_CVmean, 2);



if size(acc_CVmean, 1) ~= 1
	%% squeeze dim according to 'max' -----------------------
	% select dim by max
	% (method x subject)
	[acc_max_CVmean max_ind] = max(acc_CVmean, [], 1);
	acc_max_CVmean = permute(acc_max_CVmean, [3 2 1]);
	max_ind = permute(max_ind, [3 2 1]);

	% (subject x CV x method)
	for ii = 1:size(accuracy,1)
		for jj = 1:size(accuracy,2)
			for kk = 1:size(accuracy, 3)
				acc_max(ii,jj,kk) = accuracy(ii,jj,kk, max_ind(kk, end));
			end
		end
	end

	% (method x sub)
	acc_max_mean = permute(mean(acc_max, 2), [3 1 2]);
	acc_max_mean = addmean(acc_max_mean, 2);

	%% squeeze dim according to p-value -----------------
	% get p-value based ind
	p1 = pval;
	p1(pval > 0.01) = 0;
	[p1 p1_ind] = max(p1, [], 4);% (p_ind: sub x CV x method)

	p5 = pval;
	p5(pval > 0.05) = 0;
	[p5 p5_ind] = max(p5, [], 4); 

	p10 = pval;
	p10(pval > 0.10) = 0;
	[p10 p10_ind] = max(p10, [], 4);

	% select dim
	for ii = 1:size(accuracy,1)
		for jj = 1:size(accuracy,2)
			for kk = 1:size(accuracy, 3)

				% (subject x CV x method)
				acc_p1(ii, jj, kk) = accuracy(ii, jj, kk, p1_ind(ii, jj, kk));
				acc_p5(ii, jj, kk) = accuracy(ii, jj, kk, p5_ind(ii, jj, kk));
				acc_p10(ii, jj, kk) = accuracy(ii, jj, kk, p10_ind(ii, jj, kk));
			end
		end
	end

	% (method x subject)
	acc_p1_mean = permute(mean(acc_p1, 2), [3 1 2]);
	acc_p5_mean = permute(mean(acc_p5, 2), [3 1 2]);
	acc_p10_mean = permute(mean(acc_p10, 2), [3 1 2]);

	acc_p1_mean = addmean(acc_p1_mean, 2);
	acc_p5_mean = addmean(acc_p5_mean, 2);
	acc_p10_mean = addmean(acc_p10_mean, 2);


	%% squeeze dim by fixed dim ---------------------------------------
	% from (sub x CV x methods x dim)

	% into (sub x CV x methods) 
	d = 10;
	acc_fix = accuracy(:,:,:,d);

	% into (methods x sub)
	acc_fix_mean = permute(mean(acc_fix, 2), [3 1 2]);
	acc_fix_mean = addmean(acc_fix_mean, 2);

end



%% organize accuracies to structure ---------------------------------
% accuracy: (sub x CV x method x dim)
% acc_CVmean: (dim x sub x method)

% acc_max_CVmean: (method x sub); same dim in CV
% max_ind: (method x sub)
% acc_max: (sub x CV x method)
% acc_max_mean: (method x sub); same dim in all subject

% pval_ind: (sub x CV x method)
% acc_pval: (sub x CV x method)
% acc_pval_mean: (method x sub)

% acc_fix: (sub x CV x method)
% acc_fix_mean: (method x sub)

Acc = decompose_accuracy(accuracy, ave, Para, 3);
Acc_mean = decompose_accuracy(acc_CVmean, ave, Para, 3);

if size(acc_CVmean, 1) ~= 1
	Acc_max_CVmean = decompose_accuracy(acc_max_CVmean, ave, Para, 1);
	Acc_max_ind = decompose_accuracy(max_ind, ave, Para, 1);
	Acc_max = decompose_accuracy(acc_max, ave, Para, 3);
	Acc_max_mean = decompose_accuracy(acc_max_mean, ave, Para, 1);

	Acc_p1 = decompose_accuracy(acc_p1, ave, Para, 3);
	Acc_p5 = decompose_accuracy(acc_p5, ave, Para, 3);
	Acc_p10 = decompose_accuracy(acc_p10, ave, Para, 3);
	Acc_p1_mean = decompose_accuracy(acc_p1_mean, ave, Para, 1);
	Acc_p5_mean = decompose_accuracy(acc_p5_mean, ave, Para, 1);
	Acc_p10_mean = decompose_accuracy(acc_p10_mean, ave, Para, 1);

	Acc_fix = decompose_accuracy(acc_fix, ave, Para, 3);
	Acc_fix_mean = decompose_accuracy(acc_fix_mean, ave, Para, 1);
end






