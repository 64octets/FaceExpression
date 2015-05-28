function resultKNN = classifyKNN(X,y, classificationMethodology, indicesStored)
% Perform cross-validation on the CK+ data using KNN
%
% Input
%   X                         - features
%   y                         - labels
%   ClassificationMethodology - classification methodology
%                               {'leave-subject-out', 'kfold'}
%   indicesStored             - indices for cross validation
%
% Output
%   resultKNN  -  result of the classification
%
% History
%   created  -  Rodrigo Araujo (sineco@gmail.com), 05-05-2012
%   modified -  Rodrigo Araujo (sineco@gmail.com), 05-05-2012

global numImagePerSequence;
global numSamplesDistribution;

if strcmp(classificationMethodology, 'leave-subject-out')
    [tempY, tempYExpanded] = createUnitLabel(numImagePerSequence, numSamplesDistribution);
    %In order to avoid repetition of similar images in the testing set
    %Lets consider every 4 sequences as a unit.
    
    %% Create unit exclusive k-fold indices
    k =10; %10 k-fold
    %indices = crossvalind('Kfold', tempY,k);
    indices = indicesStored;
    %save indicesV4 indices;
    %load indices6ClassesLSO;
    
    indicesTemp = [];
    
    for ii=1:sum(numSamplesDistribution)
        for jj=1:numImagePerSequence
            indicesTemp = [indicesTemp; indices(ii)];
        end
    end
    
    indices = indicesTemp;
    
    %%
else
    k = 10; %10 k-fold
    %indices = crossvalind('Kfold',y,k); %Uncomment to create new indices
    %load indices6ClassesMixed;
    indices = [indicesStored; indicesStored; indicesStored];
end

cp = classperf(y);% initializes the CP object
for i = 1:k
    test = (indices == i);
    train = ~test;
    
    
    %%
    
    %     gscatter(X(train,1),X(train,2),y(train),'rb','+x');
    %     legend('Training group 1', 'Training group 2');
    %     hold on;
    %%
    t1 = tic;
    
    class = knnclassify(X(test,:), X(train,:), y(train));
    %% time measurement
    elapsedTime = toc(t1);
    fprintf(['Elapsed time KNN %g sec\n'],elapsedTime);
    elapsedTimeKNN(i,1) = elapsedTime;
    elapsedTimeKNN(i,2) = size(X(test,:),1); %num samples
    save timeLDA elapsedTimeKNN;
    %%
    %     gscatter(X(test,1),X(test,2),class,'mc'); hold on;
    %     legend('Training group 1','Training group 2', ...
    %        'Data in group 1','Data in group 2');
    %     hold off;
    
    
    % updates the CP object with the current classification results
    classperf(cp,class,test);
end
%% Time
average = sum(elapsedTimeKNN)/k
classificationPerSample = average(1)/average(2)
%% 
error = cp.ErrorRate;
resultKNN = cp;
clear indices;

