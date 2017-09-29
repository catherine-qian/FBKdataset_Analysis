function CM=myPseudoGCCPHAT(MicPair,Mic_pos,CMdelayPair,fa,c)
% Description:
%   create the pseudo GCCPHAT
% Date: 06/07/2017
% Author: Xinyuan Qian
% Input:
%   CMdelayPair: ideal TDOA in sampels
%   c: sound speed

CM=cell(8);

for m=1:size(MicPair,1)
    idealDelay=CMdelayPair(m);
    a=MicPair(m,1);
    b=MicPair(m,2);
    MaxDelay=round(norm(Mic_pos(a,:)-Mic_pos(b,:))/c*fa);
    CM{a,b}=zeros(2*MaxDelay+1,1);
    CM{a,b}(MaxDelay+1+idealDelay)=1;
end


end