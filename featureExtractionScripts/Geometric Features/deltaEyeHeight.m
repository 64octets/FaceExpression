function [deltaEyeH, distX_ini, distX_final] = deltaEyeHeight(landmarks1, landmarks2, eye_points)
% Input: landmarks1 - This is the data matrix containing the coordinates (X,Y) 
%                     of the fiducial points of the face in neutral expression
%
%        landmarks2 - This is the data matrix containing the coordinates (X,Y) 
%                     of the fiducial points of the face in the apex expression
%        eye_points - Position in the landmarks of points related to the eyes 
%
% Output: Variation of the aperture of the eye during the movement.

maxY = max(landmarks1(eye_points, 2));
minY = min(landmarks1(eye_points, 2));

distX_ini = maxY - minY;

maxY = max(landmarks2(eye_points, 2));
minY = min(landmarks2(eye_points, 2));

distX_final = maxY - minY;

deltaEyeH = distX_final - distX_ini;



