# RIS-Assisted-Index-Modulation-MIMO

RIS-Assisted Index Modulation for MIMO Systems
MATLAB simulations from the 2021 master's thesis Reconfigurable Intelligent Surfaces for Beyond 5G, completed at the Lebanese International University by Mohamad Hussein Daher and Mohamad Ahmad Bayaa.
Overview
Reconfigurable Intelligent Surfaces (RIS) use controllable reflecting elements to influence wireless signal propagation. This project studies RIS-assisted communication schemes, particularly index modulation (IM), where additional information can be conveyed through the selection of a receive-antenna index alongside conventional modulation symbols.

The simulations investigate RIS-based Space Shift Keying (SSK) and Spatial Modulation (SM), including multiple-antenna transmission with diversity and multiplexing. They compare joint maximum-likelihood (ML) and greedy detection strategies and evaluate error performance across signal-to-noise ratio (SNR) values.
MATLAB files
File	Purpose
RIS_SSK.m	RIS-assisted space shift keying simulation
SM.m	RIS-assisted spatial modulation simulation
RIS_SM_transmitdiversity.m	Spatial modulation with transmit diversity
RIS_SM_transmitMultiplexing.m	Spatial modulation with transmit multiplexing
SM_jointML.m	Joint maximum-likelihood detector
SM_greedyDetector.m	Greedy detector
SM_joint_MLMultiplexing.m	Joint ML detector for multiplexing
SM_greedyDetectorMultiplexing.m	Greedy detector for multiplexing


Running the simulations
1. Open MATLAB and set the current folder to this repository.
2. Run one of the main scripts: RIS_SSK.m, SM.m, RIS_SM_transmitdiversity.m, or RIS_SM_transmitMultiplexing.m.
3. Adjust simulation parameters directly in the script (such as SNR, antenna counts, or modulation order).
The detector .m functions are called by the simulation scripts. The code uses MATLAB communications functions such as qammod, bi2de, and de2bi; Communications Toolbox may be required. The original research scripts are provided as-is and have not been validated against current MATLAB releases.
Research context
The thesis explores RIS configurations as transmitters and reflecting links, RIS-SSK and RIS-SM, and the use of multiple antennas to improve robustness or throughput. The MATLAB code in this repository specifically covers the index-modulation and detector simulations listed above; it does not implement every concept discussed in the thesis.

Thesis: Reconfigurable Intelligent Surfaces for Beyond 5G (2021), Lebanese International University.

Authors: Mohamad Hussein Daher and Mohamad Ahmad Bayaa.
Notes
This repository preserves academic simulation code from the original thesis. It is intended for research and educational reference, not as a production-ready wireless communication system.
