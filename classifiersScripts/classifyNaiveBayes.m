function error = classifyNaiveBayes(X,y, classificationMethodology, indicesStored)
% Perform cross-validation on the CK+ data using Naive Bayes classifier 
%
% Input
%   X                         - features
%   y                         - labels
%   ClassificationMethodology - classification methodology
%                               {'leave-subject-out', 'kfold'}
%   indicesStored             - indices for cross validation
%
% Output
%   error  -  result of the classification
%
% History
%   created  -  Rodrigo Araujo (sineco@gmail.com), 05-04-2012
%   modified -  Rodrigo Araujo (sineco@gmail.com), 05-04-2012
addpath('./NaiveBayes');

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
%     indices = crossvalind('Kfold',y,k); %Uncomment to create new indices
     %load indices6ClassesMixed;
    indices = [indicesStored; indicesStored; indicesStored];
end

estimatedLabel = zeros(size(y,1), 1);

for i = 1:k
    test = (indices == i);
    train = ~test;
    
    O1 = NaiveBayes.fit(X(train,:),y(train));
    t1 = tic;
    C1 = O1.predict(X(test,:));
    %% time measurement
    elapsedTime = toc(t1);
    fprintf(['Elapsed time Naive Bayes %g sec\n'],elapsedTime);
    elapsedTimeNB(i,1) = elapsedTime;
    elapsedTimeNB(i,2) = size(X(test,:),1); %num samples
    save timeNB elapsedTimeNB;
    %%
    cMat1 = confusionmat(y(test),C1)
    
    %   O2 = NaiveBayes.fit(meas,species,'dist',...
    % {'normal','kernel','normal','kernel'});
    % C2 = O2.predict(meas);
    % cMat2 = confusionmat(species,C2)
    predict_label_L = C1;
    estimatedLabel(test) = predict_label_L;
end
%% Time
average = sum(elapsedTimeNB)/k
classificationPerSample = average(1)/average(2)
%% 
correctPos = estimatedLabel == y; %positions where it got it right
numCorrect = sum(correctPos); %total # of right answers
totalSamples = size(y,1);

accuracy = numCorrect/totalSamples;
error = 1 - accuracy;
clear indices;
