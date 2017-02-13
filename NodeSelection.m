function WSNo = NodeSelection(WSN)
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Selects a subset of WSN.N collaborative nodes from the WSN.M nodes in the
% coverage area of each source node. The size of one group of nodes to be
% tested in each trial is WSN.L. 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Input(s):
% WSN.SNR
% WSN.INRthr
% WSN.NoisePower
% WSN.M
% WSN.N
% WSN.L
% WSN.K
% WSN.phi
% WSN.APsDirections
% WSN.TargetedAP
% WSN.UnTargetedAP
% WSN.ChannelGain
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Output(s):
% WSN.Index
% WSN.NoOfTrials
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.


WSNo = WSN;
WSN.Wmax = sqrt((WSN.SNR*WSN.NoisePower)/WSN.L);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for i = 1 : WSN.K
    I = find( WSN.phi == WSN.APsDirections(WSN.UnTargetedAP(i)));
    TempChannelGain(i,:) = WSN.ChannelGain(I,:);
end
WSN.ChannelGain = TempChannelGain;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSN.phi = WSN.APsDirections(WSN.UnTargetedAP);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cntr = 1;
NoOfTrials = 0;
Flage = ones(1,WSN.M);
I = [];
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
while cntr <= (WSN.N/WSN.L)

    Ii = find(Flage == 1);
    IIi=randperm(length(Ii));
    WSN.Index = Ii(IIi(1:WSN.L));
    
        BP = BeamPattern(WSN);
    
    INRi= BP./WSN.NoisePower;
    
    if sum(INRi < WSN.INRthr) == length(INRi)
        I = [I WSN.Index];
        Flage(WSN.Index) = 0;
        cntr=cntr+1;
    end
    
    NoOfTrials = NoOfTrials + 1;

end
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
WSNo.Index = I;
WSNo.NoOfTrials = NoOfTrials;