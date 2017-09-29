% Description:
%   check the Gmax at one audio frame over different heights
% Date: 03/07/2017
% Author: XQ


clear all
% close all
clc

addpath D:\FBK_Trento\src\GCF_SSL
addpath D:\FBK_Trento\src\FBKdataset_Analysis\SSL

AuName='pos_4_mid_speech';  % 'pos_0_speech'
% AuName='pos_0_speech';


load('D:\FBK_Trento\Data\Circular_Array\Mic_pos.mat')
load('D:\FBK_Trento\Data\MicArray.mat');
Mic_c=mean(Mic_pos)';


Rip=1;
fa=96000;
c=342;

% 3D grid
Xr=[-3 0.02 3];
Yr=[-3 0.02 3];
Zr=[0 0.02 0];
[Grid_cart,X,Y]=myGrid3D_cart(Xr,Yr,Zr);



MicType='gap2';
MicPair=my_Mic_pair(MicType);

load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'_',MicType,'.mat'])
AMmax3D=SSL_Results.AM_max;
[~,FrA]=max(AMmax3D);
FrA=1;
AMN=SSL_Results.AM_N;
CM=SSL_Results.CM;

Zg=-0.5:0.02:2;
GCFmax=zeros(1,length(Zg));
MaxN=zeros(1,length(Zg));


for h=1:length(Zg)  % different heights
    Height=Zg(h);
    Grid_cart(3,:)=Height;
    
    % for the overall microphone pairs
    [GCFselection]=GCF3Dcart_SphSlide_CMinterp(CM,Rip,c,fa,Mic_pos,MicPair,Grid_cart,FrA);
    GCFmax(h)=max(GCFselection.AM);
    %         Gmax(ami,h,Mic)=GCFmax;
    MaxIndex=find(GCFselection.AM==GCFmax(h));
    MaxN(h)=length(MaxIndex);
    
end



% figure
% plot(Zg,GCFmax,'r.-')
% xlabel('height (m)')
% ylabel('G^{z}_{max}_{t}')
% grid on

Zg_th=0.2;
Zg0=Zg(Zg>Zg_th);
GCFmax0=GCFmax(Zg>Zg_th);
figure
plot(Zg0,GCFmax0,'b.-')
xlabel('height (m)')
ylabel('G^{z}_{max}_{t}')
grid on
title([AuName([1:3,5]),' ',MicType,'  (FrA:',num2str(FrA),')      G^{3D}_{max}=',num2str(max(AMmax3D))])

saveas(gcf,['F:\FBK_Trento\Results\FBKdataset_analysis\figures\GCFmaxCheck\96kHz\',AuName([1:3,5]),'\',AuName([1:3,5]),'_FrA',num2str(FrA),'_',MicType,'_heights.png'])


figure
plot(AMmax3D,'r.')
xlabel('frame')
ylabel('G^{3D}_{max}')
title([AuName([1:3,5]),' ',MicType,'   G^{3D}_{max}  '])
grid on