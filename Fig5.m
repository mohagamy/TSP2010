% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Fig 5 : Beampattern: The interference is limited in the range phi \in
% [25^o 45^o]: M = 512, N = 256, L = 32, phi_0 = 0^o, and eta_thr = 10 dB. 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.


clear;clc;
GeneralWSN
WSN = UniformWSN(WSN);
WSN.APsDirections = [0 25:45];
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
plot(WSN.APsDirections(2:5:end),30,'xk')
legend('Average Beampattern','Sample Beampattern (With Node Selection)','Limited Interference Range','Location','SouthEast')