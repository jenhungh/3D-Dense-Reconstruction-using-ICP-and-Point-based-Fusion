# 16-824 HW1 Weakly Supervised Objeect Localization

### Environment Setup
To run the code, set up the conda environment using the command
```bash
conda env create --name envname --file=environments.yml
```

### Run the Code
Run the command in the conda environment you set up
For Q1.6
```bash
  python task_1.py --epoch 30 -lr 0.01 -b 32 --pretrained
```

For Q1.7
```bash
  python task_1.py --epoch 45 -lr 0.01 -b 32 --pretrained --arch localizer_alexnet_robust
```

For Q2.4
```bash
  python task_2.py
```

### Attached Figures
./Figures folder contains all the figures for the report.
