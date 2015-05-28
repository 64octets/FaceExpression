function [deltaDist, a, b] = deltaDistEyeBrowCornersRight(landmarks1, landmarks2)

innerBrowCorner_1 = landmarks1(23,:);
innerEyeCorner_1 = landmarks1(43,:);

a = pdist([innerBrowCorner_1; innerEyeCorner_1], 'euclidean');

innerBrowCorner_2 = landmarks2(23,:);
innerEyeCorner_2 = landmarks2(43,:);

b = pdist([innerBrowCorner_2; innerEyeCorner_2], 'euclidean');

deltaDist = b - a;