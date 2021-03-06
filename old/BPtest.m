% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe Control in Collaborative
% Beamforming via Node Selection," submitted to the IEEE Trans. Signal
% Processing.
% Fig 9 : Eq 28 Expon. Dist. of INR - K = 1 BSs/APs
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
tic

INRthr = 10.^([10 20]/10);

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

tic

for INRcntr=1:length(INRthr)
    for itr = 1:50
        
        GeneralWSN
        WSN.INRthr = INRthr(INRcntr);
        WSN = UniformWSN(WSN);
        WSN.ChannelGain = exp(sqrt(WSN.v)*randn(length(WSN.phi),WSN.M));
        
        WSN = NodeSelection(WSN);
  %      WSN.phi = WSN.APsDirections;
        BP = BeamPattern(WSN);
        
        INR_sim_(itr,:) = BP./WSN.NoisePower;
        itr
    end
    
    INR_sim(INRcntr,:) = mean(INR_sim_);
end

figure
hold on
box('on');
grid on
plot(WSN.phi*180./pi,10*log10(INR_sim))
