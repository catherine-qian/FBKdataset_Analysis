function odata=myDecimationIIR(idata,D)
% Description:
%   rewrite the 'decimate' MATLAB funtion for better understanding
% Date: 02/07/2017
% Author: XQ
%
% Output:
%   odata: output decimated audio signal

nd = length(idata);
m = size(idata,1);  % number of channels
nout = ceil(nd/D);

nfilt=8;  % IIR fitler order
% IIR filter parameter
rip = .05;	% passband ripple in dB
[b,a] = cheby1(nfilt, rip, .8/D);


odata = filtfilt(b,a,idata);
nbeg = D - (D*nout - nd);
odata = odata(nbeg:D:nd);

end