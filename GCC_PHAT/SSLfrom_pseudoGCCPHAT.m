% Description:
% we estimate the GCC-PHAT according to our changed GCC-PHAT


clear all
close all
clc

addpath(genpath('D:\FBK_Trento\src'))

load('D:\FBK_Trento\Data\Circular_Array\Mic_pos.mat')


Rip=1;
fa=96000;
c=342;

% 3D grid
Xr=[-3 0.02 3];
Yr=[-3 0.02 3];
Zr=[-1 0.02 2];
[Grid_cart,X,Y]=myGrid3D_cart(Xr,Yr,Zr);

MicPair1=my_Mic_pair('longest4');
MicPair2=my_Mic_pair('gap2');
MicPair=[MicPair1;MicPair2];

CMdelayPair1=[44 24 -11 38];
CMdelayPair2=[26 34 7 -25 -41 33 7 -24];
CMdelayPair=[CMdelayPair1 CMdelayPair2];

CM=myPseudoGCCPHAT(MicPair,Mic_pos,CMdelayPair,fa,c);
[GCFselection,idealTDOA]=GCF3Dcart_SphSlide_CMinterp(CM,Rip,c,fa,Mic_pos,MicPair,Grid_cart,1);


 SSLindex=find(AM==AMmax);
 Grid_cart(:,SSLindex)
