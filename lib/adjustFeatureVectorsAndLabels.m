function [removedClass numImagePerSequence] = adjustFeatureVectorsAndLabels()

global numClasses;


% Adjust the feature vectors and labels
if numClasses == 7
    removedClass = 8; %0 for you dont want to remove any class from the classification
    %numSequence = 327;
    if removedClass == 8
        numImagePerSequence = 3;
    else
        numImagePerSequence = 4;
    end
end


if numClasses == 6
    removedClass = [8 2]; %0 for you dont want to remove any class from the classification
    numImagePerSequence = 3;
end