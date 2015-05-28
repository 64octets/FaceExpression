function [deltaAngle, theta1, theta2] = mouthSlop(landmarks1, landmarks2, points)

cornerLeft_1 = landmarks1(points(1),:);
cornerRight_1 = landmarks1(points(2),:);

deltaX = cornerLeft_1(1,1) - cornerRight_1(1,1);
deltaY = cornerLeft_1(1,2) - cornerRight_1(1,2);

X = cornerLeft_1(1,2);

adjacent = deltaX;
opposite = deltaY;

tanX = opposite / adjacent;
%tanX = opposite / X;

theta1 = atan(tanX);



cornerLeft_2 = landmarks2(points(1),:);
cornerRight_2 = landmarks2(points(2),:);

deltaX = cornerLeft_2(1,1) - cornerRight_2(1,1);
deltaY = cornerLeft_2(1,2) - cornerRight_2(1,2);

X = cornerLeft_2(1,2);

adjacent = deltaX;
opposite = deltaY;

tanX = opposite / adjacent; % find the tan of the right angle triangle
%tanX = opposite / X; % find the tan of the right angle triangle

theta2 = atan(tanX);%Calculate the inverse tan to get the angle of the given sin.

deltaAngle = theta2 - theta1;

