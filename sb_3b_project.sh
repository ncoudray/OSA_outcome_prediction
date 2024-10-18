#!/bin/bash
#SBATCH --partition=gpu4_short
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --gres=gpu:1

#SBATCH  --job-name=3b_project_ex
#SBATCH --output=log_3b_project_ex_%A_%a.out
#SBATCH  --error=log_3b_project_ex_%A_%a.err



module load pathganplus/3.6



python3 ./run_representationspathology_projection.py \
 --checkpoint   /OSA/self_supervised_HPL/data_model_output/BarlowTwins_3_J07X/J073_J074_20x_NYU_set0/h224_w224_n3_zdim128/results/epoch_10/checkpoints/BarlowTwins_3_J07X.ckt \
 --real_hdf5 dataset/cohort_name/he/patches_h224_w224/hdf5_cohort_name_he_test.h5 \
 --dataset cohort_name \
 --model BarlowTwins_3_J07X_epoch10




