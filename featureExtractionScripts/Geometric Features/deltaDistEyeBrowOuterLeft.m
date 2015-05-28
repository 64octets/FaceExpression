function [deltaDist, a, b] = deltaDistEyeBrowOuterLeft(landmarks1, landmarks2)

outerBrowCorner_1 = landmarks1(18,:);
outerEyeCorner_1 = landmarks1(37,:);

a = pdist([outerBrowCorner_1; outerEyeCorner_1], 'euclidean');

outerBrowCorner_2 = landmarks2(18,:);
outerEyeCorner_2 = landmarks2(37,:);

b = pdist([outerBrowCorner_2; outerEyeCorner_2], 'euclidean');

deltaDist = b - a;