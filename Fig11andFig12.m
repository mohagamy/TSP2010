% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Fig 11 : The SNR of the single-link CB and the SINR of the multi-link CBs
% with and without node selection for different values of K: M = 512, N =
% 256, L = 32, and phi_0 = 0^o.
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Fig 12 : The transmission rate of the single- and multi-link CBs with and
% without node selection for different values of K: M = 512, N = 256, L =
% 32, and phi_0 = 0^o. 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.



clear;clc;
GeneralWSN
INRthr = 10.^((10:40)./10);
APsDirections = [0    -90     90   180];


for K = 1:length(APsDirections) - 1
    for INRcntr = 1:length(INRthr)
        
        WSN.APsDirections = [APsDirections(1:K+1)];
        WSN.K = length(WSN.APsDirections) - 1;
        WSN.INRthr = INRthr(INRcntr);
        WSN.beta = (WSN.NoisePower*WSN.INRthr)/(2*WSN.vX);
        WSN.vI = (  WSN.vX*(1-(1+WSN.beta).*exp(-WSN.beta))  )./ ((1-exp(-WSN.beta)) ) ;
        WSN.vINR = (  WSN.vX*(1-(1+WSN.beta).*exp(-WSN.beta))  )./ (WSN.NoisePower*(1-exp(-WSN.beta)) ) ;
        
        % - - - - - - - - - - - - SIGNAL - - - - - - - - - - - - - - - - -
        S_SL(K,INRcntr) = WSN.SNR*WSN.NoisePower*((WSN.K+1)*WSN.va + (((WSN.K+1)^2)*WSN.N)*WSN.ma^2);
        S_ML(K,INRcntr) = WSN.SNR*WSN.NoisePower*(WSN.va + WSN.N*WSN.ma^2);
        % - - - - - - - - - - - - INTERFERENCE - - - - - - - - - - - - - - - -
        I_ns(K,INRcntr) =  WSN.K*(2*WSN.vI);
        I(K,INRcntr) =  WSN.K*(2*WSN.vX);
        % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
    end
end



%- - - - - - - - - - - - - - - - - SIMULATIONS - - - - - - - - -
INRthr = 10.^((10:5:40)./10);


for K = 1:length(APsDirections) - 1
    for INRcntr = 1:length(INRthr)
        
        
        
        for itr = 1 : 100
            
            % - - - - - - - - - - - - SL SIGNAL - - - - - - - - - - - - - - - -
            GeneralWSN
            WSN.M = (K+1)*WSN.N;
            WSN = UniformWSN(WSN);
            WSN.ChannelGain = exp(sqrt(WSN.v)*randn(length(WSN.phi),WSN.M));
            WSN.Index = 1:WSN.M;
            clear BPi
            BPi = BeamPattern(WSN);
            ii = find( WSN.phi == WSN.APsDirections(WSN.TargetedAP));
            S_SL_sim_(K,INRcntr,itr) = BPi(ii);
            % - - - - - - - - - - - - ML SIGNAL - - - - - - - - - - - - - - - -
            GeneralWSN
            WSN = UniformWSN(WSN);
            WSN.ChannelGain = exp(sqrt(WSN.v)*randn(length(WSN.phi),WSN.M));
            WSN.Index = 1:WSN.N;
            clear BPi
            BPi = BeamPattern(WSN);
            ii = find( WSN.phi == WSN.APsDirections(WSN.TargetedAP));
            S_ML_sim_(K,INRcntr,itr) = BPi(ii);
            
            
            % - - - - - - - - - - - - INTERFERENCE (No Node selection) - - - -
            
            for k = 1:K
                GeneralWSN
                WSN.ChannelGain = exp(sqrt(WSN.v)*randn(length(WSN.phi),WSN.M));
                WSN = UniformWSN(WSN);
                
                WSN.APsDirections = [APsDirections(1:K+1)];
                WSN.K = length(WSN.APsDirections) - 1;
                WSN.TargetedAP = [k+1];
                WSN.UnTargetedAP = [1:k k+2:K+1];
                WSN.Index = 1:WSN.N;
                clear BPi
                BPi = BeamPattern(WSN);
                
                ii = find( WSN.phi == (WSN.APsDirections(1)));
                BP(k) = BPi(ii);
            end
            
            I_sim_(K,INRcntr,itr) = sum(BP);
            
            
            % - - - - - - - - - - - - INTERFERENCE (Node selection) - - - -
            
            
            for k = 1:K
                GeneralWSN
                WSN.INRthr = INRthr(INRcntr);
                WSN.ChannelGain = exp(sqrt(WSN.v)*randn(length(WSN.phi),WSN.M));
                WSN = UniformWSN(WSN);
                
                WSN.APsDirections = [APsDirections(1:K+1)];
                WSN.K = length(WSN.APsDirections) - 1;
                WSN.TargetedAP = [k+1];
                WSN.UnTargetedAP = [1:k k+2:K+1];
                WSN = NodeSelection(WSN);
                clear BPi
                BPi = BeamPattern(WSN);
                
                ii = find( WSN.phi == (WSN.APsDirections(1)));
                BP(k) = BPi(ii);
            end
            
            I_ns_sim_(K,INRcntr,itr)=sum(BP);
            
            
            [K INRcntr itr]
            
            
        end
        
        
        
        
    end
    
    
    
    
