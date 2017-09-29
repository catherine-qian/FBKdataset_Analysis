% Description:
%   check the relationship between GCF peak value and the number of points
%   get GCF peak value
% Date: 28/06/2017
% XQ

clear all
% close all
clc

% AuName='pos_4_mid_speech';  % 'pos_0_speech'
AuName='pos_0_speech';

MicType='adjacent8';

% audio signal
[s,fa]=audioread(['D:\FBK_Trento\Data\Circular_Array\',AuName,'.wav']);
s=s';

load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'.mat'])
% load(['F:\FBK_Trento\Results\FBKdataset_analysis\GCF',AuName,'_',MicType,'.mat'])

AMmax=SSL_Results.AM_max;
AMN=SSL_Results.AM_N;


figure
plot([1:size(s,2)]/fa,s(1,:),'b-')
grid on
xlabel('sec')
ylabel('amplitude')
title(['Audio: ',AuName([1:3,5]),' -Mic1'])


figure
subplot(2,1,1)
plot(AMmax,'b.-')
title([AuName([1:3,5]),' (',MicType,')'])
grid on
xlabel('Frame')
ylabel('GCF peak value')

subplot(2,1,2)
plot(AMN,'r.-')
xlabel('Frame')
ylabel('# of GCF peak points')
title(['Nmin=',num2str(min(AMN)) '  Nmax=',num2str(max(AMN))])
grid on