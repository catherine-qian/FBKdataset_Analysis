% check the audio signal frame by frame at different microphones
% Date: 28/06/2017
% XQ


clear all
close all
clc

load('D:\FBK_Trento\Data\Circular_Array\Mic_pos.mat')

AuName='pos_4_mid_speech';  % 'pos_0_speech'
% AuName='pos_0_speech';

% audio signal
[s,fa]=audioread(['D:\FBK_Trento\Data\Circular_Array\',AuName,'.wav']);
s=s';

load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'.mat'])

% vad=logical(ones(size(SSL_Results.AM_max)));
% s=s(:,vad);


figure
xlabel('Mic')
ylabel('Amplitude')
for i=size(s,2)/2:size(s,2)
    fr=i;
    plot(s(:,fr),'b*-')
    title([AuName([1:3,5]),'  fr: ',num2str(fr),'/',num2str(size(s,2)),'  sec:',num2str(fr/fa)])
    grid on
    pause(0.0001)
end
