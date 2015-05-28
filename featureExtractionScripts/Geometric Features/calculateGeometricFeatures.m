function [XDelta, XFrame1, XFrame2] = calculateGeometricFeatures(frameLandmark1, frameLandmark2)

%Parameters:

%landmarks1 = represents the fudicial points coordinates of frame
%landmarks2 = represents the fudicial points coordinates of another frame
%XDelta   = it is the difference between the features of frama1 and frame
              %2. (feature_fram2 - features_frame1)
%XFrame1 = features of frame 1
%XFrame2 = features of frame 2

global leftBrow_points;
global rightBrow_points;
global leftEye_points;
global rightEye_points;
global leftLowerLid_points;
global rightLowerLid_points;
global mouth_points;
global cornerMouth_points;
global MIDLE_MOUTH_POINTS;
global MIDLE_UPPER_LIPS_POINTS;
global MIDLE_LOWER_LIPS_POINTS;
global CORNER_MIDLE_UPPER_LIPS;
global MIDLE_NOSE_UPPER_LIPS_POINTS;
global NOSE_LEFT_WING_POINTS;
global NOSE_RIGTH_WING_POINTS;
global NOSE_ROOT_TIP_POINTS;
global face_points;

XDelta = [];
XFrame1 = [];
XFrame2 = [];

