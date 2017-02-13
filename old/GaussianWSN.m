function WSN=GaussianWSN(WSN)

% This function generats a WSN coordinates in 2D plan. the coordinates x
% and y follow a Uniform spatial distribution.
%
%
% WSN : Sensor Nodes data structure.
% WSN.M : Number of sensor nodes.
% WSN.R : Cluster radius.
% WSN.x : x coordinates of the sensor node locations.
% WSN.y : y coordinates of the sensor node locations.

R = 3*WSN.ClusterSigma;
WSN.x=randn(1,WSN.M)*WSN.ClusterSigma;
WSN.y=randn(1,WSN.M)*WSN.ClusterSigma;
I=0;

while ~isempty(I)
    I=find(WSN.x.^2+WSN.y.^2>WSN.R^2);
    WSN.x(I)=randn(1,length(I))*WSN.ClusterSigma;
    WSN.y(I)=randn(1,length(I))*WSN.ClusterSigma;
end

end