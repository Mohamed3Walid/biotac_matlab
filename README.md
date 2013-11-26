biotac_matlab
=============
Overview
---------------------------------------------
Matlab functions for extracting and plotting biotac data from rosbag files.




export_rosbag
---------------------------------------------
Various scripts for exporting biotac data from **rosbag files** to matlab redable **.txt** files

Add this directory to your env variable ''PATH'' :

    echo "export PATH=<export_rosbag_directory>:$PATH" >> ~/.bashrc

Two arguments are used, the first one is the ''rosbag file'' and the second one the ''output file prefix''
Then to export e.g. electrode data:

    biotac_export_electrode <rosbag_file> <output_prefix>

Produces an **\<output_prefix\>_electrode.txt** file. For exporting everything use the **biotac_export_data** command.
