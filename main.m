filename = 'dataa.txt';
file_data = dlmread(filename);
yval = file_data(:,5);
xval = file_data(:,6);
zval = file_data(:,7);
tval = file_data(:,8);

train_data = [xval zval tval yval];

Yval = file_data(:,1);
Xval = file_data(:,2);
Zval = file_data(:,3);
Tval = file_data(:,4);

test_data = [Xval Zval Tval Yval]
     %AXTRACT JUST 100  ROW from the data
    rows=100;
  
    neighbor_distances_and_indices = zeros(rows,2);
    Accuracies=zeros(10,1);
    Precisions=zeros(10,1);
    Recalls=zeros(10,1);
    
    # 3. For each example in the 
for k=1:10
    
    disp(['Pour k = ' num2str(k)]);
    label=zeros(rows,1);
    
    for i = 1 : rows
      
      %disp(['Pour lentrée = ' num2str(test_data(i,1:3))]);
      
      neighbor_distances_and_indices = zeros(rows,2);
      sorted_neighbor_distances_and_indices = zeros(rows,2);
      
        # 3.1 Calculate the distance between the query example and the current
        # example from the data.
        distance = distance_fn(train_data(:,1:3),test_data(i,1:3));
        distance = distance';
        
        
        
        # 3.2 Add the distance and the index of the example to an ordered collection
        
        
        for j=1:rows
          neighbor_distances_and_indices(j,1)=distance(j,1);
          neighbor_distances_and_indices(j,2)=j;
        end

         


        
        # 4. Sort the ordered collection of distances and indices from
        # smallest to largest (in ascending order) by the distances
        sorted_neighbor_distances_and_indices = sortrows(neighbor_distances_and_indices,1);
        
        # 5. Pick the first K entries from the sorted collection
        k_nearest_distances_and_indices = sorted_neighbor_distances_and_indices(1:k,1:2);
        
        
        # 6. Get the labels of the selected K entries
        k_nearest_labels = zeros(k,1);
        for t=1:k
         k_nearest_labels(t,1)=train_data(k_nearest_distances_and_indices(t,2),4);
        end
        k_nearest_labels;
        
        
        label(i,1)=mode(k_nearest_labels);
        k_nearest_distances_and_indices_matrix=k_nearest_distances_and_indices;   
         
     end   
     
     
    
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% calculation of accuracy, precision, recall %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    pred_val = label;
    accuracy = mean(double(pred_val == Yval));
  acc_all0 = mean(double(0 == Yval));
  
  
  
  printf("|--> accuracy == %f vs accuracy_all0 == %f \n",accuracy,acc_all0);
  

  actual_positives = sum(Yval == 1);
  actual_negatives = sum(Yval == 0);
  true_positives = sum((pred_val == 1) & (Yval == 1));
  false_positives = sum((pred_val == 1) & (Yval == 0));
  false_negatives = sum((pred_val == 0) & (Yval == 1));
  precision = 0; 
  if ( (true_positives + false_positives) > 0)
    precision = true_positives / (true_positives + false_positives);
  endif 

  recall = 0; 
  if ( (true_positives + false_negatives) > 0 )
    recall = true_positives / (true_positives + false_negatives);
  endif 

  F1 = 0; 
  if ( (precision + recall) > 0) 
    F1 = 2 * precision * recall / (precision + recall);
  endif
 
  
    printf("|-->  true_positives == %i  (actual positive =%i) \n",true_positives,actual_positives);
    printf("|-->  false_positives == %i \n",false_positives);
    printf("|-->  false_negatives == %i \n",false_negatives);
    printf("|-->  precision == %f \n",precision);
    printf("|-->  recall == %f \n",recall);
    printf("|-->  F1 == %f \n",F1);
    
    %stock data
    Accuracies(k)=accuracy;
    Precisions(k)=precision;
    Recalls(k)=recall;
    
    
  

end


    Accuracies
    Precisions
    Recalls
    k_values=1:10;                    % make up some sample data*
subplot(3 ,1 ,1);
plot(k_values,Accuracies)                  % plot it
[~,imn]=min(Accuracies);            % get min/max locations
[~,imx]=max(Accuracies);
hold on                    % hold the plot to add to it
plot(k_values([imn;imx]),Accuracies([imn;imx]),'or')  % option one with given locations
ix=[imn;imx];                         % second option to build index
title('Accuracy values per K-neignbours')
xlabel('K-Values') 
ylabel('Accuracy')
plot(k_values(ix),Accuracies(ix),'xk')                % plot that way different syhmbol

%PRECISION

subplot(3 ,1 ,2);
plot(k_values,Precisions)                  % plot it
[~,imn]=min(Precisions);            % get min/max locations
[~,imx]=max(Precisions);
hold on                    % hold the plot to add to it
plot(k_values([imn;imx]),Precisions([imn;imx]),'or')  % option one with given locations
ix=[imn;imx];                         % second option to build index
title('Precisicion values per K-neignbours')
xlabel('K-Values') 
ylabel('Precisicions')
plot(k_values(ix),Precisions(ix),'xk')                % plot that way different syhmbol



%Recalls
subplot(3 ,1 ,3);
plot(k_values,Recalls)                  % plot it
[~,imn]=min(Recalls);            % get min/max locations
[~,imx]=max(Recalls);
hold on                    % hold the plot to add to it
plot(k_values([imn;imx]),Recalls([imn;imx]),'or')  % option one with given locations
ix=[imn;imx];                         % second option to build index
title('Recall values per K-neignbours')
xlabel('K-Values') 
ylabel('Recall')
plot(k_values(ix),Recalls(ix),'xk')                % plot that way different syhmbol
    

    

