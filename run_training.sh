#!/bin/bash

export MODEL_NAME="CompVis/stable-diffusion-v1-4"
#export MODEL_NAME="Fictiverse/Stable_Diffusion_PaperCut_Model"  # must use "PaperCut" in prompt
#export MODEL_NAME="plasmo/woolitize" # must use "woolitize" in prompt
#export MODEL_NAME="nitrosocke/mo-di-diffusion" # must use "modern disney style" in prompt


export INSTANCE_DIR="./training_images"
export OUTPUT_DIR="./output_model"

export HF_HOME="./hf_models"

accelerate launch train_dreambooth.py \
  --pretrained_model_name_or_path=$MODEL_NAME  \
  --instance_data_dir=$INSTANCE_DIR \
  --output_dir=$OUTPUT_DIR \
  --instance_prompt="a photo of sks rubber duck" \
  --resolution=512 \
  --train_batch_size=1 \
  --gradient_accumulation_steps=1 \
  --learning_rate=5e-6 \
  --lr_scheduler="constant" \
  --lr_warmup_steps=0 \
  $1 \
  $2 
