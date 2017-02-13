% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe Control in Collaborative
% Beamforming via Node Selection," submitted to the IEEE Trans. Signal
% Processing.
% Fig 10 : EQ28 - Erlang Dist of INR - K BSs/APs
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
APsDirections = [0 -160  170]*pi/180;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

for K = 1:length(APsDirections) - 1
    
    tic
    
    for itr=1:100
        
        for k = 1:K
            GeneralWSN
            WSN.ChannelGain = exp(sqrt(WSN.v)*randn(length(WSN.phi),WSN.M));
            WSN = UniformWSN(WSN);
            
            WSN.APsDirections = [APsDirections(1:K+1)];
            WSN.K = length(WSN.APsDirections) - 1;
            WSN.TargetedAP = [k+1];
            WSN.UnTargetedAP = [1:k k+2:K+1];
            WSN = NodeSelection(WSN);
            
            BP_ = BeamPattern(WSN);
            
            I = find( WSN.phi == (WSN.APsDirections(1)));
            BP(k) = BP_(I);
            [K itr k toc]
        end
        
        INR(K,itr)=sum(BP)/WSN.NoisePower;
        
    end
    
    [INR_sim(K,:),CCDF_sim(K,:)] = myccdf(INR(K,:));
    
end



for K = 1:length(APsDirections) - 1
    
    CCDF_(K,:)=((((alpha*DataValues(k,:))).^(K-1)).*exp(-alpha*DataValues(k,:)))./(factorial(K-1));
end

if k==1
    CCDF(k,:)=CCDF_;
else
    CCDF(k,:)=sum(CCDF_);
end




figure
hold on
box('on');
grid on
xlabel('INR \eta [dB]');
ylabel('CCDF');


plot(10*log10(INR_sim'),CCDF_sim','x','LineWidth',1)
plot(10*log10(INR),Pr','-.','LineWidth',1)
%plot(10*log10(x_'),Pr','-.','LineWidth',1)

legend('Simulations','Analatical');


% for cntr=1:K
%     plot(10*log10(xCCDF(cntr,1:40:end)),yCCDF(cntr,1:40:end),'kx','LineWidth',1)
%     plot(10*log10(x_(cntr,:)),Pr(cntr,:),'k-.','LineWidth',1)
% end
% legend('Simulations','Analatical');
