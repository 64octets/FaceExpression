function [deltaAreaBoundingBox, areaBoundingBoxNeutral, areaBoundingBoxApex] = deltaAreaBoundingBox(landmarks1, landmarks2, brow_points)

%Left eye
leftEyeLandmarksNeutral = landmarks1(brow_points, :);

[max_Y1, indMaxY1] = max(leftEyeLandmarksNeutral(:,2));
[min_Y1, indMinY1] = min(leftEyeLandmarksNeutral(:,2));


[max_X1, indMaxX1] = max(leftEyeLandmarksNeutral(:,1));
[min_X1, indMinX1] = min(leftEyeLandmarksNeutral(:,1));


A = leftEyeLandmarksNeutral(indMinX1, :); %minX
B = leftEyeLandmarksNeutral(indMinY1, :); %minY
C = leftEyeLandmarksNeutral(indMaxX1, :); %maxX
D = leftEyeLandmarksNeutral(indMaxY1, :); %maxY

A_prime = [A(1); B(2)];
B_prime = [C(1); B(2)];
C_prime = [C(1); D(2)];
D_prime = [A(1); D(2)];

X = [A_prime(1); B_prime(1); C_prime(1); D_prime(1); A_prime(1)];
Y = [A_prime(2); B_prime(2); C_prime(2); D_prime(2); A_prime(2)];

%bounding box area of neutral face

areaBoundingBoxNeutral = polyarea(X,Y);
%Another way to calculate the area for a square
%areaBoundingBox = (D_prime(1) - C_prime(1)) * (A_prime(2) - D_prime(2));



leftEyeLandmarksApex = landmarks2(brow_points, :);

[max_Y1, indMaxY1] = max(leftEyeLandmarksApex(:,2));
[min_Y1, indMinY1] = min(leftEyeLandmarksApex(:,2));


[max_X1, indMaxX1] = max(leftEyeLandmarksApex(:,1));
[min_X1, indMinX1] = min(leftEyeLandmarksApex(:,1));


A = leftEyeLandmarksApex(indMinX1, :); %minX
B = leftEyeLandmarksApex(indMinY1, :); %minY
C = leftEyeLandmarksApex(indMaxX1, :); %maxX
D = leftEyeLandmarksApex(indMaxY1, :); %maxY

A_prime = [A(1); B(2)];
B_prime = [C(1); B(2)];
C_prime = [C(1); D(2)];
D_prime = [A(1); D(2)];

X = [A_prime(1); B_prime(1); C_prime(1); D_prime(1); A_prime(1)];
Y = [A_prime(2); B_prime(2); C_prime(2); D_prime(2); A_prime(2)];

areaBoundingBoxApex = polyarea(X,Y);

deltaAreaBoundingBox = abs(areaBoundingBoxApex - areaBoundingBoxNeutral);