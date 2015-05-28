function X = selectGeometricFeatures(X)

%Only left side, mouth and nose features
selectedFeatures = [1 3 5 7 8 10 12 14 15 16 17 18 19 20 21 23]; % Original

%right side features
%2 4 6 9 11 13

%left side features
%1 3 5 8 10 12

%Both left and rigth eye features, mouth and nose features.
%selectedFeatures = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23];

X = X(:,selectedFeatures);


