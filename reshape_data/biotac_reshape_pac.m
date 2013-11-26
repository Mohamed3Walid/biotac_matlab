function [ pac_out ] = biotac_reshape_pac( pac_in , bt_time)
%BIOTAC_RESHAPE_PAC reshapes the pac matrix read in ROS from the sensor
%
% function [ pac_out ] = reshape_pac( pac_in , bt_time)
%
%   pac_in is Mx23 where M is the number of message frames. First column is
%   the ROS timestamp in [nsec]. Each message frame is sampled at 100 Hz and within each
%   frame comes 22 PAC messages sampled at 2.2Khz
% 
%   bt_time contains the time offsets of each signal component within the
%   message frame and the start time of each frame.
%
%   pac_out is an (M*22)x2 vector. First column contains timestamp in
%   nanosec and second column the PAC values.

    pac_out = zeros(size(pac_in,1)*22, 2);
    
    for i = 1:size(pac_in,1)
       pac_out((i*22-21):(i*22),1) = bt_time(i, 2) + 2.2730e5 + [0:21]'*(1/2200)*1e9;
    end
    
    pac_out(:,2) = reshape(pac_in(:, 2:end)', [], 1);


end

