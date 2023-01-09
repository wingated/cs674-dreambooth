FROM pytorch/pytorch:latest

RUN apt update && apt install -y git
RUN pip install git+https://github.com/huggingface/diffusers

COPY . /app
WORKDIR /app

RUN pip install -U -r ./requirements.txt

# CMD ./run_training.sh
