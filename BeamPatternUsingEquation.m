function BPequation = BeamPatternUsingEquation(WSN)
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Finds the average beampattern of the uniform distributed sensor nodes
% using equation (15) from the paper H. Ochiai, P. Mitran, H. V. Poor, and
% V. Tarokh, "Collaborative beam-forming for distributed wireless ad hoc
% sensor networks," IEEE Trans. Signal Processing, vol. 53, no. 11, pp.
% 4110-4124, Nov. 2005. Note that the beampattern in this equation is
% normalized to 1. 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Input(s):
% WSN.phi
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Output(s):
% BPequation
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.


phi = WSN.phi*pi/180;
for cntr=1:length(phi);
    alpha_u=4*pi*WSN.R*sin(phi(cntr)/2);
    BPequation(cntr)=(1/WSN.N)+(1-(1/WSN.N))*(abs( 2*(besselj(1,alpha_u))/alpha_u ))^2;
end