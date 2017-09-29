% Description:
%   check GCC-PHAT between each possible microphone pairs
% 18/06/2017
% XQ

clear all
close all
clc

% AuName='pos_4_mid_speech'; % 'pos_0_speech'
AuName='pos_0_speech';
load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'.mat'])

CM=SSL_Results.CM;
MP=SSL_Results.par.Mic_pair;


figure
for i=1:size(MP,1)
%     MaxDelay=(size(CM{MP(i,1),MP(i,2)})-1)/2;
    mesh(CM{MP(i,1),MP(i,2)})
    view(100, 50)
    title([AuName([1:3,5]),'Mic pair:',num2str(MP(i,1)),'-',num2str(MP(i,2))])
    xlabel('Frame')
    ylabel('Delay')
    
    pause
    clf
end


FrLen=length(SSL_Results.AM_max); % frame length
figure
for i=1:size(MP,1)
    MaxDelay=(size(CM{MP(i,1),MP(i,2)})-1)/2;
    
    imagesc(1:FrLen,-MaxDelay:MaxDelay,CM{MP(i,1),MP(i,2)})
    colorbar
    title([AuName([1:3,5]),'  Mic pair:',num2str(MP(i,1)),'-',num2str(MP(i,2))])
    xlabel('Frame')
    ylabel('Delay')
    saveas(gcf,['F:\FBK_Trento\Results\FBKdataset_analysis\figures\GCCPHAT\',AuName([1:3,5]),'\','GCCPHAT-Mic',num2str(MP(i,1)),num2str(MP(i,2)),'.png'])
    pause
    clf
end

