function [deltaDistCorners, a, b] = deltaDist2Points(landmarks1, landmarks2, points)

cornerLeft_1 = landmarks1(points(1),:);
cornerRight_1 = landmarks1(points(2),:);

a = pdist([cornerLeft_1; cornerRight_1], 'euclidean');

cornerLeft_2 = landmarks2(points(1),:);
cornerRight_2 = landmarks2(points(2),:);

b = pdist([cornerLeft_2; cornerRight_2], 'euclidean');

deltaDistCorners = abs(b - a);