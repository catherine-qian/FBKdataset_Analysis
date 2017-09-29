% Description:
%   check SSL results
% Date: 18/06/2017
% XQ

clear all
close all
clc

% load('F:\FBK_Trento\Results\FBKdataset_analysis\GCFpos_0_speech.mat')
% load('F:\FBK_Trento\Results\FBKdataset_analysis\GCFpos_4_mid_speech.mat')
load('F:\FBK_Trento\Results\FBKdataset_analysis\GCFpos_4_mid_speech_adjacent8.mat')


AMmax=SSL_Results.AM_max;
CM=SSL_Results.CM;
Est=SSL_Results.SSLcart;
Mic_pos=SSL_Results.par.Mic_pos;

vad=find(AMmax>0.1);

figure
hold on
grid on
plot3(Mic_pos(:,1),Mic_pos(:,2),Mic_pos(:,3),'ko-')
for i=1:length(vad)
    display([num2str(i),'/',num2str(length(vad))])
    Afr=vad(i);
    plot3(Est(2,Afr),Est(3,Afr),Est(4,Afr),'.')
    title(['Afr:',num2str(Afr),'   AMmax',num2str(AMmax(Afr))])
    xlim([-3 3])
    ylim([-3 3])
    zlim([-0.5 1.5])
    
    xlabel('X (m)')
    ylabel('Y (m)')
    zlabel('Z (m)')
    view(10,40)
%     pause(0.01)
    
end

title(['GCF3D (pos0)   vad=G_{max}>0.1'])


% display relative mic positions
figure
hold on
grid on
for i=1:8
    plot(Mic_pos(i,1),Mic_pos(i,2),'o','LineWidth',3)
end
Mic_c=mean(Mic_pos);
plot(Mic_c(1),Mic_c(2),'k*','LineWidth',3)
legend('M1','M2','M3','M4','M5','M6','M7','M8','Mc','Location','BestOutside')
daspect([1 1 1])
xlabel('X (m)')
ylabel('Y (m)')