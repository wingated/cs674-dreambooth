#!/bin/bash

sudo docker run -it \
  --rm \
  --gpus all \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  --cap-add=SYS_ADMIN \
  --shm-size=1g \
  -v /home/wingated/dreambooth/hf_models:/app/hf_models \
  -v /home/wingated/dreambooth/output_model:/app/output_model \
  my/dreambooth:0.1  
  #  pytorch/pytorch:latest

