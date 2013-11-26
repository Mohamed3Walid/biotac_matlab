function [ f, pac_fft ] = biotac_pac_fft( pac )
%BIOTAC_PAC_FFT computes FFT of PAC signal
%
% function [ f, pac_fft ] = biotac_pac_fft( pac )
% 
% pac is assumed to have been reshaped using the biotac_reshape_pac
% function

L = size(pac,1);
NFFT = 2^nextpow2(L);
pac_fft = fft(pac, NFFT)/L;
Fs = 2200;
f = (Fs/2)*linspace(0,1,NFFT/2+1);


end

