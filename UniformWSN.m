function WSN = UniformWSN(WSN)
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative
% beamforming via node selection," IEEE Trans. Signal Processing, accepted
% 2010.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Generats a sensor nodes coordinates in 2D plan. The sensor nodes are
% scattered over a disk of radius R. The coordinates are WSN.x and WSN.y
% and follow a Uniform spatial distribution.  
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Input(s):
% WSN.M
% WSN.R
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Output(s):
% WSN.x
% WSN.y
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Copyright (c) 2010 Mohammed Ahmed and Sergiy Vorobyov
% Email: {mfahmed, vorobyov}@ece.ualberta.ca
% Electrical and Computer Engineering Department,
% University of Alberta, Edmonton, Alberta, Canada.
% All rights reserved.

    WSN.x=(rand(1,WSN.M)-0.5)*2*WSN.R; 
    WSN.y=(rand(1,WSN.M)-0.5)*2*WSN.R;
    I = 0;

    while ~isempty(I)
        I=find(WSN.x.^2+WSN.y.^2>WSN.R^2);
        WSN.x(I)=(rand(1,length(I))-0.5)*2*WSN.R;
        WSN.y(I)=(rand(1,length(I))-0.5)*2*WSN.R;
    end

end