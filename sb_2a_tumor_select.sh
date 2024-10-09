#!/bin/bash
#SBATCH --partition=cpu_medium
#SBATCH --job-name=Sort
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --output=log_2a_tumor_sort_tr_%A_%a.out
#SBATCH --error=log_2a_tumor_sort_tr_%A_%a.err
#SBATCH --mem=20GB
#SBATCH --time=10:00:00


module load python/gpu/3.6.5

python DeepPATH_code/00_preprocessing/0d_SortTiles.py --SourceFolder='tiles_0um505_299px_Norm_B50_D15'--Magnification=0.505 --MagDiffAllowed=0  --SortingOption=10 --PatientID=3 --nSplit 0 --JsonFile='' --PercentTest=100 --PercentValid=0 --Balance=2 --outFilenameStats='1d_segmentation/test_76000k/out_filename_Stats_unique.txt' --expLabel=4






