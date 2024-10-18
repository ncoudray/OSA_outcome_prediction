#!/bin/bash
#SBATCH --partition=cpu_medium
#SBATCH --time=30:00
#SBATCH --job-name=h5_conv
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=1
#SBATCH --output=log_3a_h5conv_%A.out
#SBATCH --error=log_3a_h5conv_%A.err
#SBATCH --mem=70GB


module unload python
module load openmpi/3.1.0-mt
module load python/cpu/3.6.5


mpirun -n 80 python DeepPATH_code/00_preprocessing/0e_jpgtoHDF.py  --input_path /path_to/3a_h5 --output hdf5_cohort_name_he_test.h5 --chunks 80 --sub_chunks 40 --wSize 224 --mode 2 --subset='test'   --sampleID=3








