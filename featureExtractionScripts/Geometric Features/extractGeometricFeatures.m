function [XNeutral] = extractGeometricFeatures(image, landmarkCoord, typeFeature)


if strcmp(typeFeature, 'simpleGeometric')
    [XNeutral, XApex, XDelta] = calculateSimpleGeometricFeatures(landmarkCoord);
end
