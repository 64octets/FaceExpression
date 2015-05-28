function [deltaDist, a, b] = deltaDistEyeBrowOuterRight(landmarks1, landmarks2)

outerBrowCorner_1 = landmarks1(27,:);
outerEyeCorner_1 = landmarks1(46,:);

a = pdist([outerBrowCorner_1; outerEyeCorner_1], 'euclidean');

outerBrowCorner_2 = landmarks2(27,:);
outerEyeCorner_2 = landmarks2(46,:);

b = pdist([outerBrowCorner_2; outerEyeCorner_2], 'euclidean');

deltaDist = b - a;