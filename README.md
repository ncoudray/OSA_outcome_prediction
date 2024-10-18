# OSA outcome prediction
Use of AI to study the predictability of the outcome of OSA

This repository is related to the paper titled: "Quantitative and Morphology-based Deep Convolutional Neural Network  Approaches for Osteosarcoma Survival Prediction in the Neoadjuvant and metastatic Setting." It is provided as is for research purpose and must not be use in clinical practice. 

## Required packages
To run the code you need to install [DeepPATH](https://github.com/ncoudray/DeepPATH) and [HPL](https://github.com/AdalbertoCq/Histomorphological-Phenotype-Learning). 
Both pages include detailed description on the libraries to install as well as the meaning of the options used here.

The code here was developed using the slurm executor on NYU's [UltraViolet HPC cluster](https://med.nyu.edu/research/scientific-cores-shared-resources/high-performanc
e-computing-core). The python script is therefore here given with slurm headers appropriate for this cluster as example so they could easily be adapted.  


The checkpoints of the trained networks can be downloaded from our [public repository](https://genome.med.nyu.edu/public/tsirigoslab/DeepLearning/OSA/).

## 1. Self-supervised segmentation using DeepPATH
For meaning of options used here, see the [DeepPATH](https://github.com/ncoudray/DeepPATH) page. This page shows how to run inference on the already trained network shown in the manuscript. 
The code below runs a loop in which 1 job per slide is launched on a slurm cluster. It also shows the options use in our process.

### 1.a. Slide tiling 
```shell
for f in `ls /path_to_slides/*svs`
do
sbatch --job-name=img_${f3}  --output=log_img_${f3}_%A.out --error=log_img_${f3}_%A.err  sb_1a_base_tile.sh  -s 299 -e 0 -j 40 -B 50 -M -1 -P 0.5050 -p -1 -D 15 -o "tiles_0um505_299px_Norm_B50_D15"  -N '57,22,-8,20,10,5' $f
```

### 1.b. Sorting
```shell
mkdir 1b_sorting
cd 1b_sorting
sbatch sb_1b_sort.sh
cd ..
```
### 1.c. Convert to TFRecord format
```shell
mkdir 1c_TFRecord_test
sbatch sb_1c_tf.sh
```

### 1.d. Segment the images
```shell
sbatch sb_1d_segment.sh
```

## 2. Supervised outcome prediction from segmented regions
### 2.a. Select tiles associated with either tumor or necrosis regions
```shell
mkdir 2a_tumor_ROI
cd 
sbatch sb_2a_tumor_select.sh
cd ..

mkdir 2a_necrosis_ROI
cd 2a_necrosis_ROI
sbatch sb_2a_necrosis_select.sh
cd ..
```

### 2.b. Convert to TFRecord format
```shell
mkdir 2b_tumor_TFRecord_test
mkdir 2b_necrosis_TFRecord_test
sbatch sb_2b_tf.sh
```

### 2.c. Inference
Checkpoints can be downloaded from our public drive. 
The scripts associated below are for fold0 and tumor regions, change the inputs and output folder accordingly to run on other folds and on necrosis.

```shell
sbatch sb_2c_tumor_fold0.sh
```

## 3. Self-supervised outcome prediction from tumor and necrosis regions
### 3.a. Convert tiles to h5 format

```shell
mkdir 3a_h5
cd 3a_h5
ln -s ../2a_necrosis_ROI/tiles_0um505_299px_Norm_B50_D15 necrosis
ln -s ../sb_2a_tumor_select.sh/tiles_0um505_299px_Norm_B50_D15 tumor
sbatch sb_3a_h5.sh
cd ..
```

### 3.b. Project tiles into the trained supervised network
The following steps are run from the HPL pipeline code; for data organization and filename conventions, see the [HPL github page](https://github.com/AdalbertoCq/Histomorphological-Phenotype-Learning). 
```shell
sbatch sb_3b_project.py
```

### 3.c. Add field to header
The `labels_my_dataset.csv` should have the following mandatory columns:
* `samples`: must match those in the h5 file
And the following columns (if no survival performance analysis is done, these can be ignored, or dummy values can be entered)
* `os_event_ind`: 1 or 0 if an event happened or data are censored
* ` os_event_data`: survival or follow-up in months

```shell
sb_3c_AddField.sh
```

### 3.d. Assign HPCs
```shell
sbatch --job-name=3d_r1  --output=log_3d_r1_%A.out --error=log_3d_r1_%A.err sb_3d_Assign_Clusters.py 1.0
```


