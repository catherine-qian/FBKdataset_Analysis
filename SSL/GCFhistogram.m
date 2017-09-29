% Description:
%   histogram based GCF3D


clear all
close all
clc


% load('F:\FBK_Trento\Results\FBKdataset_analysis\GCFpos_0_speech_longest4gap1.mat')
load('F:\FBK_Trento\Results\FBKdataset_analysis\GCFpos_4_mid_speech_longest4gap1.mat')
AMmax=SSL_Results.AM_max;
est=SSL_Results.SSLcart;

vad=AMmax>0.1;

Bin=200;
figure
subplot(3,1,1)
histogram(est(2,vad),Bin)
subplot(3,1,2)
histogram(est(3,vad),Bin)
subplot(3,1,3)
histogram(est(4,vad),Bin)
