function [X label] = removeClass(X, label, removedClass)
global numSamplesDistribution;

if removedClass == 0
    X = X;
    label = label;
else
    %[ind, val]=find(label ~= removedClass);                   
    %label = label(ind);
    ind=~ismember(label, removedClass);
    label = label(ind);   
    X = X(ind,:); 
    pos = [1:size(numSamplesDistribution,2)];
    numSamplesDistribution = numSamplesDistribution(~ismember(pos,removedClass)); %remove the samples distribution of the removed class
end
