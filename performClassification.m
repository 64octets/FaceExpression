function [result] = performClassification(X, y, classifier, typeFeature, classificationMethodology, indicesStored)
% 
% Perform classification using different classifiers

% See the following paper for the details:
%   A Fast and Robust Feature Set for Cross Individual Facial Expression 
%   Recognition, ICCVG 2012
%
% Input
%   X                         - features
%   y                         - labels
%   classifier                - name of the classifier {'QDA', 'LDA', 
%                               'NaiveBayes', 'SVM', 'SVMLinear', 'KNN'}
%   typeFeature               - feature used (for specific feature
%                                selection)
%   ClassificationMethodology - classification methodology
%                               {'leave-subject-out', 'kfold'}
%   indicesStored             - indices for cross validation
%
% Output
%   result  -  result of the classification
%
% History
%   created  -  Rodrigo Araujo (sineco@gmail.com), 05-06-2012
%   modified -  Rodrigo Araujo (sineco@gmail.com), 05-06-2012


%3 apex images persequence

%1=anger (45) x 3 = 135
%2=contempt (18) x 3 = 54
%3=disgust (59) x 3 = 177
%4=fear  (25) x 3 = 75
%5=happy (69) x 3 = 207
%6=sadness (28) x 3 = 84
%7=surprise (83) x 3 = 249
%8=neutral (327)

numberOfPCAs = 16;

if strcmp(classifier, 'LDA');
    if strcmp(typeFeature, 'simpleGeometric')
        X = selectFeatures(X, 0.04, 0.0254); %  if geometric feature use threshold
    elseif strcmp(typeFeature, 'CAPP')
        X = selectFeatures(X, 0.90, []); %  88 if not geometric feature use percentage
    elseif strcmp(typeFeature, 'SPTS')
        X = selectFeatures(X, 0.05, []); %  0.04 if not geometric feature use percentage
    elseif strcmp(typeFeature, 'LBP')
        X = selectFeatures(X, 0.67, []); % 0.54 1140if not geometric feature use percentage
    end
    
    result = classifyLDA(X,y, classificationMethodology, indicesStored)
end

if strcmp(classifier, 'QDA');
    if strcmp(typeFeature, 'simpleGeometric')
        X = selectFeatures(X, 0.04, 0.0254); %  if geometric feature use threshold
    end
    
   result = classifyQDA(X,y, classificationMethodology, indicesStored) 
end

if strcmp(classifier, 'NaiveBayes');
   %add small noise to avoid the problem of
   %The within-class variance in each feature of TRAINING must be positive. The within-class
   %variance in feature 1 2 in class 1 are not positive.
   if strcmp(typeFeature, 'CAPP')
       X = addRandomNoise(X);
   elseif strcmp(typeFeature, 'SPTS')
       X = addRandomNoise(X);
   elseif strcmp(typeFeature, 'Gabor')
       X = addRandomNoise(X);
   elseif strcmp(typeFeature, 'LBP')
       X = addRandomNoise(X);
   end
    
   result = classifyNaiveBayes(X,y, classificationMethodology, indicesStored) %ok
end

if strcmp(classifier, 'SVM');
   kernel = 'RBF';
    
   result = classifyLIBSVM(X,y, classificationMethodology, kernel, indicesStored) %ok
end

if strcmp(classifier, 'SVM Linear');
   kernel = 'linear';
   
   result = classifyLIBSVM(X,y, classificationMethodology, kernel, indicesStored) %ok
end

if strcmp(classifier, 'KNN');
    
    result = classifyKNN(X,y, classificationMethodology, indicesStored) %ok
end



    