%for i = 1:size(frameLandmark1,1)
    
    landmarks1 = frameLandmark1;
    landmarks2 = frameLandmark2;
    
    [deltaDistL, distLNeutral, distLApex] = deltaDistEyeBrowCornersLeft(landmarks1, landmarks2); %Left Eye AU1
    [deltaDistR, distRNeutral, distRApex] = deltaDistEyeBrowCornersRight(landmarks1, landmarks2); %Right Eye AU1
    
    %deltaPos = deltaPosBrowCorner(landmarks1, landmarks2); %not invariant
    %[indMaxY, deltaMaxMinY] = deltaDistMaxMinY(landmarks1, landmarks2, leftBrow_points, rightBrow_points);
    [deltaAreaBoundingBoxL areaBoundingBoxLNeutral, areaBoundingBoxLApex] = deltaAreaBoundingBox(landmarks1, landmarks2, leftBrow_points);
    [deltaAreaBoundingBoxR areaBoundingBoxRNeutral, areaBoundingBoxRApex] = deltaAreaBoundingBox(landmarks1, landmarks2, rightBrow_points);
    
    [deltaBrowSlopL, alphaLNeutral, alphaLApex] = browSlop(landmarks1, landmarks2, leftBrow_points);
    [deltaBrowSlopR, alphaRNeutral, alphaRApex] = browSlop(landmarks1, landmarks2, rightBrow_points);
    
    [deltaInnerBrow, innerBrowNeutral, innerBrowApex] = deltaDistInnerBrowCorners(landmarks1, landmarks2);%AU4
    
    [deltaOuterBrowLeft, outerBrowLeftNeutral, outerBrowLeftApex] = deltaDistEyeBrowOuterLeft(landmarks1, landmarks2);%AU2
    [deltaOuterBrowRight, outerBrowRightNeutral, outerBrowRightApex] = deltaDistEyeBrowOuterRight(landmarks1, landmarks2);%AU2
   
    
    [deltaEyeHL, eyeHLNeutral, eyeHLApex]  = deltaEyeHeight(landmarks1, landmarks2, leftEye_points);
    [deltaEyeHR, eyeHRNeutral, eyeHRApex] = deltaEyeHeight(landmarks1, landmarks2, rightEye_points);
    
    [deltaAreaBoundingBoxLowerLidL areaBoundingBoxLowerLidLNeutral areaBoundingBoxLowerLidLApex] = deltaAreaBoundingBox(landmarks1, landmarks2, leftLowerLid_points);
    [deltaAreaBoundingBoxLowerLidR areaBoundingBoxLowerLidRNeutral areaBoundingBoxLowerLidRApex] = deltaAreaBoundingBox(landmarks1, landmarks2, rightLowerLid_points);
    
    [deltaAreaBoundingBoxMouth areaBoundingBoxMouthNeutral areaBoundingBoxMouthApex] = deltaAreaBoundingBox(landmarks1, landmarks2, mouth_points); %AU16
    
    [deltaMouthCorners mouthCornersNeutral mouthCornersApex] = deltaDist2Points(landmarks1, landmarks2, cornerMouth_points);%AU20
    
    [deltaMouthHeight mouthHeightNeutral mouthHeightApex] = deltaDist2Points(landmarks1, landmarks2, MIDLE_MOUTH_POINTS);%AU24 AU25, AU26 AU27
    
    [deltaUpperLipHeight upperLipHeightNeutral upperLipHeightApex] = deltaDist2Points(landmarks1, landmarks2, MIDLE_UPPER_LIPS_POINTS);%AU24
    
    [deltaLowerLipHeight lowerLipHeightNeutral lowerLipHeightApex] = deltaDist2Points(landmarks1, landmarks2, MIDLE_LOWER_LIPS_POINTS);%AU17
    
    [deltaAnglesCornerMiddleMouth anglesCornerMiddleMouthNeutral anglesCornerMiddleMouthApex] = mouthSlop(landmarks1, landmarks2, CORNER_MIDLE_UPPER_LIPS);%AU17 %AU12
                
    [deltaLipNoseHeight lipNoseHeightNeutral lipNoseHeightApex] = deltaDist2Points(landmarks1, landmarks2, MIDLE_NOSE_UPPER_LIPS_POINTS);%AU17
    
    [deltaNoseLeftWingWidth noseLeftWingWidthNeutral noseLeftWingWidthApex] = deltaDist2Points(landmarks1, landmarks2, NOSE_LEFT_WING_POINTS);%AU09
    [deltaNoseRightWingWidth noseRightWingWidthNeutral noseRightWingWidthApex]= deltaDist2Points(landmarks1, landmarks2, NOSE_RIGTH_WING_POINTS);%AU09
    
    [deltaNoseHeight noseHeightNeutral noseHeightApex] = deltaDist2Points(landmarks1, landmarks2, NOSE_ROOT_TIP_POINTS);%AU09
    
    %XFrame1 = [XFrame1; distLNeutral distRNeutral areaBoundingBoxLNeutral areaBoundingBoxRNeutral alphaLNeutral alphaRNeutral innerBrowNeutral outerBrowLeftNeutral outerBrowRightNeutral eyeHLNeutral eyeHRNeutral areaBoundingBoxLowerLidLNeutral areaBoundingBoxLowerLidRNeutral areaBoundingBoxMouthNeutral mouthCornersNeutral mouthHeightNeutral upperLipHeightNeutral lowerLipHeightNeutral anglesCornerMiddleMouthNeutral lipNoseHeightNeutral noseLeftWingWidthNeutral noseRightWingWidthNeutral noseHeightNeutral];
    XFrame1 = [XFrame1; distLNeutral mouthHeightNeutral eyeHLNeutral anglesCornerMiddleMouthNeutral];
    XFrame2 = [XFrame2; distLApex distRApex areaBoundingBoxLApex areaBoundingBoxRApex alphaLApex alphaRApex innerBrowApex outerBrowLeftApex outerBrowRightApex eyeHLApex eyeHRApex areaBoundingBoxLowerLidLApex areaBoundingBoxLowerLidRApex areaBoundingBoxMouthApex mouthCornersApex mouthHeightApex  upperLipHeightApex lowerLipHeightApex anglesCornerMiddleMouthApex lipNoseHeightApex noseLeftWingWidthApex noseRightWingWidthApex noseHeightApex];
    XDelta = [XDelta; deltaDistL deltaDistR deltaAreaBoundingBoxL deltaAreaBoundingBoxR deltaBrowSlopL deltaBrowSlopR deltaInnerBrow deltaOuterBrowLeft deltaOuterBrowRight deltaEyeHL deltaEyeHR deltaAreaBoundingBoxLowerLidL deltaAreaBoundingBoxLowerLidR deltaAreaBoundingBoxMouth deltaMouthCorners deltaMouthHeight deltaUpperLipHeight deltaLowerLipHeight deltaAnglesCornerMiddleMouth deltaLipNoseHeight deltaNoseLeftWingWidth deltaNoseRightWingWidth deltaNoseHeight];
    
%end
