%Load original dataset III_IIIa
%filters the original_signal into filtered_signal and makes the SCMs
%by Matteo Sartori

clear all; clc;

%file .mat to load
dataset= 'k3b';

load(strcat(dataset,'.mat'));

%settings..
original_signal= s;
class_label= HDR.Classlabel;
fs= HDR.SampleRate;
time = 3;
delay_trial = 4;
pos = HDR.TRIG + delay_trial*fs;
freqband = [7 30];
class_number=length(find(isfinite(unique(class_label))==1));

% regularization coefficient
epsilon = 10^(-10);

%For a correct filtering process, change NaN values to 0 
if (length(find(isnan(original_signal)))~=0)
    [x,y]=size(original_signal);
    for i=x:-1:1,
        for j=y:-1:1
            if (isnan(original_signal(i,j)))
                original_signal(i,j)=0;
            end
        end
    end
end
tic
%4th order Butterworth filter
half_order=2;
[b,a] = butter(half_order, freqband/(fs/2), 'bandpass');
filtered_signal = filter(b,a,original_signal);

toc
%sig: signal filtered (TIME x CHANNEL x TRIAL)
%prd: original time point (SAMPLE POINT x TRIAL)
N = time*fs;
M = size(original_signal, 2);
trials_number = length(class_label);

sig = zeros(N, M, trials_number);
prd = zeros(N, trials_number);

for i = 1:trials_number
	prd1 = pos(i):(pos(i) + N - 1);
	sig1 = filtered_signal(prd1, :);
	sig(:, :, i) = sig1 - ones(N, 1)*mean(sig1, 1);
	prd(:, i) = prd1;
end


% extract class data 
sig1_ind = find( class_label == 1 );
sig2_ind = find( class_label == 2 );
sig3_ind = find( class_label == 3 );
sig4_ind = find( class_label == 4 );

% make each class sig
sig1 = sig(:,:,sig1_ind);
sig2 = sig(:,:,sig2_ind);
sig3 = sig(:,:,sig3_ind);
sig4 = sig(:,:,sig4_ind);
%save sig1
%% -- for CSP classification
clear sig;
sig(:,:,:,1)=sig1;
sig(:,:,:,2)=sig2;
sig(:,:,:,3)=sig3;
sig(:,:,:,4)=sig4;

% make SCMs (CHANNEL x CHANNEL x TRIAL)
P1 = zeros(M, M, size(sig1,3));
P2 = zeros(M, M, size(sig2,3));
P3 = zeros(M, M, size(sig3,3));
P4 = zeros(M, M, size(sig4,3));
for i = 1 : numel(sig1_ind)
	P1(:,:,i) = cov(sig1(:,:,i)) + epsilon * eye(M);
    P2(:,:,i) = cov(sig2(:,:,i)) + epsilon * eye(M);
    P3(:,:,i) = cov(sig3(:,:,i)) + epsilon * eye(M);
    P4(:,:,i) = cov(sig4(:,:,i)) + epsilon * eye(M);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save(strcat('RSCM_',dataset),'P1','P2','P3','P4','RP1','RP2','RP3','RP4','class_number');
save(strcat('SCM_IIIa_',dataset),'P1','P2','P3','P4','class_number');

%%--- SCM for CSP
% save(strcat('..\..\..\Classification_CSP\SCMs\SCM_CSP_',dataset),'P1','P2','P3','P4','class_number','sig');