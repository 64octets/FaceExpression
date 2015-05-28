function [deltaDistInnerBrow, a, b] = deltaDistInnerBrowCorners(landmarks1, landmarks2)

innerBrowCornerLeft_1 = landmarks1(22,:);
innerBrowCornerRight_1 = landmarks1(23,:);

a = pdist([innerBrowCornerLeft_1; innerBrowCornerRight_1], 'euclidean');

innerBrowCornerLeft_2 = landmarks2(22,:);
innerBrowCornerRight_2 = landmarks2(23,:);

b = pdist([innerBrowCornerLeft_2; innerBrowCornerRight_2], 'euclidean');

deltaDistInnerBrow = abs(b - a);
