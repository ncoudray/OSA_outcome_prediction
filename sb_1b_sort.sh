#!/bin/bash
#SBATCH --partition=cpu_medium
#SBATCH --job-name=Sort
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --output=log_1b_sort_ts_%A_%a.out
#SBATCH --error=log_1b_sort_ts_%A_%a.err
#SBATCH --mem=10GB
#SBATCH --time=1:00:00


module load python/gpu/3.6.5

python DeepPATH_code/00_preprocessing/0d_SortTiles.py --SourceFolder='../tiles_0um505_299px_Norm_B50_D15' --Magnification=0.505 --MagDiffAllowed=0 --SortingOption=19 --PatientID=3 --nSplit 0 --JsonFile='' --PercentTest=100 --PercentValid=0 --Balance=2



