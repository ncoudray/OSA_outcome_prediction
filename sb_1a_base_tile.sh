#!/bin/bash
#SBATCH --partition=fn_short
#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=10GB

module load anaconda3/gpu/5.2.0
conda activate env_deepPath
unset PYTHONPATH

echo $@

python DeepPATH_code/00_preprocessing/0b_tileLoop_deepzoom6.py $@


