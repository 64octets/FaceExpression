function indices = getIndices(classificationMethodology, y, indicesStored)

global numImagePerSequence;
global numSamplesDistribution;


if strcmp(classificationMethodology, 'leave-subject-out')
    [tempY, tempYExpanded] = createUnitLabel(numImagePerSequence, numSamplesDistribution);
    %In order to avoid repetition of similar images in the testing set
    %Lets consider every 4 sequences as a unit.
    
    %% Create unit exclusive k-fold indices
    k =10; %10 k-fold
    %indices = crossvalind('Kfold', tempY,k);
    indices = indicesStored;
    %save indicesV4 indices;
    %load indices6ClassesLSO;
    
    
    indicesTemp = [];
    
    for ii=1:sum(numSamplesDistribution)
        for jj=1:numImagePerSequence
            indicesTemp = [indicesTemp; indices(ii)];
        end
    end
    
    indices = indicesTemp;
    
    %%
else
    k = 10; %10 k-fold
    %indices = crossvalind('Kfold',y,k); %Uncomment to create new indices
    load indices6ClassesMixed;
end