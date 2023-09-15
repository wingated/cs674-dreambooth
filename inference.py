from diffusers import StableDiffusionPipeline
import torch, os

def get_unique_filename(base_filename):
    counter = 1
    filename, file_extension = os.path.splitext(base_filename)
    new_filename = base_filename
    while os.path.exists(new_filename):
        new_filename = "{}_{}{}".format(filename, counter, file_extension)
        counter += 1
    return new_filename

model_id = "./output_model"
pipe = StableDiffusionPipeline.from_pretrained(model_id, torch_dtype=torch.float16).to("cuda")

prompt = "a photo of sks rubber duck at the beach"
#prompt = "PaperCut sks rubber duck at the beach"
#prompt = "woolitize, sks rubber duck in bright green grass, sun in background, fluffy, daisies"

image = pipe(prompt, num_inference_steps=50, guidance_scale=7.5).images[0]

output_filename = get_unique_filename("output_model/output.png")
image.save(output_filename)
