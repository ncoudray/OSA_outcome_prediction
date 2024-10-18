#!/bin/bash
#SBATCH --partition=fn_medium
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G


unset PYTHONPATH
x=$(printf %.2f $1)
echo $x

module load singularity/3.9.8
singularity shell  --bind /Histomorphological-Phenotype-Learning:/mnt docker://gcfntnu/scanpy:1.7.0 << eof
cd /mnt/

python3 ./run_representationsleiden_assignment.py \
 --meta_field J07X_v02_pickle2 \
 --folds_pickle overall_survival_NYU_3folds.pkl \
 --h5_complete_path    results/BarlowTwins_3_J07X_epoch10/J073_J074_20x_NYU_set0/h224_w224_n3_zdim128/hdf5_J073_J074_20x_NYU_set0_he_complete_os30.h5 \
 --resolution $1 \
 --h5_additional_path results/BarlowTwins_3_J07X_epoch10/J073_J074_20x_NYU_set0/h224_w224_n3_zdim128/hdf5_cohort_name_he_test_os.h5

 

eof


