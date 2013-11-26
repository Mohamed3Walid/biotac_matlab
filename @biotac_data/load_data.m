function [obj] = load_data(obj, prefix )
%BIOTAC_LOAD_DATA loads biotac data from txt files that were exported from rosbags.
% Uses the given 'prefix' to load the txt files into the biotac_data object,
% e.g.:
% run1 = biotac_data;
% run1.load_data('run1');
%   
% function [  ] = load_data(obj, prefix )
% 

%% Fix some constants
frame_start_time_index = 2; % 1 for ROS message time stamp, 2 for frame_start_time field 

%% Electrode signals
obj.bt_time = load(strcat(prefix,'_bt_time.txt'));
obj.electrode = zeros(size(obj.bt_time,1),20,3);
obj.electrode(:,:,1) = load(strcat(prefix,'_electrode1.txt'));
obj.electrode(:,:,2) = load(strcat(prefix,'_electrode2.txt'));
obj.electrode(:,:,3) = load(strcat(prefix,'_electrode3.txt'));

% put constant delta_t from beginning of message frame 
% and eliminate big delta_t that seem to happen every 100 measurements
delta_t = obj.bt_time(1,29);
if(delta_t/1e9>0.5)  
    delta_t = obj.bt_time(2,29);
end


% set the timestamps and the electrode signals
for n_finger = 1:3
%     obj.electrode(:,:,n_finger) = [obj.bt_time(:,2)+obj.obj_bt_time(:,29), obj.electrode(:,2:20, n_finger)];
    obj.electrode(:,:,n_finger) = [obj.bt_time(:,frame_start_time_index)+delta_t, obj.electrode(:,2:20, n_finger)];
end

%% PAC
pac_ = zeros(size(obj.bt_time,1),23,3);
pac_(:,:,1) = load(strcat(prefix,'_pac1.txt'));
pac_(:,:,2) = load(strcat(prefix,'_pac2.txt'));
pac_(:,:,3) = load(strcat(prefix,'_pac3.txt'));

obj.pac = zeros(size(pac_,1)*22,2,3);

% put constant delta_t from beginning of message frame 
% and eliminate big delta_t that seem to happen every 100 measurements
delta_t = obj.bt_time(1,7:28)';
for n=1:size(obj.bt_time,1)
    delta_t = obj.bt_time(n,7:28)';
    check = delta_t/1e9>0.5;
    if(~sum(check)>0)
        break
    end
end
        

% set the timestamps and PAC signals
for n_finger=1:3
    for n_pac=1:size(pac_,1)
%         obj.pac((n_pac*22-21):(n_pac)*22, 1, n_finger) = repmat(obj.bt_time(n_pac,2),22,1)+obj.bt_time(n_pac,7:28)';
        obj.pac((n_pac*22-21):(n_pac)*22, 1, n_finger) = repmat(obj.bt_time(n_pac,frame_start_time_index),22,1)+delta_t;    
        obj.pac((n_pac*22-21):(n_pac)*22, 2, n_finger) = reshape(pac_(n_pac, 2:end, n_finger), [], 1);
    end
end
    
%% PDC

obj.pdc = zeros(size(obj.bt_time,1),2,3);

obj.pdc(:,:,1) = load(strcat(prefix,'_pdc1.txt'));
obj.pdc(:,:,2) = load(strcat(prefix,'_pdc2.txt'));
obj.pdc(:,:,3) = load(strcat(prefix,'_pdc3.txt'));

% put constant delta_t from beginning of message frame 
% and eliminate big delta_t that seem to happen every 100 measurements
delta_t = obj.bt_time(1,29);
if(delta_t/1e9>0.5)  
    delta_t = obj.bt_time(2,29);
end

for n_finger=1:3
%     obj.pdc(:,:,n_finger) = [obj.bt_time(:,2)+obj.bt_time(:,6), obj.pdc(:,2,n_finger)];
    obj.pdc(:,:,n_finger) = [obj.bt_time(:,frame_start_time_index)+delta_t, obj.pdc(:,2,n_finger)];
end

%% TAC

obj.tac = zeros(size(obj.bt_time,1),2,3);

obj.tac(:,:,1) = load(strcat(prefix,'_tac1.txt'));
obj.tac(:,:,2) = load(strcat(prefix,'_tac2.txt'));
obj.tac(:,:,3) = load(strcat(prefix,'_tac3.txt'));

% put constant delta_t from beginning of message frame 
% and eliminate big delta_t that seem to happen every 100 measurements
delta_t = obj.bt_time(1,5);
if(delta_t/1e9>0.5)  
    delta_t = obj.bt_time(2,5);
end

for n_finger=1:3
    obj.tac(:,:,n_finger) = [obj.bt_time(:,frame_start_time_index)+delta_t, obj.tac(:,2,n_finger)];
end

%% TDC
obj.tdc = zeros(size(obj.bt_time,1),2,3);

obj.tdc(:,:,1) = load(strcat(prefix,'_tdc1.txt'));
obj.tdc(:,:,2) = load(strcat(prefix,'_tdc2.txt'));
obj.tdc(:,:,3) = load(strcat(prefix,'_tdc3.txt'));

% put constant delta_t from beginning of message frame 
% and eliminate big delta_t that seem to happen every 100 measurements
delta_t = obj.bt_time(1,4);
if(delta_t/1e9>0.5)  
    delta_t = obj.bt_time(2,4);
end

for n_finger=1:3
    obj.tdc(:,:,n_finger) = [obj.bt_time(:,frame_start_time_index)+delta_t, obj.tdc(:,2,n_finger)];
end


end

