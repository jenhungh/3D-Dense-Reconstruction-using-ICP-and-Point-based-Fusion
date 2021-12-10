# 16-824 Project - Object Detection on Blurry Images

The code for SSD and FF-SSD is modified from [SSD](https://github.com/lufficc/SSD) and [FF-SSD](https://github.com/faizwhb/ssd-pytorch).

### Environment Setup
To run the code, set up the conda environment using the command
```bash
conda create --name <env> --file=requirements.txt
```

### Download the Flickr-27 and ALDI Dataset
Dowmlaod the training and testinfg data: https://drive.google.com/drive/folders/18ZS0Eq6L4qrR82O3nHqHjhlulQYFL7rM?usp=sharing
Unzip the dataset folder and put it in the main folder.
Both Flickr-27 and ALDI Dataset are pre-processed into VOC format and contains clear and blurry images.

### Download the trained model
Dowmlaod the trained models: https://drive.google.com/drive/folders/18ZS0Eq6L4qrR82O3nHqHjhlulQYFL7rM?usp=sharing
Unzip the outputs folder and put it in the main folder.
The outputs folder contains all pre-trained models:
(1) ALDI dataset - original, data augmentation, FF-SSD
(2) Flickr-27 dataset - original, data augmentation 

### Download the demo images
Dowmlaod the demo images: https://drive.google.com/drive/folders/18ZS0Eq6L4qrR82O3nHqHjhlulQYFL7rM?usp=sharing
Unzip the demo folder and put it in the main folder.
The demo folder contains clear images and blurry images of different level for both datasets

### Train the Networks
### (1) SSD  
Run the command to train the SSD Network 
```bash
python train.py --config-file configs/vgg_ssd300_voc0712.yaml --save_step save_steps_you_want --eval_step eval_step_you_want
```
### (2) FF-SSD
Modify the ./modeling/backbone/vgg.py
Uncomment: line 65, 71, 84-86, 119-132, 220-223
Comment out: line 64, 72, 111-116, 224

Run the command to train the FF-SSD Network 
```bash
python train.py --config-file configs/vgg_ssd300_voc0712.yaml --save_step save_steps_you_want --eval_step eval_step_you_want
```

### Run the Demo
Run the command for the demonstration
```bash
python demo.py --config-file configs/vgg_ssd300_voc0712.yaml --ckpt ./path/to/the/final_model.pth --images_dir path/to/the/demo/images --anno_dir path/to/the/demo/annotations
--output_dir path/for/output_files
```

an example:
```bash
python demo.py --config-file configs/vgg_ssd300_voc0712.yaml --ckpt ./outputs/vgg_ssd300_voc0712_aldi_improve/model_final.pth --images_dir demo/aldi --anno_dir demo/Annotations/aldi --output_dir demo/result
```
