% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe Control in Collaborative
% Beamforming via Node Selection," submitted to the IEEE Trans. Signal
% Processing.
% Fig 8 : Average Number of Trials  (D BSs/APs)
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
APsDirections = [0 -140  -70  70   140]*pi/180;
INRthr = 10.^((0:5:30)./10);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


tic
for k = 1 : length(APsDirections)-1
    for INRcntr = 1:length(INRthr)
        
        
        for cntr = 1 : 5
            GeneralWSN
            WSN = UniformWSN(WSN);
            WSN.ChannelGain = exp(sqrt(WSN.v)*randn(length(WSN.phi),WSN.M));
            WSN.INRthr = INRthr(INRcntr);
            WSN.APsDirections = [APsDirections(1:k+1)];
            WSN.K = length(WSN.APsDirections) - 1;
            WSN.TargetedAP = [1];
            WSN.UnTargetedAP = [2:k+1];
            WSN = NodeSelection(WSN);
            NoOfTrials(k,INRcntr,cntr) = WSN.NoOfTrials;
            
            cntr
        end
    end
    [k toc]
end

AveNoItr = mean(NoOfTrials,3);


for D = 1:length(APsDirections)-1
    p(D,:)=(1-exp(-(WSN.NoisePower*INRthr)./(2*WSN.vX) )).^D;
end

NoItr = WSN.N./(WSN.L*p);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
grid on
box('on');
xlabel('\eta_{thr} [dB]');
ylabel('Average Number of Iterations E\{t\}');
plot(10*log10(INRthr),NoItr','k');
plot(10*log10(INRthr),AveNoItr','ko');
