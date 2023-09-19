# NDD-Gait-Classification-Using-MSE-ML

<p align="center">
  <img src="https://www.mdpi.com/entropy/entropy-22-01340/article_deploy/html/images/entropy-22-01340-g002-550.jpg" alt="Computational Process">
</p>

## Overview
The increase in neurodegenerative diseases (NDD) cases is alarming, making NDD screening pivotal. Considering that NDD can result in gait abnormalities, screening for NDD through gait signals becomes a feasible strategy. This repository centers on developing an NDD classification algorithm using gait force (GF) signals, leveraging multiscale sample entropy (MSE) and machine learning models.

## Data Source
The experiments and validations are carried out using the Physionet NDD gait database.

## Methodology

1. **Preprocessing**:
   - New signals were generated from GF by applying one and two times differentiation.
   - Signals were then segmented into multiple time windows (10/20/30/60-sec).

2. **Feature Extraction**:
   - The GF signal underwent processing to extract statistical and MSE features.

3. **Data Balancing**:
   - Due to the imbalanced distribution in the Physionet NDD gait database, the synthetic minority oversampling technique (SMOTE) was applied.

4. **Classification**:
   - Two classifiers, Support Vector Machine (SVM) and k-nearest neighbors (KNN), were employed.

## Results
The classification showcased impressive accuracies across various categories:
- **Healthy Controls (HC) vs. Parkinson’s disease (PD)**: 99.90%
- **HC vs. Huntington’s disease (HD)**: 99.80%
- **HC vs. Amyotrophic Lateral Sclerosis (ALS)**: 100%
- **PD vs. HD**: 99.75%
- **PD vs. ALS**: 99.90%
- **HD vs. ALS**: 99.55%
- **HC vs. PD vs. HD vs. ALS**: 99.68%

The best results were obtained under the 10-sec time window using the KNN classifier.

## Research Paper
Further insights, methodologies, and discussions can be found in our paper published in [MDPI Entropy](https://www.mdpi.com/1099-4300/22/12/1340).
