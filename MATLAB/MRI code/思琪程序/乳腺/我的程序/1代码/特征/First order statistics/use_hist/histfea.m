
% (1) Mean
% (2) Variance
% (3) Skewness
% (4) Kurtosis
% (5) Energy
% (6) Entropy
% (7)Uniformity

function metrics_vect = histfea(vox_val_probs,num_img_values)



end

%%

% Placeholder for the output:
metrics_vect = zeros(6,1);


%%% Overhead:

% The numerical values of each histogram bin:
vox_val_indices = (1:num_img_values)';

% The indices of non-empty histogram bins:
hist_nz_bin_indices = find(vox_val_probs);



%%% (1) Mean 
metrics_vect(1) = sum(vox_val_indices .* vox_val_probs);



%%% (2) Variance
metrics_vect(2) = sum( ((vox_val_indices - metrics_vect(1)).^2) .* vox_val_probs );


%%%%% IF standard variance is zero, so are skewness and kurtosis:
if metrics_vect(2) > 0
    
    %%% (3) Skewness
    metrics_vect(3) = sum( ((vox_val_indices - metrics_vect(1)).^3) .* vox_val_probs ) / (metrics_vect(2)^(3/2));



    %%% (4) Kurtosis
    metrics_vect(4) = sum( ((vox_val_indices - metrics_vect(1)).^4) .* vox_val_probs ) / (metrics_vect(2)^2);
    metrics_vect(4) = metrics_vect(4) - 3;
    
else
    
    %%% (3) Skewness
    metrics_vect(3) = 0;
    
    
    %%% (4) Kurtosis
    metrics_vect(4) = 0;
    
end
    
    



%%% (5) Energy
metrics_vect(5) = sum( vox_val_probs .^2 );



%%% (6) Entropy (NOTE: 0*log(0) = 0 for entropy calculations)
metrics_vect(6) = -sum( vox_val_probs(hist_nz_bin_indices) .* log(vox_val_probs(hist_nz_bin_indices)) );
% (7)Uniformity
metrics_vect(7)= sum(vox_val_probs(hist_nz_bin_indices).^2);

%%% Final END statement:
end








