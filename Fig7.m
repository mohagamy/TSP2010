% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Fig 7 : Average number of trials E {T} versus threshold eta_thr: M = 512,
% N = 256, phi_0 = 0^o, and phi_1 = 65^o. 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.



clear;clc;
L = [16 32 64 128];     
INRthr=10.^([0:5:30]./10);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

tic
for Lcntr = 1 : length(L)
    for INRcntr = 1:length(INRthr)
        for cntr = 1 : 10
            
            GeneralWSN
            WSN.L = L(Lcntr);
            WSN.INRthr = INRthr(INRcntr);
            
            WSN = UniformWSN(WSN);
            WSN.ChannelGain = exp(sqrt(WSN.v)*randn(length(WSN.phi),WSN.M));
            
            
            WSN = NodeSelection(WSN);
            NoOfTrials(Lcntr,INRcntr,cntr) = WSN.NoOfTrials;
            
            [Lcntr INRcntr  toc]
            
        end
    end
end

AveNoItr = mean(NoOfTrials,3);
p = 1- exp(-(( WSN.NoisePower*INRthr ))./(2*WSN.vX*ones(1,length(INRthr)))) ;
LL = L'*ones(1,length(INRthr));
pp = ones(length(L),1)*p;
AveNoItrExpression = WSN.N./(LL.*pp);



figure
hold on
grid on
box('on');
xlabel('\eta_{thr} [dB]');
ylabel('Average Number of Iterations E\{T\}');
plot(10*log10(INRthr),AveNoItr(1,:),'xk','LineWidth',1);
plot(10*log10(INRthr),AveNoItrExpression(1,:),'k','LineWidth',1)
legend('Simulations','Analytical Expression');
plot(10*log10(INRthr),AveNoItr,'xk','LineWidth',1);
plot(10*log10(INRthr),AveNoItrExpression,'k','LineWidth',1)