% Description:
%   check the GCF derived from modified GCC-PHAT
% Date: 03/07/2017
% Author: Xinyuan


clear all
close all
clc

addpath D:\FBK_Trento\src\GCF_SSL
addpath D:\FBK_Trento\src\FBKdataset_Analysis\SSL
addpath D:\FBK_Trento\src\GCFanalysis

AuName='pos_4_mid_speech';  % 'pos_0_speech'
% AuName='pos_0_speech';
load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'.mat'])
CM=SSL_Results.CM;
AMmax=SSL_Results.AM_max;
Gmax3D=max(AMmax);

load('D:\FBK_Trento\Data\Circular_Array\Mic_pos.mat')
load('D:\FBK_Trento\Data\MicArray.mat');
Mic_c=mean(Mic_pos)';


Rip=1;
fa=96000;
c=342;

Height=1.5;

% 3D grid
Xr=[-3 0.02 3];
Yr=[-3 0.02 3];
Zr=[0 Height 0];
[Grid_cart,X,Y]=myGrid3D_cart(Xr,Yr,Zr);

FrA=1;
MicType='all';
Mic_Pair=my_Mic_pair(MicType);

figure

for m=1:size(Mic_Pair)
    
    MicPair=Mic_Pair(m,:);
    
    % for the overall microphone pairs
    [GCFselection,idealTDOA]=GCF3Dcart_SphSlide_CMinterp(CM,Rip,c,fa,Mic_pos,MicPair,Grid_cart,FrA);
    GCFmax=max(GCFselection.AM);
    
    MaxIndex=find(GCFselection.AM==GCFmax);
    MaxN=length(MaxIndex);
    if(MaxN>1)
        [~,MaxInd]=min(sqrt(sum((Grid_cart(:,MaxIndex)-Mic_c).^2)));% closest GCF peak point
        MaxIndex=MaxIndex(MaxInd);
    end
    SSLcart=[Grid_cart(1,MaxIndex);Grid_cart(2,MaxIndex);Grid_cart(3,MaxIndex)];
    AM=reshape(GCFselection.AM,[length(X) length(Y)]);
    itdoa=reshape(idealTDOA{1},[length(X) length(Y)]);  % ideal TDOA
    
    
    subplot(2,2,1)
    imagesc(X,Y,AM)
    colorbar
    %     caxis([-0.07 AMmax(FrA)])
    hold on
    plot(SSLcart(1),SSLcart(2),'g*','LineWidth',1)
    plot(Mic_pos(MicPair,1),Mic_pos(MicPair,2),'k*-','LineWidth',1)
    xlabel('X (m)')
    ylabel('Y (m)')
    title([AuName([1:3,5]),' (Mic',num2str(MicPair(1)),num2str(MicPair(2)),')   Fr:',num2str(FrA),' G^{3D}_{max}=',num2str(AMmax(FrA))])
    daspect([1 1 1])
    
    subplot(2,2,2)
    imagesc(X,Y,itdoa)
    colorbar
    daspect([1 1 1])
    xlabel('X (m)')
    ylabel('Y (m)')
    title(['ideal TDOA','  H=',num2str(Height),' m'])
    
    subplot(2,1,2)
    MaxDelay=(size(CM{MicPair(1),MicPair(2)},1)-1)/2;
        plot(-MaxDelay:MaxDelay,CM{MicPair(1),MicPair(2)}(:,FrA),'ro-')
%     plot(-MaxDelay:MaxDelay,CM{MicPair(1),MicPair(2)}(:,FrA-1:FrA+1),'o-')
%     legend('FrA-1','FrA','FrA+1','Location','bestoutside')
    
    grid on
    xlabel('Time Delay')
    ylabel('GCC-PHAT')
    saveas(gcf,['F:\FBK_Trento\Results\FBKdataset_analysis\figures\GCFXY\',AuName([1:3,5]),'\ByFrame\',AuName([1:3,5]),'_FrA',num2str(FrA),'_Mic',num2str(MicPair(1)),num2str(MicPair(2)),'H',num2str(Height),'.png'])
    
    pause
    
    clf
end
% subplot(1,2,2)
% imagesc(X,Y,AM==GCFmax)
% daspect([1 1 1])
% title([' G^{z}_{max}=',num2str(GCFmax),'  #max=',num2str(MaxN)])
% colorbar





