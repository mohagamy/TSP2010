% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe Control in Collaborative
% Beamforming via Node Selection," submitted to the IEEE Trans. Signal
% Processing.
% Fig 11 :
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
WSN.R = 5;
WSN.M = 512;
WSN.N = 256;
WSN.L = 32;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.APsDirections = [0 120]*pi/180;
WSN.K = length(WSN.APsDirections) - 1;
WSN.phi = (-180:180)*pi/180;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.SNR = 10^(20/10);
INRthr = 10.^((10:10:40)./10);
WSN.NoisePower = 0.05;
WSN.Wmax = sqrt(WSN.NoisePower*WSN.SNR/WSN.N);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.vx = 0.5;
WSN.mx = 0;

WSN.v  = 0.2;
WSN.m = 0;

WSN.ma = exp(WSN.m+(WSN.v/2));
WSN.va = (exp(WSN.v)-1)*(exp(2*WSN.m+WSN.v));

WSN.vX = WSN.NoisePower*WSN.SNR*((WSN.vx + WSN.mx^2)*(WSN.va + WSN.ma^2) - WSN.mx^2*WSN.ma^2);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


for cntr = 1:length(INRthr)
    
    WSN.INRthr = INRthr(cntr);
    beta(cntr) = (WSN.NoisePower*WSN.INRthr)/(2*WSN.vX);
    vI(cntr) = (  WSN.vX*(1-(1+beta(cntr)).*exp(-beta(cntr)))  )./ ((1-exp(-beta(cntr))) ) ;
    
    % - - - - - - - - - - - - single-link - - - - - - - - - - - - - - - - -
    S_SL(cntr) = (WSN.K+1)*WSN.SNR*WSN.NoisePower*(WSN.va + ((WSN.K+1)*WSN.N)*WSN.ma^2);
    S_ML(cntr) = WSN.SNR*WSN.NoisePower*(WSN.va + WSN.N*WSN.ma^2);
    % - - - - - - - - - - - - multi-link (Node selection) - - - - - - - - -
    %I_ns(cntr) =  WSN.K*(2*vI(cntr))^2 + (WSN.K*2*vI(cntr))^2 ;
    I_ns(cntr) =  2*WSN.K*vI(cntr) ;
    % - - - - - - - - - - - - multi-link  (No Node selection) - - - - - - -
    I(cntr) =  2*WSN.K*WSN.vX ;
    
end



% figure
% hold on
% grid on
% box('on');
% xlabel('\eta_{thr} [dB]');
% 
% plot(10*log10(INRthr),10*log10(S_SL),'g')
% plot(10*log10(INRthr),10*log10(S_SL_sim),'go')
% 
% plot(10*log10(INRthr),10*log10(S_ML),'b--')
% plot(10*log10(INRthr),10*log10(S_ML_sim),'bo')
% 
% 
% plot(10*log10(INRthr),10*log10(I),'k')
% plot(10*log10(INRthr),10*log10(I_sim),'ko')
% 
% plot(10*log10(INRthr),10*log10(I_ns),'r--')
% plot(10*log10(INRthr),10*log10(I_ns_sim),'ro')


%- - - - - - - - - - - - - - - - - SIMULATIONS - - - - - - - - - - - - -


for INRcntr = 1 : length(INRthr)
    for cntr = 1 : 10
        
        
        % - - - - - - - - - - - - Signal SL (No Node selection) - - - - - -
        GeneralWSN
        WSNs = WSN;
        WSNs.TargetedAP = [1];
        WSNs.UnTargetedAP = [2];
        WSNs.M = (WSNs.K+1)*WSNs.N;
        WSNs = UniformWSN(WSNs);
        WSNs.ChannelGain = exp(sqrt(WSNs.v)*randn(length(WSNs.phi),WSNs.M));
        WSNs.Index = 1:WSNs.M;
        WSNs.phi = (WSNs.APsDirections(WSNs.TargetedAP))*pi/180;
        S_SL_sim_(cntr) = BeamPattern(WSNs);
        
        % - - - - - - - - - - - - Signal ML - - - - - - - - - - - - - - - -
        GeneralWSN
        WSNs = WSN;
        WSNs.INRthr = INRthr(INRcntr);
        WSNs.TargetedAP = [1];
        WSNs.UnTargetedAP = [2];
        WSNs = UniformWSN(WSNs);
        WSNs.ChannelGain = exp(sqrt(WSNs.v)*randn(length(WSNs.phi),WSNs.M));
        WSNs = NodeSelection(WSNs);
        WSNs.phi = (WSNs.APsDirections(WSNs.TargetedAP))*pi/180;
        S_ML_sim_(cntr) = BeamPattern(WSNs);
        
        
        % - - - - - - - - - - - - Interference ML(No Node selection) - - - - - - - - -
        GeneralWSN
        WSNi = WSN;
        WSNi.INRthr = INRthr(INRcntr);
        WSNi.TargetedAP = [2];
        WSNi.UnTargetedAP = [1];
        WSNi = UniformWSN(WSNi);
        WSNi.ChannelGain = exp(sqrt(WSNi.v)*randn(length(WSNi.phi),WSNi.M));
        Indx = randperm(WSNi.M);
        WSNi.Index = (Indx(1:WSNi.N));
        WSNi.phi = (WSNi.APsDirections(WSNi.UnTargetedAP))*pi/180;
        I_sim_(cntr) = BeamPattern(WSNi);
        
        % - - - - - - - - - - - - Interference ML (Node selection) - - - -
        GeneralWSN
        WSNi = WSN;
        WSNi.INRthr = INRthr(INRcntr);
        WSNi.TargetedAP = [2];
        WSNi.UnTargetedAP = [1];
        WSNi = UniformWSN(WSNi);
        WSNi.ChannelGain = exp(sqrt(WSNi.v)*randn(length(WSNi.phi),WSNi.M));
        WSNi = NodeSelection(WSNi);
        WSNi.phi = (WSNi.APsDirections(WSNi.UnTargetedAP))*pi/180;
        I_ns_sim_(cntr) = BeamPattern(WSNi);
        
        
        
        [INRcntr cntr]
        
    end
    
    S_ML_sim(INRcntr) = mean(S_ML_sim_);
    I_sim(INRcntr) = mean(I_sim_);
    I_ns_sim(INRcntr) = mean(I_ns_sim_);
    S_SL_sim(INRcntr)= mean(S_SL_sim_);
end




figure
hold on
grid on
box('on');
xlabel('\eta_{thr} [dB]');

plot(10*log10(INRthr),10*log10(S_SL),'g')
plot(10*log10(INRthr),10*log10(S_SL_sim),'go')

plot(10*log10(INRthr),10*log10(S_ML),'b--')
plot(10*log10(INRthr),10*log10(S_ML_sim),'bo')


plot(10*log10(INRthr),10*log10(I),'k')
plot(10*log10(INRthr),10*log10(I_sim),'ko')

plot(10*log10(INRthr),10*log10(I_ns),'r--')
plot(10*log10(INRthr),10*log10(I_ns_sim),'ro')
