% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe Control in Collaborative
% Beamforming via Node Selection," submitted to the IEEE Trans. Signal
% Processing.
% Fig 7 : Ave. No. of Trials - Ave. Interference  (for different L values)
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
clear;clc;
L = [16 32 64 128];     %increment in the number of sensors
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
legend('Simulations','Analatical Expression');
plot(10*log10(INRthr),AveNoItr,'xk','LineWidth',1);
plot(10*log10(INRthr),AveNoItrExpression,'k','LineWidth',1)