% Description: check the histogram of SSL results
% Date: 28/06/2017
% Author: XQ
clear all
close all
clc

load('D:\FBK_Trento\Data\Circular_Array\Mic_pos.mat')

MicArray=cell(5,1);
MicArray{1}='adjacent8';
MicArray{2}='longest4';
MicArray{3}='gap1';
MicArray{4}='gap2';
MicArray{5}='all';

AuName='pos_4_mid_speech';  % 'pos_0_speech'
% AuName='pos_0_speech';
VadGmax=0.1;
Bin=500;

SSLhist=zeros(5,3);  % for each Mic types
for m=1:5
    MicType=MicArray{m};
    
    load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'_',MicType,'.mat'])
    
    
    AMmax=SSL_Results.AM_max;
    Est=SSL_Results.SSLcart(2:4,:);
    vad=AMmax>VadGmax;
    
    
    figure
    subplot(3,1,1)
    Hx=histogram(Est(1,vad),Bin);
    xlabel('SSL - X(m)')
    title([AuName([1:3,5]),' (',MicType,') vad>',num2str(VadGmax)])
    [~,Hindex]=max(Hx.Values);
    SSLhist(m,1)=Hx.BinEdges(Hindex);
    
    subplot(3,1,2)
    Hy=histogram(Est(2,vad),Bin);
    xlabel('SSL - Y(m)')
    [~,Hindex]=max(Hy.Values);
    SSLhist(m,2)=Hy.BinEdges(Hindex);
    
    subplot(3,1,3)
    Hz=histogram(Est(3,vad),Bin);
    xlabel('SSL - Z(m)')
    [~,Hindex]=max(Hz.Values);
    SSLhist(m,3)=Hz.BinEdges(Hindex);
    
    clear Hx Hy Hz
end


% 3D

figure
plot3(Mic_pos(:,1),Mic_pos(:,2),Mic_pos(:,3),'ko')
hold on
grid on

for m=1:5
    plot3(SSLhist(m,1),SSLhist(m,2),SSLhist(m,3),'*')
end
legend('Mc','SSL-adj8','SSL-lg4','SSL-gap1','SSL-gap2','SSL-all','Location','bestoutside')
xlim([Xg(1) Xg(end)])
ylim([Yg(1) Yg(end)])
zlim([Zg(1) Zg(end)])
daspect([1 1 1])
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')
title([AuName([1:3,5]),' vad>',num2str(VadGmax)])


% XY

figure
plot(Mic_pos(:,1),Mic_pos(:,2),'ko')
hold on
grid on

for m=1:5
    plot(SSLhist(m,1),SSLhist(m,2),'*')
end
legend('Mc','SSL-adj8','SSL-lg4','SSL-gap1','SSL-gap2','SSL-all','Location','bestoutside')
xlim([Xg(1) Xg(end)])
ylim([Yg(1) Yg(end)])
daspect([1 1 1])
xlabel('X (m)')
ylabel('Y (m)')
title([AuName([1:3,5]),' vad>',num2str(VadGmax)])


% XZ

figure
plot(Mic_pos(:,1),Mic_pos(:,3),'ko')
hold on
grid on

for m=1:5
    plot(SSLhist(m,1),SSLhist(m,3),'*')
end
legend('Mc','SSL-adj8','SSL-lg4','SSL-gap1','SSL-gap2','SSL-all','Location','bestoutside')
xlim([Xg(1) Xg(end)])
ylim([Zg(1) Zg(end)])
daspect([1 1 1])
xlabel('X (m)')
ylabel('Z (m)')
title([AuName([1:3,5]),' vad>',num2str(VadGmax)])
