% Date: 17/06/2017

clear all
close all
clc


[s,fa]=audioread('D:\FBK_Trento\Data\Circular_Array\pos_0_speech.wav');

for i=1:size(s,2)
    Audio=s(:,i);
    audiowrite(['D:\FBK_Trento\Data\Circular_Array\SeparateChannel\pos_0_speech_Mic',num2str(i),'.wav'],Audio,fa);
end