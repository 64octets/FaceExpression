function noisyLandmarks = addNoiseToLandmark(landmarks)
numImages = size(landmarks, 2);
numPoints = size(landmarks{1}, 1); %Check the number of points

noisyLandmarks = cell(1,numImages);
[noisyLandmarks{:}]=deal(zeros(numPoints,2));

for i = 1:numImages
noisyLandmarks{i} = addGaussianNoise(landmarks{i});
end
