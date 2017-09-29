% Description:
%   localise the speaker in 3D 


clear all
close all
clc

addpath D:\FBK_Trento\src\GCF_SSL
addpath D:\FBK_Trento\src\GCFanalysis

load('../Mic_pos.mat');
[s,fa]=audioread('D:\FBK_Trento\Data\Circular_Array\pos_4_mid_speech.wav');
s=s';

nfft=2^14;
win=hann(nfft);
ov_lap=0.875;
Mic_pair=my_Mic_pair('all');
c=342;
wei=0;
0.5
% creat a 3D Cartesian grid
Xr=[-3 0.02 3];
Yr=[-3 0.02 3];
Zr=[-0.5 0.02 2];
[Grid_cart,X,Y,Z]=myGrid3D_cart(Xr,Yr,Zr);

[idealTDOA,idealTDOA_CMindex]=idealTDOAgeneration_Original(Grid_cart,Mic_pos,Mic_pair,c,fa);
[~,~,~,SSL_Results]=GCFcart(s,c,fa,win,nfft,ov_lap,Mic_pos,Mic_pair,wei,idealTDOA_CMindex,Grid_cart);

save('F:\FBK_Trento\Results\FBKdataset_analysis\GCFpos_4_mid_speech.mat','SSL_Results','idealTDOA','idealTDOA_CMindex')
