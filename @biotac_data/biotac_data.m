classdef biotac_data < handle
    %BIOTAC_DATA class containing biotac data 
    % from 3 fingers.
    
    properties
        bt_time % Dim: n_samplesx47
        
        % the first column are the time stamps in [ns]
        % from the second till last column is the signal
        % the last index indicates the finger number (1-3)        
        electrode % Dim: n_samplesx20x3
        pac % Dim: n_samples*22x2x3
        pdc % Dim: n_samplesx2x3
        tac % Dim: n_samplesx2x3
        tdc % Dim: n_samplesx2x3
    end
    
    methods        
        % load data from txt file *_pac1.txt, *_electro1.txt, etc
        % prefix: string prefix
        obj = load_data(obj, prefix);
        
        obj = plot_pac_fft(obj, finger);
        
        obj2 = truncate(obj, t_interval);
         
             
        function plot_electrodes(obj,electrodes,finger)
            %PLOT_ELECTRODES plots the electrode values from a particular
            %finger
            %
            % 'electrodes' argument is array containing electrodes that we
            % wish to plot. For plotting all of them do electrodes=(1:19).
            plot(obj.electrode(:,electrodes+1,finger));
            electrode_numbers = num2str(electrodes(:));
            legend(electrode_numbers);
        end
        
        function plot_pac(obj, finger)
            plot((obj.pac(:,1,finger)-obj.pac(1,1,finger))/1e9, obj.pac(:,2,finger));
            xlabel('sec');
        end
        
        function plot_pdc(obj, finger)
            plot((obj.pdc(:,1,finger)-obj.pac(1,1,finger))/1e9, obj.pdc(:,2,finger));
            xlabel('sec');
        end
        
        function plot_tac(obj, finger)
            plot((obj.tac(:,1,finger)-obj.pac(1,1,finger))/1e9, obj.tac(:,2,finger));
            xlabel('sec');
        end
        
        function plot_tdc(obj, finger)
            plot((obj.tdc(:,1,finger)-obj.pac(1,1,finger))/1e9, obj.tdc(:,2,finger));
            xlabel('sec');
        end
                
    end
    
end

