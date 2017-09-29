function Mic_pair=my_Mic_pair(name)
% Description:
% Date: 28/08/2016
% Author: Xinyuan Qian
%
% Input:
%   name='adjacent8'/'longest4'/'all'
%   Mic_N: total microphone number

switch name
    case 'longest4'
        Mic_pair=zeros(4,2);
        Mic_pair(:,1)=1:4;
        Mic_pair(:,2)=5:8;
    case 'gap1'
        Mic_pair=zeros(8,2);
        Mic_pair(1:6,1)=1:6;
        Mic_pair(1:6,2)=3:8;
        Mic_pair(7:8,1)=1:2;
        Mic_pair(7:8,2)=7:8;
        
        
    case 'gap2'
        Mic_pair=zeros(8,2);
        Mic_pair(1:5,1)=1:5;
        Mic_pair(1:5,2)=4:8;
        Mic_pair(6:8,1)=1:3;
        Mic_pair(6:8,2)=6:8;
        
    case 'adjacent8'
        Mic_pair=zeros(8,2);
        Mic_pair(:,1)=1:8;
        Mic_pair(1:7,2)=2:8;
        Mic_pair(8,1)=1;
        Mic_pair(8,2)=8;
 
    case 'all'
        Mic_pair=zeros(28,2);
        i=1;
        
        for a=1:7
            for b=a+1:8
                Mic_pair(i,1)=a;
                Mic_pair(i,2)=b;
                i=i+1;
            end
        end
        
end


end


