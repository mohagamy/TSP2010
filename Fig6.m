% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Fig 6 : Beampattern: The unintended BSs/APs are at directions
% corresponding to the peaks of the average beampattern: M = 512, N = 256,
% L = 32, phi_0 = 0^o, and eta_thr = 10 dB.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.


clear;clc;
GeneralWSN
WSN = UniformWSN(WSN);
WSN.APsDirections = floor([0 -(2*asin(([2 3]-(1/4))/(4*WSN.R))) (2*asin(([2 3]-(1/4))/(4*WSN.R)))]*180/pi); % The peaks of the average beampattern
WSN.K = length(WSN.APsDirections) - 1;
WSN.ChannelGain = ones(length(WSN.phi),WSN.M);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [1];
WSN.UnTargetedAP = [2:length(WSN.APsDirections)];
WSN1 = NodeSelection(WSN);
BP1 = BeamPattern(WSN1);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%Equation
BPequation = BeamPatternUsingEquation(WSN);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
figure1 = figure;
%% Create axes
axes1 = axes('XTick',[-180 -120 -60 0 60 120 180],'Parent',figure1);
xlim(axes1,[-180 180]);
ylim(axes1,[-10 45]);
xlabel('Angle \phi [degree]');
ylabel('Power/{\sigma_w^2} [dB]');
box('on');
grid('on');
hold('all');
plot(WSN.phi,10*log10(abs(WSN.N*WSN.SNR*BPequation)),'-.k')
plot(WSN.phi,10*log10(abs(BP1./WSN.NoisePower)),'-k')
plot(WSN.APsDirections(2:end),30,'xk')
legend('Average Beampattern','Beampattern - With Node Selection','Directions of Neighboring BSs/APs','Location','southEast')