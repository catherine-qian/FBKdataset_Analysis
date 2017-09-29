% 18/06/2017


clear all
close all
clc

addpath D:\FBK_Trento\src\GCF_SSL
addpath D:\FBK_Trento\src\GCFanalysis

[s,fa]=audioread('D:\FBK_Trento\Data\Circular_Array\pos_4_mid_speech.wav');
s1=s(:,1)';


% self-decimation
D=3;  % decimation factor;
sd1(1,:)=s1(1:D:end);
fd=fa/D;


% MATLAB decimation
y = decimate(s1,D);
yself=myDecimationIIR(s1,D);