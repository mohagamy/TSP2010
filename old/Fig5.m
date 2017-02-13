% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe Control in Collaborative
% Beamforming via Node Selection," submitted to the IEEE Trans. Signal
% Processing.
% Fig 5 :
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
WSN.APsDirections = [0 25:45]*pi/180;
WSN.K = length(WSN.APsDirections) - 1;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.SNR = 10^(20/10);
WSN.INRthr = 10.^(20./10)*ones(1,WSN.K);
WSN.NoisePower = 0.05;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.phi = (-180:180)*pi/180;
WSN.ChannelGain = ones(length(WSN.phi),WSN.M);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.TargetedAP = [1];
WSN.UnTargetedAP = [2:length(WSN.APsDirections)];
WSN1 = NodeSelection(WSN);
WSN1.Wmax = sqrt((WSN.SNR*WSN.NoisePower)/WSN.N);
BP1 = BeamPattern(WSN1);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%Equation
[BPu,BPg]=BeamPatternUsingEquation(WSN);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
figure1 = figure;
%% Create axes
axes1 = axes('XTick',[-180 -120 -60 0 60 120 180],'Parent',figure1);
xlim(axes1,[-180 180]);
xlabel('Angle \WSN.phi [degree]');
ylabel('Power [dB]');
box('on');
grid('on');
hold('all');
plot(WSN.phi*180/pi,10*log10(abs(WSN.N*WSN.SNR*BPu)),'-.k')
plot(WSN.phi*180/pi,10*log10(abs(BP1./WSN.NoisePower)),'-k')
plot(BS_AP*180/pi,10*log10(abs(WSN.N*WSN.SNR)),'xk')
legend('Average Beampattern','Beampattern - With Node Selection','Directions of Neighboring BSs/APs','Location','NorthEast')
xlabel('Angle \phi [degree]')
ylabel('Power [dB]')