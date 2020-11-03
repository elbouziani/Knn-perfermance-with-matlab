function D = distance_fn(train_data,test_data)
    
    
    trainX = train_data(:,1);
    trainY = train_data(:,2);
    trainZ = train_data(:,3);
    X = zeros(1, size(train_data,1));
    Y = zeros(1, size(train_data,1));
    Z = zeros(1, size(train_data,1));
    for j = 1:size(train_data,1)
        X(j) = power (trainX(j) - test_data(1),2);
        Y(j) = power (trainY(j) - test_data(2),2);
        Z(j) = power (trainZ(j) - test_data(3),2);
        D(j) = sqrt (X(j) + Y(j) + Z(j));
    end
    end