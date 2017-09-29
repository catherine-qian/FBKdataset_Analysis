% check the distribution of GCF max
% Date: 28/06/2017
% Author: XQ


clear all
% close all
clc

% AuName='pos_4_mid_speech';  % 'pos_0_speech'
AuName='pos_0_speech';  

MicType='adjacent8';


load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'.mat'])
% load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'_',MicType,'.mat'])


AMmax=SSL_Results.AM_max;
AMN=SSL_Results.AM_N;

figure
subplot(2,2,1)
plot(AMmax,'b.-')
title([AuName([1:3,5]),' (',MicType,')'])
grid on
xlabel('Frame')
ylabel('GCF peak value')

subplot(2,2,2)
histogram(AMmax,100)
xlabel('GCF peak value')
ylabel('# of frames')
title(['Gmin=',num2str(min(AMmax)) '  Gmax=',num2str(max(AMmax))])
grid on

subplot(2,2,3)
plot(AMN,'r.')
xlabel('Frame')
ylabel('# of GCF peak points')
title(['Nmin=',num2str(min(AMN)) '  Nmax=',num2str(max(AMN))])
grid on

subplot(2,2,4)
histogram(AMN,100)
xlabel('# of GCF peak points')
ylabel('# of frames')
title(['Nmin=',num2str(min(AMN)) '  Nmax=',num2str(max(AMN))])
grid on
