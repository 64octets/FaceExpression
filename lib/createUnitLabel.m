function [tempY, tempYExpanded] = createUnitLabel(numImagePerSequence, numE)

%The implementation is kinda complex (too lazy to make it easier) but the idea is simple
%It writes in a vector tempY the labels of the emotions in a sequencial order
%Ex.: [1 1 1 2 2 2 2 2 3 3 3 3 3];
numSequence = sum(numE);
tempY = ones(numSequence, 1);

for i=size(numE,2):-1:2
    ans = numSequence - numE(i);
    tempY(ans+1:numSequence) = i;
    numSequence = ans;
end

numSequence = sum(numE);
tempYExpanded = ones(numSequence * numImagePerSequence, 1);
numSequence = numSequence * numImagePerSequence;

for i=size(numE,2):-1:2
    ans = numSequence - (numE(i)+ (numImagePerSequence -1) * numE(i));
    tempYExpanded(ans+1:numSequence) = i;
    numSequence = ans;
end

