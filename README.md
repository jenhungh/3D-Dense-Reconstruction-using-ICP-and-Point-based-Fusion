# 16-824 HW3 Visual Question Answering with PyTorch

### Environment Setup
To run the code, set up the conda environment using the command
```bash
conda env create --name envname --file=environments.yml
```

### Download the VQA Dataset
Dowmlaod the training and validation data: https://visualqa.org/vqa_v1_download.html

### Load the Image Features
### (1) Download the from Google Drive  
For Task 2 and Task 3, we used GoogLeNet and ResNet-18 to generate the image features.
To download them, visit the link: https://drive.google.com/drive/folders/1hHYX3GN4_op8p6Q_xgvJD2lybS9MXhy8?usp=sharing
Download 4 .zip (task2_tmp_train.zip, task2_tmp_val.zip, task3_tmp_train.zip, task3_tmp_val.zip) files and unzip them to load the image features for Task 2 and Task 3.
### (2) Run run_feature_encoder.py to generate the image feature cache .npy file
Run the command for Task 2 (GoogLeNet) 
```bash
  python -m student_code.run_feature_encoder --model googlenet
```
Run the command for Task 3 (ResNet-18) 
```bash
  python -m student_code.run_feature_encoder --model resnet18
```

### Run the Code
Run the command for Task 2 (Simplebaseline) 
```bash
  python -m student_code.main --model coattention --batch_size 300 --num_epochs 5 --log_validation --num_data_loader_workers 0
```
Run the command for Task 3 (Co-Attention) 
```bash
  python -m student_code.main --model simple --batch_size 100 --num_epochs 10 --log_validation --num_data_loader_workers 0
```

### Visualize the Figures
./Figures folder contains all event files and figures in the report
Run the command in the conda environment you set up to visualize the figures
```bash
  tensorboard --logdir='./path/to/the/event/file'
```
