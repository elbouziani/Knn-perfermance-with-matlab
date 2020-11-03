function [k_nearest_distances_and_indices_matrix, mode_value]=knn(data, query, k, distance_fn)
    data
    rows=size(data,1);
  
    neighbor_distances_and_indices = zeros(rows,2);
    
    
    # 3. For each example in the 
    for i = 1 : rows
        # 3.1 Calculate the distance between the query example and the current
        # example from the data.
        distance = distance_fn(data(i,1),query);
        
        # 3.2 Add the distance and the index of the example to an ordered collection
        
        neighbor_distances_and_indices(i,1)=distance;
        neighbor_distances_and_indices(i,2)=i;
        
     end   
    
    # 4. Sort the ordered collection of distances and indices from
    # smallest to largest (in ascending order) by the distances
    sorted_neighbor_distances_and_indices = sortrows(neighbor_distances_and_indices,1);
    
    # 5. Pick the first K entries from the sorted collection
    k_nearest_distances_and_indices = sorted_neighbor_distances_and_indices(1:k);
    
    
    # 6. Get the labels of the selected K entries
    k_nearest_labels = zeros(k,1);
    for j=1:k
     k_nearest_labels(j,1)=data(k_nearest_distances_and_indices(j,2),2);
    end

    mode_value=mode(k_nearest_labels);
    k_nearest_distances_and_indices_matrix=k_nearest_distances_and_indices;
    
    
end


