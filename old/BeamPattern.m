function BP = BeamPattern(WSN)
%
% General beam pattern
% BP: The beampattern



Wmax = WSN.Wmax;
x = WSN.x;
y = WSN.y;
a = WSN.ChannelGain;
Index = WSN.Index;
phi = WSN.phi;

DirectionOfTargetedAP = WSN.APsDirections(WSN.TargetedAP);

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
