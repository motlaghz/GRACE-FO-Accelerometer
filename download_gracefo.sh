#!/bin/bash

# Define the base directory where you want to create the folders
base_dir="$HOME/GRACE-Obs"

# Year and Month
year_month="2020-12"

# GRACE-FO release
rl="04"

# GRACE-C is only satellite we are interested in
sat="C"

# Loop over days
for t in {01..31}; do
  # Construct file name
  tgz_file="gracefo_1B_${year_month}-${t}_RL${rl}.ascii.noLRI.tgz"
  url="https://archive.podaac.earthdata.nasa.gov/podaac-ops-cumulus-protected/GRACEFO_L1B_ASCII_GRAV_JPL_RL${rl}/$tgz_file"

  # Download them
  wget -P "$base_dir" "$url"
  
  # Create a directory path based on the current var and cd values (if don't exist)
  dir_path="${base_dir}/gracefo_1B_${year_month}-${t}/"
  mkdir -p "$dir_path"
  
  for var in GNV ACT THR SCA; do
    # Extract the tar.gz file into the directory
    tar -zxvf "${base_dir}/${tgz_file}" -C "$dir_path" --wildcards "${var}1B_${year_month}-${day}_${sat}_${rl}.txt"

  done
  
  # Delete archive to save space
  rm "${base_dir}/$tgz_file"
done
