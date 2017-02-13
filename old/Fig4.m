% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe Control in Collaborative
% Beamforming via Node Selection," submitted to the IEEE Trans. Signal
% Processing.
% Fig 4 :
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% WSN   : Data structure.
% WSN.M : Number of sensor nodes.
% WSN.R : Cluster radius.
% WSN.x : x coordinates of the sensor node locations.
% WSN.y : y coordinates of the sensor node locations.
% WSN.N :
% WSN.L :
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% WSN Parameter Set-up
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
clear;clc;
WSN.R = 2;
WSN.M = 512;
WSN.N = 256;
WSN.L = 32;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.Index = 1:WSN.M;
WSN = UniformWSN(WSN);
WSN.APsDirections = [0 -160   -50   60   170]*pi/180;
WSN.K = length(WSN.APsDirections) - 1;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.SNR = 10^(20/10);
WSN.INRthr = 10.^(10./10)*ones(1,WSN.K);
WSN.NoisePower = 0.05;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.phi = (-180:180)*pi/180;
WSN.ChannelGain = ones(length(WSN.phi),WSN.M);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [1];
WSN.UnTargetedAP = [2 3 4 5];
WSN0 = NodeSelection(WSN);
WSN0.Wmax = sqrt((WSN.SNR*WSN.NoisePower)/WSN.N);
BP0 = BeamPattern(WSN0);
1
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [2];
WSN.UnTargetedAP = [1 3 4 5];
WSN1 = NodeSelection(WSN);
WSN1.Wmax = sqrt((WSN.SNR*WSN.NoisePower)/WSN.N);
BP1 = BeamPattern(WSN1);
2
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [3];
WSN.UnTargetedAP = [2 1 4 5];
WSN2 = NodeSelection(WSN);
WSN2.Wmax = sqrt((WSN.SNR*WSN.NoisePower)/WSN.N);
BP2 = BeamPattern(WSN2);
3
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [4];
WSN.UnTargetedAP = [2 3 1 5];
WSN3 = NodeSelection(WSN);
WSN3.Wmax = sqrt((WSN.SNR*WSN.NoisePower)/WSN.N);
BP3 = BeamPattern(WSN3);
4
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [5];
WSN.UnTargetedAP = [2 3 4 1];
WSN4 = NodeSelection(WSN);
WSN4.Wmax = sqrt((WSN.SNR*WSN.NoisePower)/WSN.N);
BP4 = BeamPattern(WSN4);
5


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
plot(WSN.APsDirections*180/pi,30*ones(1,length(WSN.APsDirections)),'xk')
plot(WSN.phi*180/pi,10*log10(WSN.SNR)*ones(1,length(WSN.phi)),'k')
legend('Directions of BSs/APs','Average Beampattern Value (Without Node Selection)','Location','SouthEast')
plot(WSN.phi*180/pi,10*log10(abs(BP0./WSN.NoisePower)),'k-')
plot(WSN.phi*180/pi,10*log10(abs(BP1./WSN.NoisePower)),'k-')
plot(WSN.phi*180/pi,10*log10(abs(BP2./WSN.NoisePower)),'k-')
plot(WSN.phi*180/pi,10*log10(abs(BP3./WSN.NoisePower)),'k-')
plot(WSN.phi*180/pi,10*log10(abs(BP4./WSN.NoisePower)),'k-')

