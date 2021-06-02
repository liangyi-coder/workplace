function [ROIonly,levels] = prepareVolume(volume,Ng)
% -------------------------------------------------------------------------
% function [ROIonly,levels] = prepareVolume(volume,mask,scanType,pixelW,sliceS,R,scale,textType,quantAlgo,Ng)
% -------------------------------------------------------------------------
% DESCRIPTION: 
% This function prepares the input volume for 3D texture analysis. The 
% following operations are performed:
%
% 1. Computation of the smallest box containing region of interest (ROI), 
%    if necessary (ROIbox).
% 2. Pre-processing of the ROIbox (PET: square-root, MR: Collewet 
%    normalizaton, CT: nothing).
% 3. Wavelet band-pass filtering (WBPF).
% 4. Isotropic resampling.
% 5. Quantization of intensity dynamic range.
%
% --> This function is compatible with 2D analysis (language not adapted in the text)
% -------------------------------------------------------------------------
% REFERENCE:
% [1] Vallieres, M. et al. (2015). A radiomics model from joint FDG-PET and 
%     MRI texture features for the prediction of lung metastases in soft-tissue 
%     sarcomas of the extremities. Physics in Medicine and Biology, 60(14), 
%     5471-5496. doi:10.1088/0031-9155/60/14/5471
% -------------------------------------------------------------------------
% INPUTS:
% - volume: 2D or 3D array containing the medical images to analyze
% - mask: 2D or 3D array of dimensions corresponding to 'volume'. The mask 
%         contains 1's in the region of interest (ROI), and 0's elsewhere.
% - scanType: String specifying the type of scan analyzed. Either 'PETscan', 
%             'MRscan' or 'Other'.
% - pixelW: Numerical value specifying the in-plane resolution (mm) of 'volume'.
% - sliceS: Numerical value specifying the slice spacing (mm) of 'volume'.
%           Put a random number for 2D analysis.
% - R: Numerical value specifying the ratio of weight to band-pass coefficients 
%      over the weigth of the rest of coefficients (HHH and LLL). Provide R=1 
%      to not perform wavelet band-pass filtering.    
% - scale: Numerical value specifying the scale at which 'volume' is isotropically 
%          resampled (mm). If a string 'pixelW' is entered as input, the
%          volume will be isotropically resampled at the initial in-plane
%          resolution of 'volume' specified by 'pixelW'.
% - textType: String specifying for which type of textures 'volume' is 
%             being prepared. Either 'Global' or 'Matrix'. If 'Global', the 
%             volume will be prepared for Global texture features computation. 
%             If 'Matrix',the volume will be prepared for matrix-based texture 
%             features computation (i.e. GLCM, GLRLM, GLSZM, NGTDM).
% - quantAlgo: String specifying the quantization algorithm to use on 'volume'. 
%              Either 'Equal' for equal-probability quantization, 'Lloyd'
%              for Lloyd-Max quantization, or 'Uniform' for uniform quantization.
%              Use only if textType is set to 'Matrix'.
% - Ng: Integer specifying the number of gray levels in the quantization process.
%       Use only if textType is set to 'Matrix'.
% -------------------------------------------------------------------------
% OUTPUTS:
% - ROIonly: Smallest box containing the ROI, with the imaging data of
%            the ready for texture analysis computations. Voxels outside
%            the ROI are set to NaNs.
% - levels: Vector containing the quantized gray-levels in the tumor region
%           (or reconstruction levels of quantization).
% - ROIbox: Smallest box containing the ROI. Optional output.
% - maskBox: Smallest mask containing the ROI. Optional output.
% -------------------------------------------------------------------------
% EXAMPLE:
% Let a PET scan be defined by 'volume', with 'mask' defining the ROI. The 
% PET scan has in-plane resolution of 4 mm, with slice spacing of 3.27 mm.
%             
% 1. To prepare 'volume' for matrix-based texture analysis at a scale of 
%    5 mm, without WBPF, using a Lloyd-Max quantization algorithm with 32 
%    gray-levels, run:
%
%    [ROIonly,levels] = prepareVolume(volume,mask,'PETscan',4,3.27,1,5,'Matrix','Lloyd',32)
% 
%    Next, use 'ROIonly' and 'levels' as inputs to 'getGLCM.m, 'getGLRLM.m',
%    'getGLSZM.m' or 'getNGTDM.m'.
%      
%
% 2. To prepare 'volume' for global texture analysis at a scale equal to the 
%    in-plane resolution, with R=2, run:
%
%    [ROIonly] = prepareVolume(volume,mask,'PETscan',4,3.27,2,'pixelW','Global')
% 
%    Next, use 'ROIonly' as input to 'getGlobalTextures.m'.
% -------------------------------------------------------------------------
% AUTHOR(S): Martin Vallieres <mart.vallieres@gmail.com>
% -------------------------------------------------------------------------
% HISTORY:
% - Creation: January 2013
% - Revision: May 2015
% -------------------------------------------------------------------------
% STATEMENT:
% This file is part of <https://github.com/mvallieres/radiomics/>, 
% a package providing MATLAB programming tools for radiomics analysis.
% --> Copyright (C) 2015  Martin Vallieres
% 
%    This package is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This package is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this package.  If not, see <http://www.gnu.org/licenses/>.
% -------------------------------------------------------------------------

mask=logical(volume);
% COMPUTATION OF THE SMALLEST BOX CONTAINING THE ROI
% [boxBound] = computeBoundingBox(mask);
% maskBox = mask(boxBound(1,1):boxBound(1,2),boxBound(2,1):boxBound(2,2),boxBound(3,1):boxBound(3,2));
% ROIbox = volume(boxBound(1,1):boxBound(1,2),boxBound(2,1):boxBound(2,2),boxBound(3,1):boxBound(3,2));
[ROIbox,maskBox]=bounding_box1(volume);

% PRE-PROCESSING OF ROI BOX
ROIbox = double(ROIbox);

    ROIonly = ROIbox;
    ROIonly(~maskBox) = NaN;
  
% QUANTIZATION
ROIonly = double(ROIonly);
maxVal = max(ROIonly(:));
minVal = min(ROIonly(:));
ROIonly = round((Ng-1)*(ROIonly-minVal)/(maxVal-minVal))+1;

levels = 1:Ng;
end
