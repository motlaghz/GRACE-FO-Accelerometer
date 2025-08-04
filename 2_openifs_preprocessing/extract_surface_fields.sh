#!/bin/bash

module load cdo # cdo is used in this script

for n in {0..8}; do
    
    for day in {01..31}; do # Iterate over days {01..30}
        for halfday in 00 12; do 
	        for hour in {1..12}; do
	        
    	        date=202012${day}
        	    full_date=${date}${halfday}

        	    ## make directories 
        	    out_dir=$HOME/Fields
        	    test -d ${out_dir} || mk_dir ${out_dir}

              # OpenIFS files
        	    input_dir=$HOME/OpenIFS/t639/${full_date}
        
        	    # Read OpenIFS files
        	    printf -v hr "%02d" $hour
              
        	    cdo selcode,178 ${input_dir}/oifs_surf_${in_dir}+0${hr} ${out_dir}/tsr_${date}_${hour}hr_gnss.grb
        	    cdo selcode,179 ${input_dir}/oifs_surf_${in_dir}+0${hr} ${out_dir}/ttr_${date}_${hour}hr_gnss.grb
        	    cdo selcode,212 ${input_dir}/oifs_surf_${in_dir}+0${hr} ${out_dir}/tisr_${date}_${hour}hr_gnss.grb
        
        	    cdo -f nc copy ${out_dir}/tsr_${date}_${hour}hr_gnss.grb ${out_dir}/tsr_${date}_${hour}hr.nc
        	    cdo -f nc copy ${out_dir}/ttr_${date}_${hour}hr_gnss.grb ${out_dir}/ttr_${date}_${hour}hr.nc
        	    cdo -f nc copy ${out_dir}/tisr_${date}_${hour}hr_gnss.grb ${out_dir}/tisr_${date}_${hour}hr.nc
        
        	    # Divide the values by 3600 because they are accumulated
        	    # Add a minus sign to ttr because it is negative (we need positive)
        	    cdo divc,-3600 ${out_dir}/ttr_${date}_${hour}hr.nc ${out_dir}/longwave_${date}_${hour}hr_gnss.nc
        	    cdo divc,3600 ${out_dir}/tsr_${date}_${hour}hr.nc ${out_dir}/tsr_${date}_${hour}hr_gnss.nc
        	    cdo divc,3600 ${out_dir}/tisr_${date}_${hour}hr.nc ${out_dir}/tisr_${date}_${hour}hr_gnss.nc
        	    
        	    # Calculate albedo with a python code
        	    python3 $HOME/Acc_scripts/script_for_albedo.py  ${out_dir} ${date} ${hour}
    	    done
	    done
    done
done

# Remove files
for name in tsr tisr ttr; do
    find $HOME -type f -name "${name}*" -exec rm {} \;
done



