# OSA outcome prediction
Use of AI to study the predictability of the outcome of OSA

This repository is related to the paper titled: "Quantitative and Morphology-based Deep Convolutional Neural Network  Approaches for Osteosarcoma Survival Prediction in the Neoadjuvant and metastatic Setting." It is provided as is for research purpose and must not be use in clinical practice. 

## Required packages
To run the code you need to install [DeepPATH](https://github.com/ncoudray/DeepPATH) and [HPL](https://github.com/AdalbertoCq/Histomorphological-Phenotype-Learning). 
Both pages include detailed description on the libraries to install as well as the meaning of the options used here.

The code here was developed using the slurm executor on NYU's [UltraViolet HPC cluster](https://med.nyu.edu/research/scientific-cores-shared-resources/high-performanc
e-computing-core). The python script is therefore here given with slurm headers appropriate for this cluster as example so they could easily be adapted.  

## Self-supervise segmentation using DeepPATH



