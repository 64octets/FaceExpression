function [I_texture, I_textureNeutral, I_textureApex1, I_textureApex2, I_textureApex3] = extractCAPP(Landmarks, Image, numSamples)

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
    
    %Lines = extractLines(tri, Landmarks{i}); Uncomment for 2D mesh
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

%% Appearance model %%
% Piecewise linear image transformation is used to align all texture
% information inside the object (hand), to the mean handshape.
% After transformation of all trainingdata textures to the same shape
% PCA is used to describe the mean and variances of the object texture.
AppearanceData=AAM_MakeAppearanceModel2D(TrainingData,ShapeData,options);

% Show some appearance mean and eigenvectors
%if(options.verbose) %rsaa
%   figure,
    
    %g_mean image
    I_texture=AAM_Vector2Appearance2D(AppearanceData.g_mean,AppearanceData.ObjectPixels,options.texturesize);
    
    %g images
    I_textureNeutral=AAM_Vector2Appearance2D(AppearanceData.g(:,1),AppearanceData.ObjectPixels,options.texturesize);
    I_textureApex1=AAM_Vector2Appearance2D(AppearanceData.g(:,2),AppearanceData.ObjectPixels,options.texturesize);
    I_textureApex2=AAM_Vector2Appearance2D(AppearanceData.g(:,3),AppearanceData.ObjectPixels,options.texturesize);
    I_textureApex3=AAM_Vector2Appearance2D(AppearanceData.g(:,4),AppearanceData.ObjectPixels,options.texturesize);
%   subplot(2,2,1),imshow(I_texture,[]); title('mean grey');
%     I_texture=AAM_Vector2Appearance2D(AppearanceData.Evectors(:,1),AppearanceData.ObjectPixels,options.texturesize);
%     subplot(2,2,2),imshow(I_texture,[]); title('first eigenv');
%     I_texture=AAM_Vector2Appearance2D(AppearanceData.Evectors(:,2),AppearanceData.ObjectPixels,options.texturesize);
%     subplot(2,2,3),imshow(I_texture,[]); title('second eigenv');
%     I_texture=AAM_Vector2Appearance2D(AppearanceData.Evectors(:,3),AppearanceData.ObjectPixels,options.texturesize);
%     subplot(2,2,4),imshow(I_texture,[]); title('third eigenv');
%end