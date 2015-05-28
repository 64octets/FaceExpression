function [X, eliminatedPos] = selectFeatures(X, perc, threshold)

if ~isempty(perc)
    Xstd = std(X);
    totalFeatures = size(X,2);
    numEliminatedFeatures = round(perc * totalFeatures);
    
    [value, pos] = sort(Xstd);
    
    selectedFeatures = value(numEliminatedFeatures+1:end);
    selectedPos = pos(numEliminatedFeatures+1:end);
    eliminatedPos = pos(1:numEliminatedFeatures);
    
    orderedSelectedPos = sort(selectedPos);
    X = X(:,orderedSelectedPos);
else
    Xstd = std(X);
    totalFeatures = size(X,2);
    numEliminatedFeatures = length(find(Xstd <= threshold));
    
    [value, pos] = sort(Xstd);
    
    selectedFeatures = value(numEliminatedFeatures+1:end);
    selectedPos = pos(numEliminatedFeatures+1:end);
    eliminatedPos = pos(1:numEliminatedFeatures);
    
    orderedSelectedPos = sort(selectedPos);
    X = X(:,orderedSelectedPos);
end