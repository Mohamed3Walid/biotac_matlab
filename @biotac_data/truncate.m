function [ obj2 ] = truncate(obj, time_interval )
%TRUNCATE returns biotac_data object with signals truncated 
% to a given time_interval
%
% function [ obj2 ] = TRUNCATE(obj, time_interval )
%
% time_interval: 2 dimensional vector [t_start, t_end] in seconds

obj2 = biotac_data();
t_start = time_interval(1);
t_end = time_interval(2);

if(t_start>t_end)
    error('t_start > t_end');
end


[Y, start_index] = min(abs(obj.bt_time(:,1)-(t_start*1e9+obj.bt_time(1,1))));
[Y, stop_index] = min(abs(obj.bt_time(:,1)-(t_end*1e9+obj.bt_time(1,1))));

obj2.bt_time = obj.bt_time(start_index:stop_index,:);
obj2.electrode = obj.electrode(start_index:stop_index,:,:);
obj2.pdc = obj.pdc(start_index:stop_index,:,:);
obj2.tac = obj.tac(start_index:stop_index,:,:);
obj2.tdc = obj.tdc(start_index:stop_index,:,:);


[Y, start_index] = min(abs(obj.pac(:,1)-(t_start*1e9+obj.pac(1,1))));
stop_index = start_index + size(obj2.bt_time,1)*22-1;
obj2.pac = obj.pac(start_index:stop_index, :,:);


end

