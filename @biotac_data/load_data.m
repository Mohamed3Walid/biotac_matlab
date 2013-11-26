function [obj] = load_data(obj, prefix )
%BIOTAC_LOAD_DATA loads biotac data from txt files that were exported from rosbags.
% Uses the given 'prefix' to load the txt files into the biotac_data object,
% e.g.:
% run1 = biotac_data;
% run1.load_data('run1');
%   
% function [  ] = load_data(obj, prefix )
% 

%% Electrode signals
obj.bt_time = load(strcat(prefix,'_bt_time.txt'));
obj.electrode = zeros(size(obj.bt_time,1),20,3);
obj.electrode(:,:,1) = load(strcat(prefix,'_electrode1.txt'));
obj.electrode(:,:,2) = load(strcat(prefix,'_electrode2.txt'));
obj.electrode(:,:,3) = load(strcat(prefix,'_electrode3.txt'));

% set the timestamps and the electrode signals
for n_finger = 1:3
    obj.electrode(:,:,n_finger) = [obj.bt_time(:,2)+obj.bt_time(:,29), obj.electrode(:,2:20, n_finger)];
end

%% PAC
pac = zeros(size(obj.bt_time,1),23,3);
pac(:,:,1) = load(strcat(prefix,'_pac1.txt'));
pac(:,:,2) = load(strcat(prefix,'_pac2.txt'));
pac(:,:,3) = load(strcat(prefix,'_pac3.txt'));

obj.pac = zeros(size(pac,1)*22,2,3);

% set the timestamps and PAC signals
for n_finger=1:3
    for n_pac=1:22
        obj.pac((n_pac*22-21):(n_pac)*22, 1, n_finger) = repmat(obj.bt_time(n_pac,2),22,1)+obj.bt_time(n_pac,7:28)';
        obj.pac((n_pac*22-21):(n_pac)*22, 2, n_finger) = reshape(pac(n_pac, 2:end, n_finger), [], 1);
    end
end
    
%% PDC

obj.pdc = zeros(size(obj.bt_time,1),2,3);

obj.pdc(:,:,1) = load(strcat(prefix,'_pdc1.txt'));
obj.pdc(:,:,2) = load(strcat(prefix,'_pdc2.txt'));
obj.pdc(:,:,3) = load(strcat(prefix,'_pdc3.txt'));


for n_finger=1:3
    obj.pdc(:,:,n_finger) = [obj.bt_time(:,2)+obj.bt_time(:,6), obj.pdc(:,2,n_finger)];
end

%% TAC

obj.tac = zeros(size(obj.bt_time,1),2,3);

obj.tac(:,:,1) = load(strcat(prefix,'_tac1.txt'));
obj.tac(:,:,2) = load(strcat(prefix,'_tac2.txt'));
obj.tac(:,:,3) = load(strcat(prefix,'_tac3.txt'));

for n_finger=1:3
    obj.tac(:,:,n_finger) = [obj.bt_time(:,2)+obj.bt_time(:,5), obj.tac(:,2,n_finger)];
end

%% TDC
obj.tdc = zeros(size(obj.bt_time,1),2,3);

obj.tdc(:,:,1) = load(strcat(prefix,'_tdc1.txt'));
obj.tdc(:,:,2) = load(strcat(prefix,'_tdc2.txt'));
obj.tdc(:,:,3) = load(strcat(prefix,'_tdc3.txt'));

for n_finger=1:3
    obj.tdc(:,:,n_finger) = [obj.bt_time(:,2)+obj.bt_time(:,4), obj.tdc(:,2,n_finger)];
end


end

