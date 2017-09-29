% Description:
% use the MATLAB built-in function to decimate the FBK dataset
% Date: 02/07/2017
% Author: XQ


clear all
close all
clc


D=[2,3,4,6,12];

Name=cell(2,1);
Name{1}='pos_0_speech';
Name{2}='pos_4_mid_speech';


for pos=1:length(Name)
    
    [ain,fa]=audioread(['D:\FBK_Trento\Data\Circular_Array\',Name{pos},'.wav']);
    ain=ain';
    C=size(ain,1);
    
    
    for i=1:length(D) % deciamtion factor
        
        display(['Pos',num2str(pos),'  ','decimate factor',num2str(i),'/',num2str(length(D))])
       
        r=D(i);
        fa_d=fa/r;
        
        for c=1:C  % channel
            s(c,:)= decimate(ain(c,:),r);
            audiowrite(['D:\FBK_Trento\Data\Circular_Array\Decimation\',num2str(fa_d/1000),'kHz\',Name{pos},'_',num2str(fa_d/1000),'kHz_Mic',num2str(c),'.wav'],s(c,:),fa_d)
        end
        
        audiowrite(['D:\FBK_Trento\Data\Circular_Array\Decimation\',num2str(fa_d/1000),'kHz\',Name{pos},'_',num2str(fa_d/1000),'kHz.wav'],s',fa_d)
        clear s
    end
    
end