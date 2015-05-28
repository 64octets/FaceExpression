function [deltaPos] = deltaPosBrowCorner(landmarks1, landmarks2)

%Left eye

innerBrowCorner_1 = landmarks1(22,:);
innerBrowCorner_2 = landmarks2(22,:);

deltaPos = pdist([innerBrowCorner_2 ; innerBrowCorner_1], 'euclidean');