end


S_SL_sim = mean(S_SL_sim_,3);
S_ML_sim = mean(S_ML_sim_,3);
I_sim = mean(I_sim_,3);
I_ns_sim = mean(I_ns_sim_,3);

% - - - - - - - - - - - - Transmission Rate - - - - - - - - - - -
         

T_SL = log2(1+ S_SL./WSN.NoisePower);
T_SL_sim = log2(1+ S_SL_sim./WSN.NoisePower);


for K = 1:length(APsDirections) - 1
    
    WSN.APsDirections = [APsDirections(1:K+1)];
    WSN.K = length(WSN.APsDirections) - 1;
    
    
    T_ML(K,:) = (WSN.K+1)*log2(1+ S_ML(K,:)./(I(K,:)+WSN.NoisePower));
    T_ML_ns(K,:) = (WSN.K+1)*log2(1+ S_ML(K,:)./(I_ns(K,:)+WSN.NoisePower));
    T_ML_sim(K,:) = (WSN.K+1)*log2(1+ S_ML_sim(K,:)./(I_sim(K,:)+WSN.NoisePower));
    T_ML_ns_sim(K,:) = (WSN.K+1)*log2(1+ S_ML_sim(K,:)./(I_ns_sim(K,:)+WSN.NoisePower));
    
end




% - - - - - - - - - - - - - - - - - SINR - - - - - - - - - - - - - - - - -

SNR_SL = S_SL./WSN.NoisePower;
SNR_SL_sim = S_SL_sim./WSN.NoisePower;
    
for K = 1:length(APsDirections) - 1
    
    WSN.APsDirections = [APsDirections(1:K+1)];
    WSN.K = length(WSN.APsDirections) - 1;
    
    
    SINR_ML(K,:) = S_ML(K,:)./(I(K,:)+WSN.NoisePower);
    SINR_ML_ns(K,:) = S_ML(K,:)./(I_ns(K,:)+WSN.NoisePower);
    SINR_ML_sim(K,:) = S_ML_sim(K,:)./(I_sim(K,:)+WSN.NoisePower);
    SINR_ML_ns_sim(K,:) = S_ML_sim(K,:)./(I_ns_sim(K,:)+WSN.NoisePower);
    
end





% - - - - - - - - - - - - SINR/SNR - - - - - - - - - - -    
figure
hold on
grid on
box('on');
xlabel('\eta_{thr} [dB]');
ylabel('SINR/SNR [dB]');

INRthr = 10.^((10:40)./10);
plot(10*log10(INRthr),10*log10(SNR_SL(1,:)),'k--')
plot(10*log10(INRthr),10*log10(SINR_ML(1,:)),'k-.')
plot(10*log10(INRthr),10*log10(SINR_ML_ns(1,:)),'k')
legend('Single-link CB','Multi-link CB (Without Node Selection)','Multi-link CB (With Node Selection)','Location','NorthEast')

INRthr = 10.^((10:40)./10);
plot(10*log10(INRthr),10*log10(SNR_SL),'k--')
plot(10*log10(INRthr),10*log10(SINR_ML),'k-.')
plot(10*log10(INRthr),10*log10(SINR_ML_ns),'k')
INRthr = 10.^((10:5:40)./10);
plot(10*log10(INRthr),10*log10(SNR_SL_sim),'kx')
plot(10*log10(INRthr),10*log10(SINR_ML_sim),'ko')
plot(10*log10(INRthr),10*log10(SINR_ML_ns_sim),'kd')




% - - - - - - - - - - - - Transmission Rate - - - - - - - - - - -
figure
hold on
grid on
box('on');
xlabel('\eta_{thr} [dB]');
ylabel('Rate [bits/sec/Hz]');
ylim([11 17]);


INRthr = 10.^((10:40)./10);
plot(10*log10(INRthr),10*log10(T_SL(1,:)),'k--')
plot(10*log10(INRthr),10*log10(T_ML(1,:)),'k-.')
plot(10*log10(INRthr),10*log10(T_ML_ns(1,:)),'k')
legend('Single-link CB','Multi-link CB (Without Node Selection)','Multi-link CB (With Node Selection)','Location','NorthEast')


INRthr = 10.^((10:40)./10);
plot(10*log10(INRthr),10*log10(T_SL),'k--')
plot(10*log10(INRthr),10*log10(T_ML),'k-.')
plot(10*log10(INRthr),10*log10(T_ML_ns),'k')
INRthr = 10.^((10:5:40)./10);
plot(10*log10(INRthr),10*log10(T_SL_sim),'kx')
plot(10*log10(INRthr),10*log10(T_ML_sim),'ko')
plot(10*log10(INRthr),10*log10(T_ML_ns_sim),'kd')