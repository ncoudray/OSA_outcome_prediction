#!/bin/bash
#SBATCH --partition=fn_short
#SBATCH --job-name=2c_tumor
#SBATCH --ntasks=1
#SBATCH --output=log_2c_tumor_set0_%A_%a.out
#SBATCH  --error=log_2c_tumor_set0_%A_%a.err
#SBATCH --mem=10G

module load python/gpu/3.6.5

export CHECKPOINT_PATH='OSA/unsupervised_DeepPATH/step_C_Outcome/checkpoints_J73_Tumor_36months/fold0'
export OUTPUT_DIR='2c_tumor_fold0'
export DATA_DIR='2b_tumor_TFRecord_test'
export BASENAME='test_'
export LABEL_FILE='labels_2c.txt'
export ExpName='2c_tumor_'
export STAT_FILE_FILTER='FALSE'
declare -i RefLabel=0

# check if next checkpoint available
declare -i count=100000 
declare -i step=200000
declare -i NbClasses=2
declare -i PatientID=3



while true; do
	echo $count
	if [ -f $CHECKPOINT_PATH/model.ckpt-$count.meta ]; then
		echo $CHECKPOINT_PATH/model.ckpt-$count.meta " exists"
		export TEST_OUTPUT=$OUTPUT_DIR/test_$count'k'
		if [ ! -d $TEST_OUTPUT ]; then
			mkdir -p $TEST_OUTPUT
			# create temporary directory for checkpoints
			mkdir  -p $TEST_OUTPUT/tmp_checkpoints
			export CUR_CHECKPOINT=$TEST_OUTPUT/tmp_checkpoints
		
	
			ln -s $CHECKPOINT_PATH/*-$count.* $CUR_CHECKPOINT/.
			touch $CUR_CHECKPOINT/checkpoint
			echo 'model_checkpoint_path: "'$CUR_CHECKPOINT'/model.ckpt-'$count'"' > $CUR_CHECKPOINT/checkpoint
			echo 'all_model_checkpoint_paths: "'$CUR_CHECKPOINT'/model.ckpt-'$count'"' >> $CUR_CHECKPOINT/checkpoint

			export OUTFILENAME=$TEST_OUTPUT/out_filename_Stats.txt

			sbatch --job-name=${ExpName}_${BASENAME}_${count}  --output=rq_${ExpName}_${BASENAME}_${count}_%A.out --error=rq_${ExpName}_${BASENAME}_${count}_%A.err sb_TF_ROC_2c.sh $TEST_OUTPUT $DATA_DIR $BASENAME $NbClasses $OUTFILENAME $LABEL_FILE $CUR_CHECKPOINT $PatientID $STAT_FILE_FILTER $RefLabel
		else
			echo 'checkpoint '$TEST_OUTPUT' skipped'
		fi

	else
		echo $CHECKPOINT_PATH/model.ckpt-$count.meta " does not exist"
		break
	fi

	# next checkpoint
	count=`expr "$count" + "$step"`
done




