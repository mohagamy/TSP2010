function WSNo = NodeSelection(WSN)
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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