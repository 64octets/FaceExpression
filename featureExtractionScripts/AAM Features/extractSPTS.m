function [x_mean, xNeutral, xApex1, xApex2, xApex3] = extractSPTS(Landmarks, Image, numSamples)

% Make the transformation structure, note that x and y are switched
% because Matlab uses the second dimensions as x and first as y.
% Piecewise-Linear
for i = 1:numSamples
    temp = Landmarks{i};
    Landmarks{i}=[temp(:,2) temp(:,1)];
end

%% Set options
% Number of contour points interpolated between the major landmarks.
options.ni=0; %20 original  %Not sure if this is going to be used, if true change to zero.
% Set normal appearance/contour, limit to +- m*sqrt( eigenvalue )
options.m=3;
% Size of texture appereance image
options.texturesize=[87 93]; %Original was [100 100]
% If verbose is true all debug images will be shown.
options.verbose=false;
% Number of image scales
options.nscales=4;
% Number of search itterations
options.nsearch=15;

%% Load training data
% First Load the Hand Training DataSets (Contour and Image)
% The LoadDataSetNiceContour, not only reads the contour points, but
% also resamples them to get a nice uniform spacing, between the important
% landmark contour points.

TrainingData=struct;
for i=1:numSamples
    Vertices = Landmarks{i}; %rsaa
    image = Image{i};%rsaa
    
    TrainingData(i).Vertices = Vertices;
    
    %Lines=[(1:size(Vertices,1))' ([2:size(Vertices,1) 1])'];%rsaa
    
    %%
    tri = delaunay(Landmarks{i}(:,1),Landmarks{i}(:,2));
    %%
    
    Lines = [1 2; 2 3; 3 4; 4 5; 5 6; 6 7; 7 8; 8 9; 9 10; 10 11; 11 12; 12 13; 13 14; 14 15; 15 16; 16 17; 17 27; 27 26; 26 25; 25 24; 24 23; 23 22; 22 21; 21 20; 20 19; 19 18; 18 1];
    
    %TrainingData(i).Lines = Lines; Original
    TrainingData(i).Lines = Lines;
        
    I=im2double(image);
    
    if(options.verbose)
        Vertices=TrainingData(i).Vertices;
        Lines=TrainingData(i).Lines;
        t=mod(i-1,4); if(t==0), figure; end
        subplot(2,2,t+1), imshow(I); hold on;
        P1=Vertices(Lines(:,1),:); P2=Vertices(Lines(:,2),:);
        plot([P1(:,2) P2(:,2)]',[P1(:,1) P2(:,1)]','b');
        drawnow;
    end
    TrainingData(i).I=I;
end

[ShapeData,TrainingData] = AAM_MakeShapeModel2D(TrainingData);
x_mean   = ShapeData.x_mean;
xNeutral = ShapeData.x(:,1);
xApex1   = ShapeData.x(:,2);
xApex2   = ShapeData.x(:,3);
xApex3   = ShapeData.x(:,4);
% Show some eigenvector variations
if(options.verbose)
    figure,
    for i=1:3 %rsaa Lets only show 3 to avoid ??? Index exceeds matrix dimensions. Original was 6
        xtest = ShapeData.x_mean + ShapeData.Evectors(:,i)*sqrt(ShapeData.Evalues(i))*3;
        subplot(2,3,i), hold on;
        plot(xtest(end/2+1:end),xtest(1:end/2),'r.');
        plot(ShapeData.x_mean(end/2+1:end),ShapeData.x_mean(1:end/2),'b.');
    end
end