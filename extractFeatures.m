function [X, label] = extractFeatures(typeFeature, loadFromFile, addNoise)
% Extract specified feature

% See the following paper for the details:
%   A Fast and Robust Feature Set for Cross Individual Facial Expression 
%   Recognition, ICCVG 2012
%
% Input
%   typeFeature  -  name of the feature you want to extract
%   loadFromFile -  flag 1 to load features from file, 0 to calculate own
%                   features (0,1)
%   addNoise     -  flag 1 to add noise(0,1)
%
% Output
%   X       -  segmentation result
%   label    -  segmentation result during the procedure, 1 x nIter (cell)
%
% History
%   created  -  Rodrigo Araujo (sineco@gmail.com), 04-26-2012
%   modified -  

load dataEmotionIma1;
load dataEmotionIma2;
load dataEmotionIma3;
load dataEmotionIma4;
load dataEmotionIma5;
load dataEmotionIma6;
load dataEmotionIma7;
load dataEmotionLandmark1;
load dataEmotionLandmark2;
load dataEmotionLandmark3;
load dataEmotionLandmark4;
load dataEmotionLandmark5;
load dataEmotionLandmark6;
load dataEmotionLandmark7;

numE = [];
numE(1) = size(dataEmotionIma1,2); %45 + 3*45 = 180
numE(2) = size(dataEmotionIma2,2); %18 + 3*18 = 72
numE(3) = size(dataEmotionIma3,2); %59 + 3*59 =
numE(4) = size(dataEmotionIma4,2); %25 + 3*25 =
numE(5) = size(dataEmotionIma5,2); %69 + 3*69 =
numE(6) = size(dataEmotionIma6,2); %28 + 3*28 =
numE(7) = size(dataEmotionIma7,2); %83 + 3*83 =
%numE(8) = sum(numE(1) + numE(2) + numE(3) + numE(4) + numE(5) + numE(6) + numE(7));

global numSamplesDistribution;
numImagePerSequence = 4;
global removedClass;
%This variable is not used anywhere. Right now it is just used to keep the
%number of samples per class
numSamplesDistribution =  [numE(1) numE(2) numE(3) numE(4) numE(5) numE(6) numE(7)];% numE(8)];

X = [];
XSimpleGeo = [];
XCAPP = [];
XSPTS = [];
XGabor = [];
XLBP = [];

label = [];
image = {};

I_textureEmo1 = {};
I_textureEmo1Neutral = {};
I_textureEmo1Apex1 = {};
I_textureEmo1Apex2 = {};
I_textureEmo1Apex3 = {};
I_textureEmo2 = {};
I_textureEmo3 = {};
I_textureEmo4 = {};
I_textureEmo5 = {};
I_textureEmo6 = {};
I_textureEmo7 = {};


