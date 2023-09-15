#!/bin/bash

#SBATCH --time=1:00:00   # walltime.  hours:minutes:seconds
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --gpus=1
#SBATCH --mem-per-cpu=64000M   # 64G memory per CPU core
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --qos=cs
#SBATCH --partition=cs

# some helpful debugging options
set -e
set -u

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load jq zstd pigz parallel libnvidia-container enroot                                                                                                   
                                                                                                                                                               
CONTAINER_NAME="mycontainer"

# Check if container already exists using enroot list
if ! enroot list | grep -q "^${CONTAINER_NAME}\$"; then
    enroot create --force --name $CONTAINER_NAME ${HOME}/mytag.sqsh
fi                                                                                                                                             
                                                                                                                                                               
# run a shell                                                                                                                                                  
enroot start \
       --mount /lustre/scratch/usr/${USER}:/home/${USER}/compute --rw \
       --mount ${HOME}/hf_models:/app/hf_models \
       --mount ${HOME}/output_model:/app/output_model \
       mycontainer \
       ./run_training.sh --max_train_steps=400 --local_files_only # the name of the command INSIDE THE CONTAINER that you want to run
       