Matlab Code for the Sidelobe control in collaborative beamforming via node selection
 

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Purpose:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

The Matlab implementation of the examples described in the paper: M.F.A. Ahmed and S.A. Vorobyov, "Sidelobe control in collaborative beamforming via node selection," IEEE Trans. Signal Processing, accepted 2010.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
List of Figures:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

Fig 3: Beampattern: The intended BS/AP is located at \varphi_0= 0^o and 4 unintended BSs/APs at directions \varphi_1=-140^o, \varphi_2=-70^o,  \varphi_3=70^o, and \varphi_4=140^o: M = 512, N = 256, L = 32, \varphi_0=0^o, and \eta_thr = 10~dB.

Fig 4: Beampattern: Multi-link beampatterns with BSs/APs at directions \varphi_0 = 0^o, \varphi_1 = -140^o, \varphi_2 = -70^o, \varphi_3 = 70^o, and \varphi_4 = 140^o: M = 512, N = 256, L = 32, and \eta_thr = 10~dB. 

Fig 5: Beampattern: The interference is limited in the range \phi \in [ 25^o \, 45^o ]: M = 512, N = 256, L = 32, \varphi_0=0^o, and \eta_thr = 10~dB.

Fig 6: Beampattern: The unintended BSs/APs are at directions corresponding to the peaks of the average beampattern: M = 512, N = 256, L = 32, \varphi_0=0^o, and \eta_{\text{thr}} = 10~dB.

Fig 7: Average number of trials E{T} versus threshold \eta_thr: M = 512, N = 256, \varphi_0=0^o, and \varphi_1=65^o.

Fig 8: Average number of trials E{T} versus threshold \eta_thr for different values of D: M = 512, N = 256, L = 32, and \varphi_0=0^o.

Fig 9: The CCDF of the INR for different values of the threshold \eta_thr: M = 512, N = 256, L = 32, \varphi_0=0^o, and \varphi_1=65^o.

Fig 10: The CCDF of the INR for different values of K: M = 512, N = 256, L = 32, \varphi_0=0^o, and \eta_thr = 10~dB.

Fig 11: The SNR of the single-link CB and the SINR of the multi-link CBs with and without node selection for different values of K: M = 512, N = 256, L = 32, and \varphi_0=0^o.

Fig 12: The transmission rate of the single- and multi-link CBs with and without node selection for different values of K: M = 512, N = 256, L = 32, and \varphi_0=0^o.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Matlab Code:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
To simulate the examples and generate the figures of the paper use the following m-files:

Fig3andFig4.m
Fig5.m
Fig6.m
Fig7.m
Fig8.m
Fig9.m
Fig10.m
Fig11andFig12.m

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Notes:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

In examples 3,4, 5, and 6, 
- The channel effect is neglected to focus on the beampattern.
- The plotted beampattern is normalized to the noise power.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Definitions of the Variables:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

WSN   : Data structure for a wireless sensor network (WSN).

WSN.R : Disk radius normalized to \lambda.
WSN.x : x coordinates of the sensor node locations.
WSN.y : y coordinates of the sensor node locations.
WSN.M : The total number of sensor nodes in the coverage area of the transmitting source node.
WSN.N : The desired number of collaborative nodes to be selected.
WSN.L : The size of a group of candidate sensor nodes.
WSN.APsDirections : Directions of the BSs/APs.
WSN.K : Number of the BSs/APs
WSN.TargetedAP : Index of the intended BS/AP in WSN.APsDirections
WSN.UnTargetedAP:Index of the unintended BS/AP in WSN.APsDirections
WSN.Index : Index of the collaborative nodes.
WSN.phi : The angle at which the beampattern is calculated.
WSN.ChannelGain : The channel coeffiecents.
WSN.SNR: The power budget for all N collaborative nodes normalized to the noise power \sigma_w^2. 
WSN.INRthr:  The INR threshold \eta_thr.
WSN.NoisePower: Noise power.
WSN.Wmax : The transmitting of the collaborative nodes.
WSN.v: The variance of the Gaussian distribution corresponding log-normal disdtibuted channel coefficient.
WSN.m: The mean of the Gaussian distribution corresponding log-normal disdtibuted channel coefficient.
WSN.ma: The mean of the channel coefficient.
WSN.va: The variance of the channel coefficient.
WSN.mx: The mean of the array factor.
WSN.vx: The variance of the array factor.
WSN.NoOfTrials: The number of trials required for node selection.
INR_sim: Simulation value of the INR.
CCDF:  Analytical value of the CCDF.
CCDF_sim: Simulation value of the CCDF.
BP: The beampattern.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
Functions:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 


- GeneralWSN: Creats the data structure WSN and sets its initial data values. 

- UniformWSN: Generats a sensor nodes coordinates in 2D plan. The sensor nodes are scattered over a disk of radius R. The coordinates WSN.x and WSN.y follow a Uniform spatial distribution. 
Input(s):
WSN.M
WSN.R
Output(s):
WSN.x
WSN.y

- BeamPattern: Finds the beampattern of the collaborative sensor nodes.
Input(s):
WSN.Wmax
WSN.x
WSN.y
WSN.ChannelGain
WSN.Index
WSN.phi
WSN.APsDirections
Output(s):
BP

- BeamPatternUsingEquation: Finds the average beampattern of the uniform distributed sensor nodes using equation (15) from the paper H. Ochiai, P. Mitran, H. V. Poor, and V. Tarokh, "Collaborative beam-forming for distributed wireless ad hoc sensor networks," IEEE Trans. Signal Processing, vol. 53, no. 11, pp. 4110-4124, Nov. 2005. Note that the beampattern in this equation is normalized to 1.
Input(s):
WSN.phi
Output(s):
BPequation

- MyCCDF: Generate the CCDF.

- NodeSelection: Selects a subset of WSN.N collaborative nodes from the WSN.M nodes in the coverage area of each source node. The size of one group of nodes to be tested in each trial is WSN.L.
Input(s):
WSN.SNR
WSN.INRthr
WSN.NoisePower
WSN.M
WSN.N
WSN.L
WSN.K
WSN.phi
WSN.APsDirections
WSN.TargetedAP
WSN.UnTargetedAP
WSN.ChannelGain
Output(s):
WSN.Index
WSN.NoOfTrials



Please report any bugs to Mohammed Ahmed <mfahmed@ece.ualberta.ca> or Sergiy A. Vorobyov <vorobyov@ece.ualberta.ca>.

Last updated: September 21st, 2010.