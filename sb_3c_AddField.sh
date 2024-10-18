#!/bin/bash
#SBATCH --partition=gpu4_medium
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G

#SBATCH  --job-name=3c_label
#SBATCH --output=log_3c_label_%A_%a.out
#SBATCH  --error=log_3c_label_%A_%a.err


module load pathganplus/3.6


python3 ./utilities/h5_handling/nc_create_metadata_h5.py \
  --meta_file  labels_my_dataset.csv \
  --matching_field samples \
  --list_meta_field os_event_ind os_event_data \
  --h5_file  results/BarlowTwins_3_J07X_epoch10/J073_J074_20x_NYU_set2/h224_w224_n3_zdim128/hdf5_cohort_name_he_test.h5 \
   --meta_name os

