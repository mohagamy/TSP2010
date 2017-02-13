function [BPu,BPg]=BeamPatternUsingEquation(WSN)
% find the average beampattern of the uniform and Gaussian
% distributions using equations

V=(WSN.R/3)^2;

for cntr=1:length(WSN.phi);
    alpha_u=4*pi*WSN.R*sin(WSN.phi(cntr)/2);
    BPu(cntr)=(1/WSN.N)+(1-(1/WSN.N))*(abs( 2*(besselj(1,alpha_u))/alpha_u ))^2;
    alpha_g=4*pi*sin(WSN.phi(cntr)/2);
    BPg(cntr)=(1/WSN.N)+(1-(1/WSN.N))*(abs(  exp(-V*(alpha_g^2)/2 ) ))^2;
end
