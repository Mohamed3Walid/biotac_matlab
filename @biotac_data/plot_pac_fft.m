function [obj] = plot_pac_fft(obj)
%PLOT_PAC_FFT plots fft of pac signal
%
% function [ obj ] = plot_pac_fft(obj)
% 
% function

L = size(obj.pac,1);
NFFT = 2^nextpow2(L);
pac_fft = fft(obj.pac(:,2), NFFT)/L;
Fs = 2200;
f = (Fs/2)*linspace(0,1,NFFT/2+1);

plot(f, 2*abs(pac_fft(1:NFFT/2+1)));


end

