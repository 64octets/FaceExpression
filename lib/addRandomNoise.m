function Xmod = addRandomNoise(X)

r = rand(size(X,1), size(X,2));
r = r/10000;
Xmod = X + r;