%function to calculate the confusion matrix
%by matteo Sartori

function [ C ] = class_accuracy_confusion_matrix( resultLabels, testLabels, Class )

    for ii=Class
        ind_test=find(testLabels==ii);
        n_test=numel(ind_test);
        for jj=Class
            C(jj,ii)=numel(find(resultLabels(ind_test)==jj))/n_test;
        end
    end

end

