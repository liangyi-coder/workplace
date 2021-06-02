function [vox_val_probs,vox_val_hist]=histogram3d(img_vol_subvol,num_img_values)
mask_vol_subvol=logical(img_vol_subvol);
num_ROI_voxels = length(find(mask_vol_subvol));
%%% Discretize the image volume to the desired number of graytones. The
%%% PORTS functions require the image voxel values to be {1,2,3,...,N}. 

% Find the min and max within only the ROI:
img_min = min(img_vol_subvol(mask_vol_subvol)); 
img_max = max(img_vol_subvol(mask_vol_subvol)); 


% Rescale to image volume to [0,N]:
img_vol_subvol = num_img_values .* (img_vol_subvol - img_min)/(img_max - img_min) ;

% Discretize and add 1 to get values {1,2,...,N+1}:
img_vol_subvol = floor(img_vol_subvol) + 1;

% The max value is currently one higher than it should be (N+1), so put 
% those voxels at the max value:
img_vol_subvol(img_vol_subvol==num_img_values+1) = num_img_values;




%%%%%
%%%%% Histogram-based computations:
%%%%%

% Compute the histogram of the ROI and probability of each voxel value:
vox_val_hist = zeros(num_img_values,1);
for this_vox_value = 1:num_img_values
    vox_val_hist(this_vox_value) = length(find((img_vol_subvol == this_vox_value) & (mask_vol_subvol == 1) ));
end
% vox_val_hist=vox_val_hist';
% Compute the relative probabilities from the histogram:
vox_val_probs = vox_val_hist / num_ROI_voxels;
