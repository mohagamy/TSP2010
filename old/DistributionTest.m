% WSN Parameter Set-up
clear;clc;
SensorNodes.R = 5;
SensorNodes.M = 512;
SensorNodes.N = 256;
SensorNodes.ProbOfSel = [];
APs.SNR = 10^(20/10);
SensorNodes.Index = 1:SensorNodes.M;
SensorNodes = UniformWSN(SensorNodes);
SensorNodes.xError = 0*0.05*(rand(1,SensorNodes.M)-0.5)*2*SensorNodes.R;
SensorNodes.yError = 0*0.05*(rand(1,SensorNodes.M)-0.5)*2*SensorNodes.R;
APs.Direction = [0 65]*pi/180;
SensorNodes.phi=[-180:180]*pi/180;
DirectionOf_D0 = APs.Direction(1);
SensorNodes.NoOfTransPowerLevels = 1;
SensorNodes.Wmax = sqrt(APs.SNR/(SensorNodes.N^2));


SensorNodes.v  = 0.2;
SensorNodes.vx = 0.5;
SensorNodes.va = (exp(SensorNodes.v)-1)*(exp(SensorNodes.v));
SensorNodes.ma = exp(SensorNodes.v/2);

SensorNodes.vX = SensorNodes.N*(SensorNodes.va+SensorNodes.ma^2)*SensorNodes.vx*(SensorNodes.Wmax)^2;


%SensorNodes.ChannelGain = ones(1,SensorNodes.M);
SensorNodes.ChannelGain = exp(sqrt(SensorNodes.v)*randn(1,SensorNodes.M));

SensorNodes.Power = 10000*ones(1,SensorNodes.M);


SensorNodes1 = SensorNodes;

SensorNodes2 = SensorNodes;

SensorNodes3 = UniformWSN(SensorNodes);

%--------------------------------------------------
for i =1 :100000
    i
    SensorNodes1 = UniformWSN(SensorNodes1);
    
    % No Node Selection
    I=randperm(SensorNodes1.M);
    SensorNodes1.Index = (I(1:SensorNodes1.N));
    BP1(i) = BeamPattern_(SensorNodes1,APs.Direction(1),APs.Direction(2));
    
    
    % No Node Selection
    I=randperm(SensorNodes2.M);
    SensorNodes2.Index = (I(1:SensorNodes2.N));
    
    BP2(i) = BeamPattern_(SensorNodes2,APs.Direction(1),APs.Direction(2));

    % No Node Selection
    I=randperm(SensorNodes3.M);
    SensorNodes3.Index = (I(1:SensorNodes3.N));
    
    BP3(i) = BeamPattern_(SensorNodes3,APs.Direction(1),APs.Direction(2));
end



[xCCDF1,yCCDF1] = myccdf(BP1);
[xCCDF2,yCCDF2] = myccdf(BP2);
[xCCDF3,yCCDF3] = myccdf(BP3);

sig=0.5*(SensorNodes.N)*(SensorNodes1.Wmax)^2;

yCCDF_=exp(-xCCDF2(2:end-1)./(2*SensorNodes.vX));




semilogy(10*log10(xCCDF1),1-yCCDF1,'k-')
hold on
semilogy(10*log10(xCCDF2(2:end-1)),1-yCCDF_,'k--')
semilogy(10*log10(xCCDF2),1-yCCDF2,':k')
semilogy(10*log10(xCCDF3),1-yCCDF3,':k')
