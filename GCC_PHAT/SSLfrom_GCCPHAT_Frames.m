% Description:
%   check the GCF derived from modified GCC-PHAT
% Date: 03/07/2017
% Author: Xinyuan


clear all
close all
clc

addpath(genpath('D:\FBK_Trento\src'))


% AuName='pos_4_mid_speech';  % 'pos_0_speech'
AuName='pos_0_speech';
load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'.mat'])
CM=SSL_Results.CM;
AMmax=SSL_Results.AM_max;
Gmax3D=max(AMmax);
FrN=length(AMmax);  % total frame number

load('D:\FBK_Trento\Data\Circular_Array\Mic_pos.mat')
load('D:\FBK_Trento\Data\MicArray.mat');
Mic_c=mean(Mic_pos)';


Rip=1;
fa=96000;
c=342;

Height=0;

% 3D grid
Xr=[-3 0.02 3];
Yr=[-3 0.02 3];
Zr=[0 1 0];
[Grid_cart,X,Y]=myGrid3D_cart(Xr,Yr,Zr);
Grid_cart(3,:)=Height;

% MicType='all';
% MicPair=my_MicPair(MicType);
MicPair=[1 7];
[~,idealTDOA]=GCF3Dcart_SphSlide_CMinterp(CM,Rip,c,fa,Mic_pos,MicPair,Grid_cart,1);
itdoa=reshape(idealTDOA{1},[length(X) length(Y)]);  % ideal TDOA

ITDOA=figure
imagesc(X,Y,itdoa)  % plot idealTDOA
colorbar
daspect([1 1 1])
xlabel('X (m)')
ylabel('Y (m)')
title(['ideal TDOA','  H=',num2str(Height),' m'])

XY=figure;

for fr=550:FrN-1
    
    
    % for the overall microphone pairs
    [GCFselection,idealTDOA]=GCF3Dcart_SphSlide_CMinterp(CM,Rip,c,fa,Mic_pos,MicPair,Grid_cart,fr);
    GCFmax=max(GCFselection.AM);
    GCFmin=min(GCFselection.AM);
    
    AM=reshape(GCFselection.AM,[length(X) length(Y)]);
    
    
    figure(XY)
    subplot(2,1,1)
    imagesc(X,Y,AM)
    %     colorbar
    %     caxis([GCFmin GCFmax])
    hold on
    plot(Mic_pos(MicPair,1),Mic_pos(MicPair,2),'k*-','LineWidth',1)
    xlabel('X (m)')
    ylabel('Y (m)')
    title([AuName([1:3,5]),' (Mic',num2str(MicPair(1)),num2str(MicPair(2)),')  fr=',num2str(fr),' H=',num2str(Height)])
    daspect([1 1 1])
    
    subplot(2,1,2)
    hold on
    MaxDelay=(size(CM{MicPair(1),MicPair(2)},1)-1)/2;
    plot(-MaxDelay:MaxDelay,CM{MicPair(1),MicPair(2)}(:,max(fr-1,1)),'g.-')
    plot(-MaxDelay:MaxDelay,CM{MicPair(1),MicPair(2)}(:,fr+1),'b.-')
    plot(-MaxDelay:MaxDelay,CM{MicPair(1),MicPair(2)}(:,fr),'ro-','LineWidth',1)
    
    xlim([-MaxDelay MaxDelay])
    
    ylim([-0.2 0.35])
    
    
    grid on
    xlabel('Time Delay')
    ylabel('GCC-PHAT')
    %         saveas(gcf,['F:\FBK_Trento\Results\FBKdataset_analysis\figures\GCFXY\',AuName([1:3,5]),'\ByFrame\',AuName([1:3,5]),'_FrA',num2str(FrA),'_Mic',num2str(MicPair(1)),num2str(MicPair(2)),'H',num2str(Height),'.png'])
    pause
    %     pause(0.025)
    
    clf
end
% subplot(1,2,2)
% imagesc(X,Y,AM==GCFmax)
% daspect([1 1 1])
% title([' G^{z}_{max}=',num2str(GCFmax),'  #max=',num2str(MaxN)])
% colorbar





