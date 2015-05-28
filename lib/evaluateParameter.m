function [accuracy] = evaluateParameter(X,y,c,g)
load indicesCrossValidEvalParameter;
indicesEvalParameter = indicesTempEval(:,1);


k=5;
%indices = getIndicesRandom('leave-subject-out', y,k);
indices = indicesEvalParameter;
%save indicesEvalParameterLSSIO indices;
%load indicesEvalParameterLSSIO;
    
estimatedLabel = zeros(size(y,1), 1);
k = 5; %10 k-fold
tempPredict_label_L = {}; 
tempTest = {};
parfor i = 1:k
    test = (indices == i);
    train = ~test;
    cmd = ['-c ', num2str(c), ' -g ', num2str(g), ' -t 0 -q'];
    model = svmtrain(y(train,:),X(train,:), cmd);

    [predict_label_L, accuracy_L, dec_values_L] = svmpredict(y(test), X(test,:), model); %one-against-one approach
    
    %estimatedLabel(test) = predict_label_L;
    tempPredict_label_L{i} = predict_label_L;
    tempTest{i} = test;
   
end

for j = 1:k
    test = tempTest{j};
    estimatedLabel(test) = tempPredict_label_L{j};
end
correctPos = estimatedLabel == y; %positions where it got it right
numCorrect = sum(correctPos); %total # of right answers
totalSamples = size(y,1);

accuracy = numCorrect/totalSamples;
error = 1 - accuracy;