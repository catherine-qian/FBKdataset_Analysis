% Description:
%   localise the speaker in 3D 


clear all
close all
clc

addpath(genpath('D:\FBK_Trento\src\GCF_SSL'))


load('D:\FBK_Trento\Data\Circular_Array\Mic_pos.mat');
[s,fa]=audioread('D:\FBK_Trento\Data\Circular_Array\pos_0_speech.wav');
s=s';

nfft=2^14;
win=hann(nfft);
ov_lap=0.875;
MP1='longest4';
MP2='gap1';
Mic_pair1=my_Mic_pair(MP1);
Mic_pair2=my_Mic_pair(MP2);
Mic_pair=[Mic_pair1;Mic_pair2];
c=342;
wei=0;

% creat a 3D Cartesian grid
Xr=[-3 0.02 3];
Yr=[-3 0.02 3];
Zr=[-0.5 0.02 2];
[Grid_cart,X,Y,Z]=myGrid3D_cart(Xr,Yr,Zr);

[idealTDOA,idealTDOA_CMindex]=idealTDOAgeneration_Original(Grid_cart,Mic_pos,Mic_pair,c,fa);
[~,~,~,SSL_Results]=GCFcart(s,c,fa,win,nfft,ov_lap,Mic_pos,Mic_pair,wei,idealTDOA_CMindex,Grid_cart,[1 300]);

save(['F:\FBK_Trento\Results\FBKdataset_analysis\GCFpos_0_speech_',MP1,MP2,'.mat'],'SSL_Results','idealTDOA','idealTDOA_CMindex')


run GCF3D_SSL_pos4