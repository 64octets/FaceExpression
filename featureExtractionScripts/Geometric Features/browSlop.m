function [deltaAlpha, alphaNeutral, alphaApex] = browSlop(landmarks1, landmarks2, brow_points)

leftEyeLandmarksNeutral = landmarks1(brow_points, :);

deltaY = leftEyeLandmarksNeutral(1,2) - leftEyeLandmarksNeutral(5,2);
deltaX = leftEyeLandmarksNeutral(1,1) - leftEyeLandmarksNeutral(5,1);

XNeutral = leftEyeLandmarksNeutral(1,1);
alphaNeutral = deltaY/deltaX;
%alphaNeutral = deltaY/XNeutral;

leftEyeLandmarksApex = landmarks2(brow_points, :);

deltaY = leftEyeLandmarksApex(1,2) - leftEyeLandmarksApex(5,2);
deltaX = leftEyeLandmarksApex(1,1) - leftEyeLandmarksApex(5,1);

XApex = leftEyeLandmarksApex(1,1);
alphaApex = deltaY/deltaX;
%alphaApex = deltaY/XApex;

deltaAlpha = alphaNeutral - alphaApex; % no absolutevalue - sign is important



