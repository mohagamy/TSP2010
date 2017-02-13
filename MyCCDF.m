function [xCCDF,yCCDF] = MyCCDF(x)
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.

[yy,xx,n,emsg,eid] = cdfcalc(x);

k = length(xx);
n = reshape(repmat(1:k, 2, 1), 2*k, 1);
xCCDF    = [-Inf; xx(n); Inf];
yCCDF    = 1-[0; 0; yy(1+n)];
