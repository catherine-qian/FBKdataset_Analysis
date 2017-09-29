% Description:
%   check the GCF on XY plane
% Date: 29/06/2017
% Author: Xinyuan


clear all
close all
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

Zg=-0.5:0.1:2;


XY=figure;
GCFmax=zeros(1,length(Zg));

for Mic=5:5  % different microphone pair combinations
    
    MicType=MicArray{Mic};
    MicPair=my_Mic_pair(MicType);
    
    load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'_',MicType,'.mat'])
    AMmax=SSL_Results.AM_max;
    [~,FrA]=max(AMmax);
    AMN=SSL_Results.AM_N;
    CM=SSL_Results.CM;
%     [~,FrA]=max(AMmax);
    
    for h=1:length(Zg)  % different heights
        Height=Zg(h);
        Grid_cart(3,:)=Height;
        
        % for the overall microphone pairs
        [GCFselection]=GCF3Dcart_SphSlide_CMinterp(CM,Rip,c,fa,Mic_pos,MicPair,Grid_cart,FrA);
        GCFmax(h)=max(GCFselection.AM);
        %         Gmax(ami,h,Mic)=GCFmax;
        MaxIndex=find(GCFselection.AM==GCFmax(h));
        MaxN=length(MaxIndex);
        if(MaxN>1)
            [~,MaxInd]=min(sqrt(sum((Grid_cart(:,MaxIndex)-Mic_c).^2)));% closest GCF peak point
            MaxIndex=MaxIndex(MaxInd);
        end
        SSLcart=[Grid_cart(1,MaxIndex);Grid_cart(2,MaxIndex);Grid_cart(3,MaxIndex)];
        AM=reshape(GCFselection.AM,[length(X) length(Y)]);
        
        subplot(1,2,1)
        imagesc(X,Y,AM)
        colorbar
        hold on
        plot(SSLcart(1),SSLcart(2),'g*','LineWidth',1)
        plot(Mic_pos(MicPair,1),Mic_pos(MicPair,2),'k*-','LineWidth',1)
        xlabel('X (m)')
        ylabel('Y (m)')
        %         title([{['Fr-',num2str(FrA),' GCF-XY(',MicType,') GCFmax=',num2str(GCFmax),'  #max',num2str(MaxN)]},{[' h=',num2str(Height),'m GT=',num2str(round(gt3D(3)*100)/100),'m']}])
        title(['Fr-',num2str(FrA),' GCF-XY(',MicType,')','H=',num2str(Height),' m'])
        daspect([1 1 1])
        
        subplot(1,2,2)
        imagesc(X,Y,AM==GCFmax(h))
        daspect([1 1 1])
        title([' G^{z}_{max}=',num2str(GCFmax(h)),'(',num2str(AMmax(FrA)),')  #max=',num2str(MaxN)])
        colorbar
        
        pause
        figure(XY)
        clf
        
    end
end


figure
plot(Zg,GCFmax,'r.-')
xlabel('height (m)')
ylabel('GCF peak')
grid on


Zg0=Zg(Zg>0);
GCFmax0=GCFmax(Zg>0);
figure
plot(Zg0,GCFmax0,'b.-')
xlabel('height (m)')
ylabel('GCF peak')
grid on
title([AuName([1:3,5]),'  AMmax=',num2str(max(AMmax))])

