function resultQDA = classifyQDA(X,y, classificationMethodology, indicesStored)
% Perform cross-validation on the CK+ data using Quadratic discriminant analysis 
%
% Input
%   X                         - features
%   y                         - labels
%   ClassificationMethodology - classification methodology
%                               {'leave-subject-out', 'kfold'}
%   indicesStored             - indices for cross validation
%
% Output
%   resultQDA  -  result of the classification
%
% History
%   created  -  Rodrigo Araujo (sineco@gmail.com), 05-04-2012
%   modified -  Rodrigo Araujo (sineco@gmail.com), 05-04-2012


global numImagePerSequence;
global numSamplesDistribution;

if strcmp(classificationMethodology, 'leave-subject-out')
    [tempY, tempYExpanded] = createUnitLabel(numImagePerSequence, numSamplesDistribution);
    %In order to avoid repetition of similar images in the testing set
    %Lets consider every 4 sequences as a unit.
    
    %% Create unit exclusive k-fold indices
    k =10; %10 k-fold
    indices = indicesStored;
    %save indices6ClassesLSO indices;
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
%     indices = crossvalind('Kfold',y,k); %Uncomment to create new indices
%     load indices6ClassesMixed;
    indices = [indicesStored; indicesStored; indicesStored];
end
cp = classperf(y);
for i = 1:k
    test = (indices == i);
    train = ~test;
    
    t1 = tic;
    [classQuadratic, errorQuadratic, POSTERIOR, logp, coeff] = classify(X(test,:), X(train,:), y(train), 'Quadratic');
    %% time measurement
    elapsedTime = toc(t1);
    fprintf(['Elapsed time QDA %g sec\n'],elapsedTime);
    elapsedTimeQDA(i,1) = elapsedTime;
    elapsedTimeQDA(i,2) = size(X(test,:),1); %num samples
    save timeQDA elapsedTimeQDA;
    %%
    
    classperf(cp,classQuadratic,test)
    %[XCoord,YCoord, thre, AUC_LDA] = perfcurve(y(test)',POSTERIOR(:,1),-1); %ROC curve
end
%% Time
average = sum(elapsedTimeQDA)/k
classificationPerSample = average(1)/average(2)
%%

resultQDA = cp;
clear indices;

%errorQDA = (size(classLinear,1) - sum(y(test) == classLinear'))/size(classLinear,1);

