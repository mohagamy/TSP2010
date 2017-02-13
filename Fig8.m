% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Fig 8 : Average number of trials E {T} versus threshold ?thr for
% different values of D: M = 512, N = 256, L = 32, and phi_0 = 0o. 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.



clear;clc;
APsDirections = [0   -140   -70    70   140];
INRthr = 10.^((10:5:30)./10);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


tic
for K = 1 : length(APsDirections)-1
    for INRcntr = 1:length(INRthr)
        
        
        for itr = 1 : 5
            GeneralWSN
            WSN = UniformWSN(WSN);
            WSN.ChannelGain = exp(sqrt(WSN.v)*randn(length(WSN.phi),WSN.M));
            WSN.INRthr = INRthr(INRcntr);
            WSN.APsDirections = [APsDirections(1:K+1)];
            WSN.K = length(WSN.APsDirections) - 1;
            WSN.TargetedAP = [1];
            WSN.UnTargetedAP = [2:K+1];
            WSN = NodeSelection(WSN);
            NoOfTrials(K,INRcntr,itr) = WSN.NoOfTrials;
            
            [K INRcntr itr]
        end
    end
    
end

AveNoItr = mean(NoOfTrials,3);


for D = 1:length(APsDirections)-1
    p(D,:)=(1-exp(-(WSN.NoisePower*INRthr)./(2*WSN.vX) )).^D;
end

NoItr = WSN.N./(WSN.L*p);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
figure
hold on
grid on
box('on');
xlabel('\eta_{thr} [dB]');
ylabel('Average Number of Iterations E\{t\}');
plot(10*log10(INRthr),NoItr','k');
plot(10*log10(INRthr),AveNoItr','ko');
