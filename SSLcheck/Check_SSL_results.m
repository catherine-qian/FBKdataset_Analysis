% Description:
%   check SSL results
% Date: 18/06/2017
% XQ

clear all
close all
clc

MicArray=cell(5,1);
MicArray{1}='adjacent8';
MicArray{2}='longest4';
MicArray{3}='gap1';
MicArray{4}='gap2';
MicArray{5}='all';

AuName='pos_4_mid_speech';  % 'pos_0_speech'
% AuName= 'pos_0_speech';
VadGmax=0;


XY=figure;
GCF3D=figure;


for m=1:5
    MicType=MicArray{m};
    
    load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'_',MicType,'.mat'])
    AMmax=SSL_Results.AM_max;
    Est=SSL_Results.SSLcart;
    Mic_pos=SSL_Results.par.Mic_pos;
    vad=find(AMmax>VadGmax);
    
    
    % 3D
    figure(GCF3D);
    hold on
    grid on
    for i=1:8
        plot3(Mic_pos(i,1),Mic_pos(i,2),Mic_pos(i,3),'k*')
    end
    plot3(Est(2,vad),Est(3,vad),Est(4,vad),'.')
    %     legend('M1','M2','M3','M4','M5','M6','M7','M8','SSL','Location','bestoutside')
    xlim([-3 3])
    ylim([-3 3])
    zlim([-0.5 1.5])
    daspect([1 1 1])
    xlabel('X (m)')
    ylabel('Y (m)')
    zlabel('Z (m)')
    view(20,15)
    title(['GCF3D-',AuName([1:3,5]),'-',MicType,'   vad=G_{max}>',num2str(VadGmax)])
    saveas(GCF3D,['F:\FBK_Trento\Results\FBKdataset_analysis\figures\',AuName([1:3,5]),'_vad',num2str(VadGmax*10),'_GCF3D_',MicType,'.png'])
    clf
    
    % XY plane
    figure(XY);
    hold on
    grid on
    for i=1:8
        plot(Mic_pos(i,1),Mic_pos(i,2),'*')
    end
    plot(Est(2,vad),Est(3,vad),'.')
    legend('M1','M2','M3','M4','M5','M6','M7','M8','SSL','Location','bestoutside')
    xlim([-3 3])
    ylim([-3 3])
    daspect([1 1 1])
    xlabel('X (m)')
    ylabel('Y (m)')
    title(['GCFXY-',AuName([1:3,5]),'-',MicType,'   vad=G_{max}>',num2str(VadGmax)])
    saveas(XY,['F:\FBK_Trento\Results\FBKdataset_analysis\figures\',AuName([1:3,5]),'_vad',num2str(VadGmax*10),'_GCFXY_',MicType,'.png'])
    clf
end
