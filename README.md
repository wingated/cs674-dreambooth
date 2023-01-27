
All of this is based on the huggingface examples:

https://github.com/huggingface/diffusers/tree/main/examples/dreambooth

We're improving this for CS 280.

To run it, log into the supercomputer, then:

```bash
git clone https://github.com/wingated/cs674-dreambooth.git

module load charliecloud/0.26
cd cs674-dreambooth/
ch-image build --force -t mytag .
ch-builder2tar mytag ${HOME}
mkdir ${HOME}/output_model
mkdir ${HOME}/hf_models
mkdir ${HOME}/tags
bash setup_mytag.sh
sbatch --output ./output_results.txt --mail-user YOUR_EMAIL_HERE --job-name "dreambooth test" run_mytag.sh
```
