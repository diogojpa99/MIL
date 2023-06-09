mil_types=("instance" "embedding")
pool_types=("max" "avg" "topk" "mask_max" "mask_avg")

feature_ex="resnet18"

mask_path="../Datasets/Fine_MASKS_bea_all"
data_path="../Datasets/ISIC2019bea_mel_nevus_limpo"
dataset="ISIC2019-Clean"

#mask_path="../Datasets/PH2_TEST_FINE_MASKS"
#data_path="../Datasets/PH2_test"
#dataset="PH2"

#mask_path="../Datasets/DERM7PT_FINE_MASKS_224"
#data_path="../Datasets/derm7pt_like_ISIC2019"
#dataset="Derm7pt"

for mil_t in "${mil_types[@]}"
do
    for pool in "${pool_types[@]}"
    do

		ckpt="../aDOCS/Experiments_Saved/Binary/MIL/FeatureExtractors/$feature_ex/MIL-$feature_ex-$mil_t-$pool/MIL-$mil_t-$pool-best_checkpoint.pth"
		logdir="visualization/$mil_t-$pool/$dataset/$feature_ex"
		echo "----------------- Output dir: $logdir --------------------"

		python main.py \
			--visualize \
			--wandb \
			--num_workers 8 \
			--mil_type $mil_t \
			--pooling_type $pool \
			--feature_extractor "resnet18.tv_in1k" \
			--mask \
			--mask_val "val" \
			--mask_path $mask_path \
			--visualize_num_images 8 \
			--vis_num 10 \
			--resume $ckpt \
			--dataset $dataset \
			--data_path $data_path \
			--output_dir "$logdir"  \
			
	done
done