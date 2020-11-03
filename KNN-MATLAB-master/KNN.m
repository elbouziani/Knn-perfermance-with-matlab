filename = 'data.csv';
M = csvread(filename,1,0,[1 0 179 3]);
testL = M(:,1);
testX = M(:,2);
testY = M(:,3);
testZ = M(:,4);
N = csvread(filename,1,4,[1 4 267 7]);
trainL = N(:,1);
trainX = N(:,2);
trainY = N(:,3);
trainZ = N(:,4);
accuracy = zeros(1, 20);
for k = 1:20
    correct_prediction = 0;
    for l = 1:size(M,1)
        testx = testX(l);
        testy = testY(l);
        testz = testZ(l);
        testl = testL(l);
        D = Eucdistance(testx, testy, testz );
        for j = 1:size(N,1)
            Point.X = trainX(j);
            Point.Y = trainY(j);
            Point.Z = trainZ(j);
            Point.L = trainL(j);
            Point.index = j;
            Point.D = D(j);
            points(j) = struct ('x',Point.X,'y',Point.Y,'z',Point.Z,'L',Point.L,'D',Point.D,'index',Point.index);
        end
        [min, order] = sort([points.D]);
        SumLabel = 0;
        for i = 1:k
            ind = order (i);
            Label = points(ind).L;
            SumLabel = SumLabel + Label;
        end
        predict_Class = SumLabel/k;
        if predict_Class>0.5
            classification = 1;
        else
            classification = 0;
        end
        if classification == testl
            correct_prediction = correct_prediction + 1;
        end
    end
    accuracy(k) = correct_prediction/size(M,1);
end
[max_accuracy,bes_k] = max(accuracy);
disp('maximumAccuracy');
disp(max_accuracy);
disp('best K value')
disp(bes_k);
[acc,ind] = sort(accuracy);
for i = 1:20
    C(i) = struct('Kvalue',ind(i),'Accuracy',acc(i));
    disp(C(i))
end
plot(acc,ind,'b',max_accuracy,bes_k,'cX')
grid on
title('Accuracy-K plot')
xlabel('Accuracy')
ylabel('K')
