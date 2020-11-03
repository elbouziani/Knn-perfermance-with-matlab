function D = Eucdistance( testX, testY, testZ)
filename = 'data.csv';
N = csvread(filename,1,4,[1 4 267 7]);
trainX = N(:,2);
trainY = N(:,3);
trainZ = N(:,4);
X = zeros(1, size(N,1));
Y = zeros(1, size(N,1));
Z = zeros(1, size(N,1));
for j = 1:size(N,1)
    X(j) = power (trainX(j) - testX,2);
    Y(j) = power (trainY(j) - testY,2);
    Z(j) = power (trainZ(j) - testZ,2);
    D(j) = sqrt (X(j) + Y(j) + Z(j))
end
end



