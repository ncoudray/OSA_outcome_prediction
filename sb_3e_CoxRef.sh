#!/bin/bash
#SBATCH --partition=gpu4_dev
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G



#SBATCH  --job-name=3e_CoxReg_all
#SBATCH --output=log_3e_CoxReg_all_%A_%a.out
#SBATCH  --error=log_3e_CoxReg_all_%A_%a.err



unset PYTHONPATH
module load condaenvs/gpu/pathgan_SSL37



all_ind=os_event_ind
all_data=os_event_data

compl=results/BarlowTwins_3_J07X_epoch10/J073_J074_20x_NYU_set0/h224_w224_n3_zdim128/hdf5_J073_J074_20x_NYU_set0_he_complete_os30.h5
nadd=results/BarlowTwins_3_J07X_epoch10/J073_J074_20x_NYU_set2/h224_w224_n3_zdim128/hdf5_cohort_name_he_test.h5 

all_meta=J07X_v02_pickle2
all_pickle=utilities/J07X/fold_creation/overall_survival_NYU_3folds.pkl
ff=2

python3 ./report_representationsleiden_cox.py \
 --meta_folder  ${all_meta} \
 --matching_field samples \
 --event_ind_field ${all_ind} \
 --event_data_field ${all_data} \
 --min_tiles 10 \
 --folds_pickle ${all_pickle} \
 --h5_complete_path    ${ncompl} \
 --h5_additional_path  ${nadd} \
 --force_fold ${ff} 







