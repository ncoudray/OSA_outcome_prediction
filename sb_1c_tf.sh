#!/bin/bash
#SBATCH --partition=gpu4_short
#SBATCH --job-name=tf_conversion
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --output=log_1c_tf_%A_%a.out
#SBATCH  --error=log_1c_tf_%A_%a.err
#SBATCH --mem=80GB
#SBATCH --gres=gpu:1

module load anaconda3/gpu/5.2.0 
if [[ $CONDA_SHLVL == 1 ]]; then conda deactivate; fi
conda activate env_deepPath
unset PYTHONPATH

python DeepPATH_code/00_preprocessing/TFRecord_2or3_Classes/build_TF_test.py --directory='1b_sorting'  --output_directory='1c_TFRecord_test' --num_threads=1 --one_FT_per_Tile=False --ImageSet_basename='test' --version 2 













