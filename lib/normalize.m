function [X_] = normalize(X)

%statistical normalization
u = mean(X);
s = std(X);
X_ = zeros(size(X));
for i = 1:size(X,1)
    X_(i,:) = (X(i,:) - u)./s;    
end