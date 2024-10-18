#!/bin/bash
#SBATCH --partition=gpu4_dev
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G

#SBATCH  --job-name=3f_CoxReg_Ind
#SBATCH --output=log_3f_CoxReg_%A_%a.out
#SBATCH  --error=log_3f_CoxReg_%A_%a.err



unset PYTHONPATH
module load condaenvs/gpu/pathgan_SSL37


all_ind=os_event_ind
all_data=os_event_data

Opt=0
if [ ${Opt} -eq 0 ]
then
	norg=results/BarlowTwins_3_J07X_epoch10/J073_J074_20x_NYU_set0/h224_w224_n3_zdim128/hdf5_J073_J074_20x_NYU_set0_he_complete_os30.h5
	nadd=results/BarlowTwins_3_J07X_epoch10/J073_J074_20x_NYU_set0/h224_w224_n3_zdim128/hdf5_J173_J174_20x_Charles_he_test_os30.h5
	ff=2
        nfolder=J07X_v03_OS_ff${ff}
	all_pickle=utilities/J07X/fold_creation/overall_survival_NYU_3folds.pkl
	nres=1.0
	nlrat=0.0
	nalpha=0.009
fi

python3 ./report_representationsleiden_cox_individual.py \
--meta_folder ${nfolder} \
--matching_field samples \
--event_ind_field ${all_ind} \
--event_data_field ${all_data} \
--folds_pickle ${all_pickle} \
 --h5_complete_path    ${norg} \
 --h5_additional_path  ${nadd} \
--resolution ${nres} \
--force_fold ${ff} \
--l1_ratio  ${nlrat} \
--alpha ${nalpha}  \
--min_tiles 10  

