function error = classifyLIBSVM(X,y, classificationMethodology, kernel, indicesStored)
% Perform cross-validation on the CK+ data using SVM 
%
% Input
%   X                         - features
%   y                         - labels
%   ClassificationMethodology - classification methodology
%                               {'leave-subject-out', 'kfold'}
%   kernel                    - type of kernel
%   indicesStored             - indices for cross validation
%
% Output
%   error  -  result of the classification
%
% History
%   created  -  Rodrigo Araujo (sineco@gmail.com), 05-04-2012
%   modified -  Rodrigo Araujo (sineco@gmail.com), 05-04-2012

if strcmp(classificationMethodology, 'mixed')
    %indices = getIndices(classificationMethodology, y, indicesStored);
    indices = [indicesStored; indicesStored; indicesStored];
    
    estimatedLabel = zeros(size(y,1), 1);
    k = 10; %10 k-fold
    
    for i = 1:k
        test = (indices == i);
        train = ~test;
        
        if strcmp(kernel, 'RBF');
            [model, bestc, bestg] = selectBestModel(X(train,:),y(train,:), classificationMethodology);
        else %linear
            [model, bestc, bestg] = selectBestModelLinear(X(train,:),y(train,:), classificationMethodology);
        end
        
        t1 = tic;
        [predict_label_L, accuracy_L, dec_values_L] = svmpredict(y(test), X(test,:), model); %one-against-one approach
        %% time measurement
        elapsedTime = toc(t1);
        fprintf(['Elapsed time SVM %g sec\n'],elapsedTime);
        elapsedTimeSVM(i,1) = elapsedTime;
        elapsedTimeSVM(i,2) = size(X(test,:),1); %num samples
        save timeSVM elapsedTimeSVM;
        %%
        
        estimatedLabel(test) = predict_label_L;
        %      tempPredict_label_L(:,i) = predict_label_L;
        %      tempTest(:,i) = test;
    end
    % for j = 1:k
    %     test = tempTest(:,j);
    %     estimatedLabel(test) = tempPredict_label_L(:,j);
    % end
    %% Time
    average = sum(elapsedTimeSVM)/k;
    classificationPerSample = average(1)/average(2)
    %%
    
    correctPos = estimatedLabel == y; %positions where it got it right
    numCorrect = sum(correctPos); %total # of right answers
    totalSamples = size(y,1);
    
    accuracy = numCorrect/totalSamples;
    error = 1 - accuracy;
    clear indices;
    
else %leave subject out
    
    indices = getIndices(classificationMethodology, y, indicesStored);
    
    estimatedLabel = zeros(size(y,1), 1);
    k = 10; %10 k-fold
    
    for i = 1:k
        test = (indices == i);
        train = ~test;
        
        if strcmp(kernel, 'RBF');
            [model, bestc, bestg] = selectBestModel(X(train,:),y(train,:), classificationMethodology);
        else %linear
            [model, bestc, bestg] = selectBestModelLinear(X(train,:),y(train,:), classificationMethodology);
        end
        
        t1 = tic;
        [predict_label_L, accuracy_L, dec_values_L] = svmpredict(y(test), X(test,:), model); %one-against-one approach
        %% time measurement
        elapsedTime = toc(t1);
        fprintf(['Elapsed time SVM %g sec\n'],elapsedTime);
        elapsedTimeSVM(i,1) = elapsedTime;
        elapsedTimeSVM(i,2) = size(X(test,:),1); %num samples
        save timeSVM elapsedTimeSVM;
        %%
        
        estimatedLabel(test) = predict_label_L;
        %      tempPredict_label_L(:,i) = predict_label_L;
        %      tempTest(:,i) = test;
    end
    % for j = 1:k
    %     test = tempTest(:,j);
    %     estimatedLabel(test) = tempPredict_label_L(:,j);
    % end
    %% Time
    average = sum(elapsedTimeSVM)/k;
    classificationPerSample = average(1)/average(2)
    %%
    
    correctPos = estimatedLabel == y; %positions where it got it right
    numCorrect = sum(correctPos); %total # of right answers
    totalSamples = size(y,1);
    
    accuracy = numCorrect/totalSamples;
    error = 1 - accuracy;
    clear indices;
    
end