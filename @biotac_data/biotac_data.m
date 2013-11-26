classdef biotac_data < handle
    %BIOTAC_DATA class containing biotac data 
    % from 3 fingers.
    
    properties
        bt_time 
        % the first column are the time stamps
        % from the second till last column is the signal
        % the last index indicates the finger number (1-3)
        
        electrode % Dim: n_samplesx20x3
        pac % Dim: n_samplesx2x3
        pdc % Dim: n_samplesx2x3
        tac % Dim: n_samplesx2x3
        tdc % Dim: n_samplesx2x3
    end
    
    methods        
        % load data from txt file *_pac1.txt, *_electro1.txt, etc
        % prefix: string prefix
        obj = load_data(obj, prefix)
        
        function plot_electrode(obj, finger)
            plot(obj.electrode(:,2:end, finger));   
            legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19');
        end
    end
    
end

