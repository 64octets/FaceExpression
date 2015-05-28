function X = normalizeByNeutralFace(x, neutral)
% Subtract the features of the neutral face 

% See the following paper for the details:
%   A Fast and Robust Feature Set for Cross Individual Facial Expression 
%   Recognition, ICCVG 2012
%
% Input
%   x       -  features of emotional face
%   neutral -  features of the neutral emotion face (AU0)
%
% Output
%   X       -  Normalized features
%
% History
%   created  -  Rodrigo Araujo (sineco@gmail.com), 04-13-2012
%   modified -  


X = x - neutral;
X = X';