if strcmp(typeFeature, 'CAPP');
    if loadFromFile
        load ./featureExtractionScripts/CAPP' Features'/CKP_CAPP_v1.mat;
        XCAPP = CAPPFeature;
        label = EmotionLabel;
        clear CAPPFeature; clear EmotionLabel;
        X = XCAPP;
        %remove class
        [X label] = removeClass(X, label, removedClass);
    else
        %If Emotion == 1
        for i = 1:size(dataEmotionIma1, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma1{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark1{i};
            [I_textureEmo1{i}, I_textureEmo1Neutral{i}, I_textureEmo1Apex1{i}, I_textureEmo1Apex2{i}, I_textureEmo1Apex3{i}] = extractCAPP(landmark, image, numImagePerSequence);
            
            X      = reshape(I_textureEmo1{i}(:,:,1), 1, size(I_textureEmo1{i},1)*size(I_textureEmo1{i}, 2));
            XN     = reshape(I_textureEmo1Neutral{i}(:,:,1), 1, size(I_textureEmo1Neutral{i},1)*size(I_textureEmo1Neutral{i}, 2));
            XApex1 = reshape(I_textureEmo1Apex1{i}(:,:,1), 1, size(I_textureEmo1Apex1{i},1)*size(I_textureEmo1Apex1{i}, 2));
            XApex2 = reshape(I_textureEmo1Apex2{i}(:,:,1), 1, size(I_textureEmo1Apex2{i},1)*size(I_textureEmo1Apex2{i}, 2));
            XApex3 = reshape(I_textureEmo1Apex3{i}(:,:,1), 1, size(I_textureEmo1Apex3{i},1)*size(I_textureEmo1Apex3{i}, 2));
            
            XCAPP = [XCAPP; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 1; 1; 1];
        end
        
        %If Emotion == 2
        for i = 1:size(dataEmotionIma2, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma2{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark2{i};
            [I_textureEmo2{i}, I_textureEmo2Neutral{i}, I_textureEmo2Apex1{i}, I_textureEmo2Apex2{i}, I_textureEmo2Apex3{i}] = extractCAPP(landmark, image, numImagePerSequence);
            
            X      = reshape(I_textureEmo2{i}(:,:,1), 1, size(I_textureEmo2{i},1)*size(I_textureEmo2{i}, 2));
            XN     = reshape(I_textureEmo2Neutral{i}(:,:,1), 1, size(I_textureEmo2Neutral{i},1)*size(I_textureEmo2Neutral{i}, 2));
            XApex1 = reshape(I_textureEmo2Apex1{i}(:,:,1), 1, size(I_textureEmo2Apex1{i},1)*size(I_textureEmo2Apex1{i}, 2));
            XApex2 = reshape(I_textureEmo2Apex2{i}(:,:,1), 1, size(I_textureEmo2Apex2{i},1)*size(I_textureEmo2Apex2{i}, 2));
            XApex3 = reshape(I_textureEmo2Apex3{i}(:,:,1), 1, size(I_textureEmo2Apex3{i},1)*size(I_textureEmo2Apex3{i}, 2));
            
            XCAPP = [XCAPP; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 2; 2; 2];
        end
        
        %If Emotion == 3
        for i = 1:size(dataEmotionIma3, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma3{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark3{i};
            [I_textureEmo3{i}, I_textureEmo3Neutral{i}, I_textureEmo3Apex1{i}, I_textureEmo3Apex2{i}, I_textureEmo3Apex3{i}] = extractCAPP(landmark, image, numImagePerSequence);
            
            X      = reshape(I_textureEmo3{i}(:,:,1), 1, size(I_textureEmo3{i},1)*size(I_textureEmo3{i}, 2));
            XN     = reshape(I_textureEmo3Neutral{i}(:,:,1), 1, size(I_textureEmo3Neutral{i},1)*size(I_textureEmo3Neutral{i}, 2));
            XApex1 = reshape(I_textureEmo3Apex1{i}(:,:,1), 1, size(I_textureEmo3Apex1{i},1)*size(I_textureEmo3Apex1{i}, 2));
            XApex2 = reshape(I_textureEmo3Apex2{i}(:,:,1), 1, size(I_textureEmo3Apex2{i},1)*size(I_textureEmo3Apex2{i}, 2));
            XApex3 = reshape(I_textureEmo3Apex3{i}(:,:,1), 1, size(I_textureEmo3Apex3{i},1)*size(I_textureEmo3Apex3{i}, 2));
            
            XCAPP = [XCAPP; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 3; 3; 3];
        end
        
        %If Emotion == 4
        for i = 1:size(dataEmotionIma4, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma4{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark4{i};
            [I_textureEmo4{i}, I_textureEmo4Neutral{i}, I_textureEmo4Apex1{i}, I_textureEmo4Apex2{i}, I_textureEmo4Apex3{i}] = extractCAPP(landmark, image, numImagePerSequence);
            
            X      = reshape(I_textureEmo4{i}(:,:,1), 1, size(I_textureEmo4{i},1)*size(I_textureEmo4{i}, 2));
            XN     = reshape(I_textureEmo4Neutral{i}(:,:,1), 1, size(I_textureEmo4Neutral{i},1)*size(I_textureEmo4Neutral{i}, 2));
            XApex1 = reshape(I_textureEmo4Apex1{i}(:,:,1), 1, size(I_textureEmo4Apex1{i},1)*size(I_textureEmo4Apex1{i}, 2));
            XApex2 = reshape(I_textureEmo4Apex2{i}(:,:,1), 1, size(I_textureEmo4Apex2{i},1)*size(I_textureEmo4Apex2{i}, 2));
            XApex3 = reshape(I_textureEmo4Apex3{i}(:,:,1), 1, size(I_textureEmo4Apex3{i},1)*size(I_textureEmo4Apex3{i}, 2));
            
            XCAPP = [XCAPP; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 4; 4; 4];
        end
        
        %If Emotion == 5
        for i = 1:size(dataEmotionIma5, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma5{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark5{i};
            [I_textureEmo5{i}, I_textureEmo5Neutral{i}, I_textureEmo5Apex1{i}, I_textureEmo5Apex2{i}, I_textureEmo5Apex3{i}] = extractCAPP(landmark, image, numImagePerSequence);
            
            X      = reshape(I_textureEmo5{i}(:,:,1), 1, size(I_textureEmo5{i},1)*size(I_textureEmo5{i}, 2));
            XN     = reshape(I_textureEmo5Neutral{i}(:,:,1), 1, size(I_textureEmo5Neutral{i},1)*size(I_textureEmo5Neutral{i}, 2));
            XApex1 = reshape(I_textureEmo5Apex1{i}(:,:,1), 1, size(I_textureEmo5Apex1{i},1)*size(I_textureEmo5Apex1{i}, 2));
            XApex2 = reshape(I_textureEmo5Apex2{i}(:,:,1), 1, size(I_textureEmo5Apex2{i},1)*size(I_textureEmo5Apex2{i}, 2));
            XApex3 = reshape(I_textureEmo5Apex3{i}(:,:,1), 1, size(I_textureEmo5Apex3{i},1)*size(I_textureEmo5Apex3{i}, 2));
            
            XCAPP = [XCAPP; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 5; 5; 5];
        end
        
        %If Emotion == 6
        for i = 1:size(dataEmotionIma6, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma6{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark6{i};
            [I_textureEmo6{i}, I_textureEmo6Neutral{i}, I_textureEmo6Apex1{i}, I_textureEmo6Apex2{i}, I_textureEmo6Apex3{i}] = extractCAPP(landmark, image, numImagePerSequence);
            
            X      = reshape(I_textureEmo6{i}(:,:,1), 1, size(I_textureEmo6{i},1)*size(I_textureEmo6{i}, 2));
            XN     = reshape(I_textureEmo6Neutral{i}(:,:,1), 1, size(I_textureEmo6Neutral{i},1)*size(I_textureEmo6Neutral{i}, 2));
            XApex1 = reshape(I_textureEmo6Apex1{i}(:,:,1), 1, size(I_textureEmo6Apex1{i},1)*size(I_textureEmo6Apex1{i}, 2));
            XApex2 = reshape(I_textureEmo6Apex2{i}(:,:,1), 1, size(I_textureEmo6Apex2{i},1)*size(I_textureEmo6Apex2{i}, 2));
            XApex3 = reshape(I_textureEmo6Apex3{i}(:,:,1), 1, size(I_textureEmo6Apex3{i},1)*size(I_textureEmo6Apex3{i}, 2));
            
            XCAPP = [XCAPP; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 6; 6; 6];
        end
        
        %If Emotion == 7
        for i = 1:size(dataEmotionIma7, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma7{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark7{i};
            [I_textureEmo7{i}, I_textureEmo7Neutral{i}, I_textureEmo7Apex1{i}, I_textureEmo7Apex2{i}, I_textureEmo7Apex3{i}] = extractCAPP(landmark, image, numImagePerSequence);
            
            X      = reshape(I_textureEmo7{i}(:,:,1), 1, size(I_textureEmo7{i},1)*size(I_textureEmo7{i}, 2));
            XN     = reshape(I_textureEmo7Neutral{i}(:,:,1), 1, size(I_textureEmo7Neutral{i},1)*size(I_textureEmo7Neutral{i}, 2));
            XApex1 = reshape(I_textureEmo7Apex1{i}(:,:,1), 1, size(I_textureEmo7Apex1{i},1)*size(I_textureEmo7Apex1{i}, 2));
            XApex2 = reshape(I_textureEmo7Apex2{i}(:,:,1), 1, size(I_textureEmo7Apex2{i},1)*size(I_textureEmo7Apex2{i}, 2));
            XApex3 = reshape(I_textureEmo7Apex3{i}(:,:,1), 1, size(I_textureEmo7Apex3{i},1)*size(I_textureEmo7Apex3{i}, 2));
            
            XCAPP = [XCAPP; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 7; 7; 7];
        end
        %     EmotionLabel = label;
        %     CAPPFeature = XCAPP;
        %     save ./featureExtractionScripts/CAPP' Features'/CKP_CAPP_v1 EmotionLabel CAPPFeature;
        
        X = XCAPP;
        %remove class
        [X label] = removeClass(X, label, removedClass);
    end
    
end



if strcmp(typeFeature, 'SPTS');
    if loadFromFile
        load ./featureExtractionScripts/SPTS' Features'/CKP_SPTS_v2.mat;
        XSPTS = SPTSFeature;
        label = EmotionLabel;
        clear SPTSFeature; clear EmotionLabel;
        X = XSPTS;
        %remove class
        [X label] = removeClass(X, label, removedClass);
    else
        %If Emotion == 1
        for i = 1:size(dataEmotionIma1, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma1{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark1{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            [x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
            
            X = normalizeByNeutralFace(x_mean{i}, xNeutral{i});%landmark{1}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XN = normalizeByNeutralFace(xNeutral{i}, xNeutral{i});%landmark{1}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex1 = normalizeByNeutralFace(xApex1{i}, xNeutral{i});%landmark{1}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex2 = normalizeByNeutralFace(xApex2{i}, xNeutral{i});%landmark{1}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex3 = normalizeByNeutralFace(xApex3{i}, xNeutral{i});%landmark{1}); %normalization with neutral face (should I do the same for simple geometricc features?)
            
            XSPTS = [XSPTS; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 1; 1; 1];
        end
        
        %If Emotion == 2
        for i = 1:size(dataEmotionIma2, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma2{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark2{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            [x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
            
            X = normalizeByNeutralFace(x_mean{i}, xNeutral{i});%landmark{1}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XN = normalizeByNeutralFace(xNeutral{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex1 = normalizeByNeutralFace(xApex1{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex2 = normalizeByNeutralFace(xApex2{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex3 = normalizeByNeutralFace(xApex3{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            
            XSPTS = [XSPTS; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 2; 2; 2];
        end
        
        %If Emotion == 3
        for i = 1:size(dataEmotionIma3, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma3{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark3{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            [x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
            
            X = normalizeByNeutralFace(x_mean{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XN = normalizeByNeutralFace(xNeutral{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex1 = normalizeByNeutralFace(xApex1{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex2 = normalizeByNeutralFace(xApex2{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex3 = normalizeByNeutralFace(xApex3{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            
            XSPTS = [XSPTS; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 3; 3; 3];
        end
        
        %If Emotion == 4
        for i = 1:size(dataEmotionIma4, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma4{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark4{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            [x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
            
            X = normalizeByNeutralFace(x_mean{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XN = normalizeByNeutralFace(xNeutral{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex1 = normalizeByNeutralFace(xApex1{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex2 = normalizeByNeutralFace(xApex2{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex3 = normalizeByNeutralFace(xApex3{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            
            XSPTS = [XSPTS; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 4; 4; 4];
        end
        
        %If Emotion == 5
        for i = 1:size(dataEmotionIma5, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma5{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark5{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            [x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
            
            X = normalizeByNeutralFace(x_mean{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XN = normalizeByNeutralFace(xNeutral{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex1 = normalizeByNeutralFace(xApex1{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex2 = normalizeByNeutralFace(xApex2{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex3 = normalizeByNeutralFace(xApex3{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            
            XSPTS = [XSPTS; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 5; 5; 5];
        end
        
        %If Emotion == 6
        for i = 1:size(dataEmotionIma6, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma6{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark6{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            [x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
            
            X = normalizeByNeutralFace(x_mean{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XN = normalizeByNeutralFace(xNeutral{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex1 = normalizeByNeutralFace(xApex1{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex2 = normalizeByNeutralFace(xApex2{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex3 = normalizeByNeutralFace(xApex3{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            
            XSPTS = [XSPTS; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 6; 6; 6];
        end
        
        %If Emotion == 7
        for i = 1:size(dataEmotionIma7, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma7{i}{j}; %apex image
            end
            landmark = dataEmotionLandmark7{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            [x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
            
            X = normalizeByNeutralFace(x_mean{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XN = normalizeByNeutralFace(xNeutral{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex1 = normalizeByNeutralFace(xApex1{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex2 = normalizeByNeutralFace(xApex2{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            XApex3 = normalizeByNeutralFace(xApex3{i}, xNeutral{i}); %normalization with neutral face (should I do the same for simple geometricc features?)
            
            XSPTS = [XSPTS; XN; XApex1; XApex2; XApex3];
            label = [label; 8; 7; 7; 7];
        end
        
        EmotionLabel = label;
        SPTSFeature = XSPTS;
        save ./featureExtractionScripts/SPTS' Features'/CKP_SPTS_v2 EmotionLabel SPTSFeature;
        X = XSPTS;
        %remove class
        [X label] = removeClass(X, label, removedClass);
    end
end


if strcmp(typeFeature, 'simpleGeometric');
    if loadFromFile
        load ./featureExtractionScripts/Geometric' Features'/CKP_Geometric_v1.mat;
        XSimpleGeo = GeometricFeature;
        label = EmotionLabel;
        clear GeometricFeature; clear EmotionLabel;
        X = XSimpleGeo;
        %remove class
        [X label] = removeClass(X, label, removedClass);
    else
        
        for i = 1:size(dataEmotionIma1, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma1{i}{j}; %all 4 images
            end
            landmark = dataEmotionLandmark1{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            %Uncomment
            %[x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
            %comment
            landmarkNeutral = landmark{1};
            landmarkApex1 = landmark{2};
            landmarkApex2 = landmark{3};
            landmarkApex3 = landmark{4};
            %comment
            XN     = normalize(landmarkNeutral);
            XApex1 = normalize(landmarkApex1);
            XApex2 = normalize(landmarkApex2);
            XApex3 = normalize(landmarkApex3);
            
            
            
 
            XN_geo_f          = extractGeometricFeatures(image, XN, typeFeature);
            XApex1_geo_f      = extractGeometricFeatures(image, XApex1, typeFeature);
            XApex2_geo_f      = extractGeometricFeatures(image, XApex2, typeFeature);
            XApex3_geo_f      = extractGeometricFeatures(image, XApex3, typeFeature);
            
            XN_geo = normalizeByNeutralFace(XN_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex1_geo = normalizeByNeutralFace(XApex1_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex2_geo = normalizeByNeutralFace(XApex2_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex3_geo = normalizeByNeutralFace(XApex3_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            
            
            XN_geo          = selectGeometricFeatures(XN_geo);
            XApex1_geo      = selectGeometricFeatures(XApex1_geo);
            XApex2_geo      = selectGeometricFeatures(XApex2_geo);
            XApex3_geo      = selectGeometricFeatures(XApex3_geo);
            
            XNormXN_geo          = normalize(XN_geo);
            XNormXApex1_geo      = normalize(XApex1_geo);
            XNormXApex2_geo      = normalize(XApex2_geo);
            XNormXApex3_geo      = normalize(XApex3_geo);
            
            
%             XSimpleGeo = [XSimpleGeo; XN_geo; XApex1_geo; XApex2_geo; XApex3_geo];
            XSimpleGeo = [XSimpleGeo; XNormXN_geo; XNormXApex1_geo; XNormXApex2_geo; XNormXApex3_geo];
            label = [label; 8; 1; 1; 1];
        end
        
        
        for i = 1:size(dataEmotionIma2, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma2{i}{j}; %all 4 images
            end
            landmark = dataEmotionLandmark2{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            %[x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
             %comment
            landmarkNeutral = landmark{1};
            landmarkApex1 = landmark{2};
            landmarkApex2 = landmark{3};
            landmarkApex3 = landmark{4};
            %comment
            XN     = normalize(landmarkNeutral);
            XApex1 = normalize(landmarkApex1);
            XApex2 = normalize(landmarkApex2);
            XApex3 = normalize(landmarkApex3);
            
    
%             
            XN_geo_f          = extractGeometricFeatures(image, XN, typeFeature);
            XApex1_geo_f      = extractGeometricFeatures(image, XApex1, typeFeature);
            XApex2_geo_f      = extractGeometricFeatures(image, XApex2, typeFeature);
            XApex3_geo_f      = extractGeometricFeatures(image, XApex3, typeFeature);
            
               XN_geo = normalizeByNeutralFace(XN_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex1_geo = normalizeByNeutralFace(XApex1_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex2_geo = normalizeByNeutralFace(XApex2_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex3_geo = normalizeByNeutralFace(XApex3_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            
            
            XN_geo          = selectGeometricFeatures(XN_geo);
            XApex1_geo      = selectGeometricFeatures(XApex1_geo);
            XApex2_geo      = selectGeometricFeatures(XApex2_geo);
            XApex3_geo      = selectGeometricFeatures(XApex3_geo);
            
            XNormXN_geo          = normalize(XN_geo);
            XNormXApex1_geo      = normalize(XApex1_geo);
            XNormXApex2_geo      = normalize(XApex2_geo);
            XNormXApex3_geo      = normalize(XApex3_geo);
%             
            
%             XSimpleGeo = [XSimpleGeo; XN_geo; XApex1_geo; XApex2_geo; XApex3_geo];
            XSimpleGeo = [XSimpleGeo; XNormXN_geo; XNormXApex1_geo; XNormXApex2_geo; XNormXApex3_geo];
            label = [label; 8; 2; 2; 2];
        end
        
   
        for i = 1:size(dataEmotionIma3, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma3{i}{j}; %all 4 images
            end
            landmark = dataEmotionLandmark3{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            %[x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
            
             %comment
            landmarkNeutral = landmark{1};
            landmarkApex1 = landmark{2};
            landmarkApex2 = landmark{3};
            landmarkApex3 = landmark{4};
            %comment
            XN     = normalize(landmarkNeutral);
            XApex1 = normalize(landmarkApex1);
            XApex2 = normalize(landmarkApex2);
            XApex3 = normalize(landmarkApex3);
            

            
            XN_geo_f          = extractGeometricFeatures(image, XN, typeFeature);
            XApex1_geo_f      = extractGeometricFeatures(image, XApex1, typeFeature);
            XApex2_geo_f      = extractGeometricFeatures(image, XApex2, typeFeature);
            XApex3_geo_f      = extractGeometricFeatures(image, XApex3, typeFeature);
            
               XN_geo = normalizeByNeutralFace(XN_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex1_geo = normalizeByNeutralFace(XApex1_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex2_geo = normalizeByNeutralFace(XApex2_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex3_geo = normalizeByNeutralFace(XApex3_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            
            
            XN_geo          = selectGeometricFeatures(XN_geo);
            XApex1_geo      = selectGeometricFeatures(XApex1_geo);
            XApex2_geo      = selectGeometricFeatures(XApex2_geo);
            XApex3_geo      = selectGeometricFeatures(XApex3_geo);
            
            XNormXN_geo          = normalize(XN_geo);
            XNormXApex1_geo      = normalize(XApex1_geo);
            XNormXApex2_geo      = normalize(XApex2_geo);
            XNormXApex3_geo      = normalize(XApex3_geo);
%             
            
%             XSimpleGeo = [XSimpleGeo; XN_geo; XApex1_geo; XApex2_geo; XApex3_geo];
            XSimpleGeo = [XSimpleGeo; XNormXN_geo; XNormXApex1_geo; XNormXApex2_geo; XNormXApex3_geo];
            label = [label; 8; 3; 3; 3];
        end
        
        
        for i = 1:size(dataEmotionIma4, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma4{i}{j}; %all 4 images
            end
            landmark = dataEmotionLandmark4{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            %[x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
             %comment
            landmarkNeutral = landmark{1};
            landmarkApex1 = landmark{2};
            landmarkApex2 = landmark{3};
            landmarkApex3 = landmark{4};
            %comment
            XN     = normalize(landmarkNeutral);
            XApex1 = normalize(landmarkApex1);
            XApex2 = normalize(landmarkApex2);
            XApex3 = normalize(landmarkApex3);

            
            XN_geo_f          = extractGeometricFeatures(image, XN, typeFeature);
            XApex1_geo_f      = extractGeometricFeatures(image, XApex1, typeFeature);
            XApex2_geo_f      = extractGeometricFeatures(image, XApex2, typeFeature);
            XApex3_geo_f      = extractGeometricFeatures(image, XApex3, typeFeature);
            
               XN_geo = normalizeByNeutralFace(XN_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex1_geo = normalizeByNeutralFace(XApex1_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex2_geo = normalizeByNeutralFace(XApex2_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex3_geo = normalizeByNeutralFace(XApex3_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            
            
            XN_geo          = selectGeometricFeatures(XN_geo);
            XApex1_geo      = selectGeometricFeatures(XApex1_geo);
            XApex2_geo      = selectGeometricFeatures(XApex2_geo);
            XApex3_geo      = selectGeometricFeatures(XApex3_geo);
            
            XNormXN_geo          = normalize(XN_geo);
            XNormXApex1_geo      = normalize(XApex1_geo);
            XNormXApex2_geo      = normalize(XApex2_geo);
            XNormXApex3_geo      = normalize(XApex3_geo);
            
            
%             XSimpleGeo = [XSimpleGeo; XN_geo; XApex1_geo; XApex2_geo; XApex3_geo];
            XSimpleGeo = [XSimpleGeo; XNormXN_geo; XNormXApex1_geo; XNormXApex2_geo; XNormXApex3_geo];
            label = [label; 8; 4; 4; 4];
        end
        
        
        for i = 1:size(dataEmotionIma5, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma5{i}{j}; %all 4 images
            end
            landmark = dataEmotionLandmark5{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            %[x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
             %comment
            landmarkNeutral = landmark{1};
            landmarkApex1 = landmark{2};
            landmarkApex2 = landmark{3};
            landmarkApex3 = landmark{4};
            %comment
            XN     = normalize(landmarkNeutral);
            XApex1 = normalize(landmarkApex1);
            XApex2 = normalize(landmarkApex2);
            XApex3 = normalize(landmarkApex3);
  
            
            XN_geo_f          = extractGeometricFeatures(image, XN, typeFeature);
            XApex1_geo_f      = extractGeometricFeatures(image, XApex1, typeFeature);
            XApex2_geo_f      = extractGeometricFeatures(image, XApex2, typeFeature);
            XApex3_geo_f      = extractGeometricFeatures(image, XApex3, typeFeature);
            
            XN_geo = normalizeByNeutralFace(XN_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex1_geo = normalizeByNeutralFace(XApex1_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex2_geo = normalizeByNeutralFace(XApex2_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex3_geo = normalizeByNeutralFace(XApex3_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            
            XN_geo          = selectGeometricFeatures(XN_geo);
            XApex1_geo      = selectGeometricFeatures(XApex1_geo);
            XApex2_geo      = selectGeometricFeatures(XApex2_geo);
            XApex3_geo      = selectGeometricFeatures(XApex3_geo);
            
            XNormXN_geo          = normalize(XN_geo);
            XNormXApex1_geo      = normalize(XApex1_geo);
            XNormXApex2_geo      = normalize(XApex2_geo);
            XNormXApex3_geo      = normalize(XApex3_geo);
%             
            
%             XSimpleGeo = [XSimpleGeo; XN_geo; XApex1_geo; XApex2_geo; XApex3_geo];
            XSimpleGeo = [XSimpleGeo; XNormXN_geo; XNormXApex1_geo; XNormXApex2_geo; XNormXApex3_geo];
            label = [label; 8; 5; 5; 5];
        end
  
        
        for i = 1:size(dataEmotionIma6, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma6{i}{j}; %all 4 images
            end
            landmark = dataEmotionLandmark6{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            %[x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
             %comment
            landmarkNeutral = landmark{1};
            landmarkApex1 = landmark{2};
            landmarkApex2 = landmark{3};
            landmarkApex3 = landmark{4};
            %comment
            XN     = normalize(landmarkNeutral);
            XApex1 = normalize(landmarkApex1);
            XApex2 = normalize(landmarkApex2);
            XApex3 = normalize(landmarkApex3);
            

            
            XN_geo_f          = extractGeometricFeatures(image, XN, typeFeature);
            XApex1_geo_f      = extractGeometricFeatures(image, XApex1, typeFeature);
            XApex2_geo_f      = extractGeometricFeatures(image, XApex2, typeFeature);
            XApex3_geo_f      = extractGeometricFeatures(image, XApex3, typeFeature);
            
            XN_geo = normalizeByNeutralFace(XN_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex1_geo = normalizeByNeutralFace(XApex1_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex2_geo = normalizeByNeutralFace(XApex2_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex3_geo = normalizeByNeutralFace(XApex3_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            
            
            XN_geo          = selectGeometricFeatures(XN_geo);
            XApex1_geo      = selectGeometricFeatures(XApex1_geo);
            XApex2_geo      = selectGeometricFeatures(XApex2_geo);
            XApex3_geo      = selectGeometricFeatures(XApex3_geo);
            
            XNormXN_geo          = normalize(XN_geo);
            XNormXApex1_geo      = normalize(XApex1_geo);
            XNormXApex2_geo      = normalize(XApex2_geo);
            XNormXApex3_geo      = normalize(XApex3_geo);
%             
            
%             XSimpleGeo = [XSimpleGeo; XN_geo; XApex1_geo; XApex2_geo; XApex3_geo];
            XSimpleGeo = [XSimpleGeo; XNormXN_geo; XNormXApex1_geo; XNormXApex2_geo; XNormXApex3_geo];
            label = [label; 8; 6; 6; 6];
        end
        
        
        for i = 1:size(dataEmotionIma7, 2)
            
            for j=1:numImagePerSequence
                image{j} = dataEmotionIma7{i}{j}; %all 4 images
            end
            landmark = dataEmotionLandmark7{i};
            if addNoise
                landmark = addNoiseToLandmark(landmark);
            end
            %[x_mean{i}, xNeutral{i}, xApex1{i}, xApex2{i}, xApex3{i}] = extractSPTS(landmark, image, numImagePerSequence);
             %comment
            landmarkNeutral = landmark{1};
            landmarkApex1 = landmark{2};
            landmarkApex2 = landmark{3};
            landmarkApex3 = landmark{4};
            %comment
            XN     = normalize(landmarkNeutral);
            XApex1 = normalize(landmarkApex1);
            XApex2 = normalize(landmarkApex2);
            XApex3 = normalize(landmarkApex3);
            
     
            
            XN_geo_f          = extractGeometricFeatures(image, XN, typeFeature);
            XApex1_geo_f      = extractGeometricFeatures(image, XApex1, typeFeature);
            XApex2_geo_f      = extractGeometricFeatures(image, XApex2, typeFeature);
            XApex3_geo_f      = extractGeometricFeatures(image, XApex3, typeFeature);
            
               XN_geo = normalizeByNeutralFace(XN_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex1_geo = normalizeByNeutralFace(XApex1_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex2_geo = normalizeByNeutralFace(XApex2_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            XApex3_geo = normalizeByNeutralFace(XApex3_geo_f, XN_geo_f)';%landmark{1}); %normalization with neutral face
            
            
            XN_geo          = selectGeometricFeatures(XN_geo);
            XApex1_geo      = selectGeometricFeatures(XApex1_geo);
            XApex2_geo      = selectGeometricFeatures(XApex2_geo);
            XApex3_geo      = selectGeometricFeatures(XApex3_geo);
            
            XNormXN_geo          = normalize(XN_geo);
            XNormXApex1_geo      = normalize(XApex1_geo);
            XNormXApex2_geo      = normalize(XApex2_geo);
            XNormXApex3_geo      = normalize(XApex3_geo);
            
            
%             XSimpleGeo = [XSimpleGeo; XN_geo; XApex1_geo; XApex2_geo; XApex3_geo];
            XSimpleGeo = [XSimpleGeo; XNormXN_geo; XNormXApex1_geo; XNormXApex2_geo; XNormXApex3_geo];
            label = [label; 8; 7; 7; 7];
        end
        %     EmotionLabel = label;
        %     GeometricFeature = XSimpleGeo;
        %     save ./featureExtractionScripts/Geometric' Features'/CKP_Geometric_v1 EmotionLabel GeometricFeature;
        
        X = XSimpleGeo;
        %remove class
        [X label] = removeClass(X, label, removedClass);
    end
end

if strcmp(typeFeature, 'Gabor');
    load ./featureExtractionScripts/Gabor' Features'/CKP_Gabor_v2_reduced.mat;
    
    XGabor = GaborFeature;
    label = EmotionLabel;
    
    clear GaborFeatures; clear EmotionLabel;
    
    X = XGabor;
    %remove class
    [X label] = removeClass(X, label, removedClass);
    
end

if strcmp(typeFeature, 'LBP');
    load ./featureExtractionScripts/LBP' Features'/CKP_LBP_v1.mat;
    
    XLBP = LBPFeature;
    label = EmotionLabel;
    
    clear LBPFeature; clear EmotionLabel;
    
    X = XLBP;
    %remove class
    [X label] = removeClass(X, label, removedClass);
end
