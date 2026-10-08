### --- Manually specify which BEL (LUT site) to use ---
### Available: A6LUT, B6LUT, C6LUT, D6LUT

set ABEL "D6LUT";
set BBEL "A6LUT";
set FFBEL "CFF";

### Open CSV FILE AND ACTUALLY DOING THE CONSTRAINTS

set csv_file "D:/All_SelfLearning/Prj/1_/Vivado/All_Anderson_PUF/PUF_128_Bit/PUF_128_Bit.srcs/constrs_1/imports/new/PUF_128.csv";
#set csv_file "D:/All_SelfLearning/Prj/1_/Vivado/All_Anderson_PUF/PUF_128_Bit/PUF_128_Bit.srcs/constrs_1/imports/new/PUF_128_R2.csv";
#set csv_file "D:/All_SelfLearning/Prj/1_/Vivado/All_Anderson_PUF/PUF_128_Bit/PUF_128_Bit.srcs/constrs_1/imports/new/PUF_128_R3.csv";
#set csv_file "D:/All_SelfLearning/Prj/1_/Vivado/All_Anderson_PUF/PUF_128_Bit/PUF_128_Bit.srcs/constrs_1/imports/new/PUF_128_R4.csv"
#set csv_file "D:/All_SelfLearning/Prj/1_/Vivado/All_Anderson_PUF/PUF_128_Bit/PUF_128_Bit.srcs/constrs_1/imports/new/PUF_128_R5.csv"
#set csv_file "D:/All_SelfLearning/Prj/1_/Vivado/All_Anderson_PUF/PUF_128_Bit/PUF_128_Bit.srcs/constrs_1/imports/new/PUF_128_R6.csv"
set f [open $csv_file r];
set header [gets $f];

### LOOP THROUGH EACH LINE
while {[gets $f line] >= 0} {
		set fields [split $line ,]
		lassign $fields bit Ax Ay FFx FFy CA4x CA4y Bx By CB4x CB4y
		set puf [format "PUF_INST\[%d\].anderson" $bit]
		set_property BEL $ABEL [get_cells "$puf/SRL16E_A"]
		set_property LOC [format "SLICE_X%dY%d" $Ax $Ay] [get_cells "$puf/SRL16E_A"]
		set_property BEL $BBEL [get_cells "$puf/SRL16E_B"]
		set_property LOC [format "SLICE_X%dY%d" $Bx $By] [get_cells "$puf/SRL16E_B"]
		set_property BEL $FFBEL [get_cells "$puf/FPDE_inst"]
		set_property LOC [format "SLICE_X%dY%d" $FFx $FFy] [get_cells "$puf/FPDE_inst"]
		set_property BEL CARRY4 [get_cells "$puf/CARRY4_B"]
		set_property BEL CARRY4 [get_cells "$puf/CARRY4_A"]
		set_property LOC [format "SLICE_X%dY%d" $CB4x $CB4y] [get_cells "$puf/CARRY4_B"]
		set_property LOC [format "SLICE_X%dY%d" $CA4x $CA4y] [get_cells "$puf/CARRY4_A"]
		
		
    #	Need to create the pblock in here too
		# Create unique pblock name
    set pbname [format "pblock_PUF_%d" $bit]
#    set pb_exists [llength [get_pblocks $pbname]]
#    # Check if it already exists
#    if {!pb_exists}
#    {
#      create_pblock $pbname
#    }
    create_pblock $pbname
    set pblock_range [format "SLICE_X%dY%d:SLICE_X%dY%d" $Bx $By $FFx $FFy]
    resize_pblock [get_pblocks $pbname] -add $pblock_range
    add_cells_to_pblock [get_pblocks $pbname] [get_cells -hier $puf]
    set_property CONTAIN_ROUTING 1 [  get_pblocks $pbname]
    set_property EXCLUDE_PLACEMENT 1 [get_pblocks $pbname]

} 

close $f