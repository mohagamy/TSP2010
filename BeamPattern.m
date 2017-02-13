function BP = BeamPattern(WSN)
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Finds the beampattern of the collaborative sensor nodes.
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Input(s):
% WSN.Wmax
% WSN.x
% WSN.y
% WSN.ChannelGain
% WSN.Index
% WSN.phi
% WSN.APsDirections
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Output(s):
% BP
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.



Wmax = WSN.Wmax;
x = WSN.x;
y = WSN.y;
a = WSN.ChannelGain;
Index = WSN.Index;
phi = WSN.phi*pi/180;
DirectionOfTargetedAP = WSN.APsDirections(WSN.TargetedAP)*pi/180;

w = Wmax*ones(1,WSN.M);

AF = zeros(1,length(phi));

s0 = [ cos(DirectionOfTargetedAP);    sin(DirectionOfTargetedAP)   ]';

for cntr=1:length(phi)
    
    s = [cos(phi(cntr));         sin(phi(cntr))        ]';
    
    S = exp(...
        (1i*2*pi*(s*[...
        (x(Index)); ...
        (y(Index))])) - ...
        (1i*2*pi*(s0*[...
        x(Index);...
        y(Index)])) );
    
    S = S(:);
    
    AF(cntr) = (w(Index).*a(cntr,Index))*S;
    
end

BP=(abs(AF)).^2;
