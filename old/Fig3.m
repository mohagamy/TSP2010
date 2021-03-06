% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe Control in Collaborative
% Beamforming via Node Selection," submitted to the IEEE Trans. Signal
% Processing.
% Fig 3 :
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
GeneralWSN
WSN.R = 2;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.Index = 1:WSN.M;
WSN = UniformWSN(WSN);
WSN.ChannelGain = ones(length(WSN.phi),WSN.M);
WSN.APsDirections = [0 -160   -50   60   170]*pi/180;
WSN.TargetedAP = [1];
WSN.UnTargetedAP = [2 3 4 5];
WSN.K = length(WSN.APsDirections) - 1;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Node Selection
WSN1 = NodeSelection(WSN);
WSN1.Wmax = sqrt((WSN1.SNR*WSN1.NoisePower)/WSN1.N);
BP1 = BeamPattern(WSN1);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% No Node Selection
WSN2 = WSN;
WSN2.Index = 1:WSN.N;
WSN2.Wmax = sqrt((WSN2.SNR*WSN2.NoisePower)/WSN2.N);
BP2 = BeamPattern(WSN2);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%Equation
[BPu,BPg]=BeamPatternUsingEquation(WSN);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
figure1 = figure;
%% Create axes
axes1 = axes('XTick',[-180 -120 -60 0 60 120 180],'Parent',figure1);
xlim(axes1,[-180 180]);
xlabel('Angle \phi [degree]');
ylabel('Power/\sigma_w^2 [dB]');
box('on');
grid('on');
hold('all');
plot(WSN.phi*180/pi,10*log10(abs(WSN.N*WSN.SNR*BPu)),'-.k')
plot(WSN.phi*180/pi,10*log10(abs(BP1./WSN.NoisePower)),'-r')
plot(WSN.phi*180/pi,10*log10(abs(BP2./WSN.NoisePower)),'--k')
plot(WSN.APsDirections*180/pi,30,'xk')
legend('Average Beampattern','Beampattern - With Node Selection','Beampattern - Without Node Selection','Directions of Neighboring BSs/APs','Location','NorthEast');