% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Fig 3 : Beampattern: The intended BS/AP is located at phi_0 = 0^o and 4
% unintended BSs/APs at directions phi_1 = -140^o, phi_2 = -70^o, phi_3 =
% 70^o, and phi_4 = 140^o: M = 512, N = 256, L = 32, and eta_thr = 10 dB. 
% Fig 4 : Beampattern: Multi-link beampatterns with BSs/APs at directions
% phi_0 = 0^o, phi_1 = -140^o, phi_2 = -70^o, phi_3 = 70^o, and phi_4 =
% 140^o: M = 512, N = 256, L = 32, and eta_thr = 10 dB.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.


clear;clc;
GeneralWSN
WSN = UniformWSN(WSN);
WSN.APsDirections = [0   -140   -70    70   140];
WSN.K = length(WSN.APsDirections) - 1;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.ChannelGain = ones(length(WSN.phi),WSN.M);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [1];
WSN.UnTargetedAP = [2 3 4 5];
WSN1 = NodeSelection(WSN);
BP1 = BeamPattern(WSN1);
1
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [2];
WSN.UnTargetedAP = [1 3 4 5];
WSN2 = NodeSelection(WSN);
BP2 = BeamPattern(WSN2);
2
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [3];
WSN.UnTargetedAP = [2 1 4 5];
WSN3 = NodeSelection(WSN);
BP3 = BeamPattern(WSN3);
3
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [4];
WSN.UnTargetedAP = [2 3 1 5];
WSN4 = NodeSelection(WSN);
BP4 = BeamPattern(WSN4);
4
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [5];
WSN.UnTargetedAP = [2 3 4 1];
WSN5 = NodeSelection(WSN);
BP5 = BeamPattern(WSN5);
5

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% No Node Selection
WSN.TargetedAP = [1];
WSN.UnTargetedAP = [2 3 4 5];
WSN6 = WSN;
WSN6.Index = 1:WSN.N;
BP6 = BeamPattern(WSN6);
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
ylabel('Power/\sigma_w^2 [dB]');
box('on');
grid('on');
hold('all');
plot(WSN.phi,10*log10(abs(WSN.N*WSN.SNR*BPequation)),'-.k')
plot(WSN.phi,10*log10(abs(BP1./WSN.NoisePower)),'-k')
plot(WSN.phi,10*log10(abs(BP6./WSN.NoisePower)),'--k')
plot(WSN.APsDirections,30,'xk')
legend('Average Beampattern','Sample Beampattern (With Node Selection)','Sample Beampattern (Without Node Selection)','Directions of the BSs/APs','Location','SouthEast');

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

plot(WSN.phi,10*log10(WSN.SNR)*ones(1,length(WSN.phi)),'k')
plot(WSN.APsDirections,30,'xk')
legend('Average Beampattern Value (Without Node Selection)','Directions of the BSs/APs','Location','SouthEast')
plot(WSN.phi,10*log10(abs(BP1./WSN.NoisePower)),'k-')
plot(WSN.phi,10*log10(abs(BP2./WSN.NoisePower)),'k-')
plot(WSN.phi,10*log10(abs(BP3./WSN.NoisePower)),'k-')
plot(WSN.phi,10*log10(abs(BP4./WSN.NoisePower)),'k-')
plot(WSN.phi,10*log10(abs(BP5./WSN.NoisePower)),'k-')