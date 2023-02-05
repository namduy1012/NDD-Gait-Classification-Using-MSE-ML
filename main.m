clear
clc
%% Add Function Path
addpath("Functions\")
addpath("Classifer\")
%% Define Parameter
Parameter.fs = 300;
Parameter.m = 2;           
Parameter.r = 0.2;
Parameter.scale = 6;
Parameter.name='MSamEn';
Parameter.window = 10;
Parameter.step = Parameter.window/2;
Parameter.clasiifier = 'SubspaceKNN';
%% Define Data
Gait_file = dir("./Gait-Data/*.mat"); Gait_file = {Gait_file.name}';
%% Processing & Load Data
Dataset = Processing(Gait_file,Parameter);
%% Feature Selection
Dataset = GetFeatureSelectionData(Dataset);
%% Training && Validation
switch Parameter.clasiifier
    case 'SVM'
        [Classifier, validationAccuracy,validationPredictions, validationScores] = SVM(Dataset);
    case 'SubspaceKNN'
        [Classifier, validationAccuracy, validationPredictions, validationScores] = SubspaceKNN(Dataset);
end
