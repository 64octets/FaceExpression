% This script is part of the conference paper
% "A Fast and Robust Feature Set for Cross Individual Facial Expression
% Recognition" published at ICCVG in 2012 by Rodrigo Araujo, 
% Yun-Qian Miao, Mohamed S. Kamel, Mohamed Cheriet.

% This script compares different sets of features using different
% classifiers


% Number of images per class:
%------------------------------
%1=anger (45) x 3 = 135
%2=contempt (18) x 3 = 54
%3=disgust (59) x 3 = 177
%4=fear  (25) x 3 = 75
%5=happy (69) x 3 = 207
%6=sadness (28) x 3 = 84
%7=surprise (83) x 3 = 249
%8=neutral (327)
%------------------------------

clear result;
addpath('./featureExtractionScripts', ...
    './featureExtractionScripts/Geometric Features', ...
    './featureExtractionScripts/Gabor Features', ...
    './featureExtractionScripts/LBP Features', ...
    './featureExtractionScripts/AAM Features', ...
    './featureExtractionScripts/CAPP Features', ...
    './featureExtractionScripts/SPTS Features', ...
    './featureExtractionScripts/AAM Functions', ...
    './featureExtractionScripts/PieceWiseLinearWarp_version1', ...
    './featureExtractionScripts/Misc Functions');
addpath('./classifiersScripts','./classifiersScripts/NaiveBayes');
addpath('./data');
addpath('./lib');


global numClasses;
global numImagePerSequence;
global removedClass;
indicesStored = [];
indicesEvalParameter = [];


%Choose the number of classes you want to classify.
numClasses = 6; %Remove the neutral face
classificationMethodology = 'mixed'; %'mixed' or 'leave-subject-out'
numRuns = 20; %number of times to run the experiments
load './lib/indicesCrossValid'; %Previously generated random indices for cross validation to keep the consistence among the classifiers
load './lib/indicesCrossValidEvalParameter'; %Previously generated random indices for cross validation parameter evaluation o SVM linear

%% Adjust the feature vectors and labels based on the number of classes
[removedClass numImagePerSequence] = adjustFeatureVectorsAndLabels();


typeFeature = {};
result = {};
timeElapsed = {};

typeFeature{1} = 'simpleGeometric'; typeFeature{2} = 'CAPP';
typeFeature{3} = 'SPTS'           ; typeFeature{4} = 'Gabor';
typeFeature{5} = 'LBP'            ;

typeclassifier{1} = 'LDA';typeclassifier{2} = 'NaiveBayes';
typeclassifier{3} = 'SVM';typeclassifier{4} = 'SVM Linear';
typeclassifier{5} = 'KNN';

loadFromFile = 0;%1 true; 0 false
addNoise = 0;

for i=1:length(typeFeature) %Testing new ranges of SVM on LBP
    
    [X, label] = extractFeatures(typeFeature{i}, loadFromFile, addNoise);
    
    for j=1:length(typeclassifier)
        for k = 1:size(indicesTemp,2)
            indicesStored = indicesTemp(:,k);% indicesTemp is load from indicesCrossValid 
            indicesEvalParameter = indicesTempEval(:,1); % indicesTempEval is loaded from indicesCrossValidEvalParameter - always use the same partition to evaluate parameter
            t1 = tic;
            result{i,j,k} = performClassification(X, label, typeclassifier{j}, typeFeature{i}, classificationMethodology, indicesStored);
            elapsedTime = toc(t1);
            fprintf(['Elapsed time '  typeclassifier{j} ' %g sec\n'],elapsedTime);
            timeElapsed{i,j} = elapsedTime;
        end
    end
    
   
end
save FinalResult result;
disp('end');