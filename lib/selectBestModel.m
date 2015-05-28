function [cv, bestc, bestg] = selectBestModel(X,y, classificationMethodology)%RBF

if strcmp(classificationMethodology, 'mixed')
bestcv = 0;
for log2c = 1:1,  %-2:4
  for log2g = 1:1, % -4:2 mike -50:10:100 %For linear SVM use a dummy gamma. Linear only searches for c.
    cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g) ' -q']; %Using RBF kernel
    cv = svmtrain2(y, X, cmd);
    if (cv >= bestcv),
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
      bestCmd = cmd(5:end); % remove the -v 5
      Bestlog2c = log2c;
      Bestlog2g = log2g;
    end
    %fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);   
  end
end
Bestlog2c
Bestlog2g
save logc Bestlog2c;
save logg Bestlog2g;

cv = svmtrain2(y, X, bestCmd);

else %leave-subject-out configuration
    
 bestAccuracy = 0;
    for c = 200:100:600,  %-2:4 200:50:600
        for g = 1:10:20, 
            %1 - break into 5-folders no mixed subjects
            %2 - evaluate (train with 4 folders and predict with 1 folder)
            accuracy = evaluateParameter(X,y,c,g);
            if (accuracy >= bestAccuracy),
                bestAccuracy = accuracy; 
                bestc = c; 
                bestg = g;
                bestCmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg), ' -t 0 -q']; %Linear kernel
            end
            %fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
        end
    end
    bestc
    bestg
    save logc bestc;
    save logg bestg;
    
    cv = svmtrain(y, X, bestCmd);
    
end
