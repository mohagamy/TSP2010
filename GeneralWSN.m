% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Creats the data structure WSN and sets its initial data values. 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.


clear WSN
WSN.R = 2;
WSN.M = 512;
WSN.N = 256;
WSN.L = 32;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.APsDirections = [0 65];
WSN.TargetedAP = [1];
WSN.UnTargetedAP = [2];
WSN.K = length(WSN.APsDirections) - 1;
WSN.phi = -180:180;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.SNR = 10^(20/10);
WSN.INRthr = 10.^(10./10);
WSN.NoisePower = 0.05;
WSN.Wmax = sqrt((WSN.NoisePower*WSN.SNR)/WSN.N);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.vx = 0.5;
WSN.mx = 0;

WSN.v  = 0.2;
WSN.m = 0;

WSN.ma = exp(WSN.m+(WSN.v/2));
WSN.va = (exp(WSN.v)-1)*(exp(2*WSN.m+WSN.v));

WSN.vX = WSN.NoisePower*WSN.SNR*((WSN.vx + WSN.mx^2)*(WSN.va + WSN.ma^2) - WSN.mx^2*WSN.ma^2);
WSN.beta = (WSN.NoisePower*WSN.INRthr)/(2*WSN.vX);
WSN.vI = (  WSN.vX*(1-(1+WSN.beta).*exp(-WSN.beta))  )./ ((1-exp(-WSN.beta)) ) ;
WSN.vINR = (  WSN.vX*(1-(1+WSN.beta).*exp(-WSN.beta))  )./ (WSN.NoisePower*(1-exp(-WSN.beta)) ) ;