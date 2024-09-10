#!/bin/bash

# some helpful debugging options
set -e
set -u

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load jq pigz parallel libnvidia-container enroot
CONTAINER_NAME="mycontainer"

# Check if container already exists using enroot list
if ! enroot list | grep -q "^${CONTAINER_NAME}\$"; then
    enroot create --force --name $CONTAINER_NAME ${HOME}/mytag.sqsh
fi

# run a shell 
# Ensures that the run_training doesn't try using cuda
enroot start \
       --mount /nobackup/autodelete/usr/${USER}:/home/${USER}/compute --rw \
       --mount ${HOME}/hf_models:/app/hf_models \
       --mount ${HOME}/output_model:/app/output_model \
       $CONTAINER_NAME \
       bash -c "export CUDA_VISIBLE_DEVICES='' && ./run_training.sh --max_train_steps=0"
