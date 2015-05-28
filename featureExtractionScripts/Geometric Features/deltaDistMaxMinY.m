function [indMinY2, deltaMaxMinY] = deltaDistMaxMinY(landmarks1, landmarks2, leftBrow_points, rightBrow_points)

%Left eye
[max_Y1, indMaxY1] = max(landmarks1(leftBrow_points, 2));
[min_Y1, indMinY1] = min(landmarks1(leftBrow_points, 2));

[max_Y2, indMaxY2] = max(landmarks2(leftBrow_points, 2));
[min_Y2, indMinY2] = min(landmarks2(leftBrow_points, 2));

distMaxMinY1 = abs(max_Y1 - min_Y1);
distMaxMinY2 = abs(max_Y2 - min_Y2);

deltaMaxMinY = abs(distMaxMinY2 - distMaxMinY1);
