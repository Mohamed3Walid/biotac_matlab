biotac_matlab
=============
Overview
---------------------------------------------
Matlab functions for extracting and plotting biotac data from rosbag files.




Exporting from ROS bag to .txt
---------------------------------------------
Various scripts for exporting biotac data from **rosbag files** to matlab redable **.txt** files

Add this directory to your env variable ''PATH'' and then source your .bashrc:

    echo "export PATH=<export_rosbag_directory>:$PATH" >> ~/.bashrc
    source ~/.bashrc

Then to export e.g. electrode data:

    biotac_export_electrode <rosbag_file> <output_prefix>

Two arguments are used, the first one is the `rosbag file` and the second one the ''output file prefix''
Produces an **\<output_prefix\>_electrode.txt** file. For exporting everything use the **biotac_export_data** command.

Importing into Matlab
---------------------------------------------
Use the biotac_data class contained in the **@biotac_data** directory

1. Add the directory to `biotac_matlab` to your MATLAB path
2. Create a biotac_data object:

    x = biotac_data();
    x.load_data('prefix'); 
    display(x);

Where **'prefix'** is the prefix used previously for exporting from ROS bags to .txt files (e.g. exp1_electrode1.txt, exp1_pac1.txt).
