# OSA outcome prediction
Use of AI to study the predictability of the outcome of OSA

This repository is related to the paper titled: "Quantitative and Morphology-based Deep Convolutional Neural Network  Approaches for Osteosarcoma Survival Prediction in the Neoadjuvant and metastatic Setting." It is provided as is for research purpose and must not be use in clinical practice. 

## Required packages
To run the code you need to install [DeepPATH](https://github.com/ncoudray/DeepPATH) and [HPL](https://github.com/AdalbertoCq/Histomorphological-Phenotype-Learning). 
Both pages include detailed description on the libraries to install as well as the meaning of the options used here.

The code here was developed using the slurm executor on NYU's [UltraViolet HPC cluster](https://med.nyu.edu/research/scientific-cores-shared-resources/high-performanc
e-computing-core). The python script is therefore here given with slurm headers appropriate for this cluster as example so they could easily be adapted.  

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
### 1.c. Concert to TFRecord
```shell
mkdir 1c_TFRecord_test
sbatch sb_1c_tf.sh
```

### 1.d. Segment the images
```shell
sbatch sb_1d_segment.sh
```

## 2. Self-supervised outcome prediction from segmented regions
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

### 2.b. Convert to TFRecord
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




