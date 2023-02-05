function Dataset = Processing(Gait_file,Parameter)
    fs = Parameter.fs;
    m = Parameter.m;          
    r = Parameter.r;
    scale = Parameter.scale;
    name = Parameter.name;
    window = Parameter.window*fs;
    step = Parameter.step*fs;
    if ~exist('./Processed-Data')
        mkdir Processed-Data
        Dataset = LoadNProcess(Gait_file,window,step,fs,scale,m,r,name);
        save('./Processed-Data/Dataset.mat','Dataset')
        Dataset = CombineTable(Dataset);
    else
        load('./Processed-Data/Dataset.mat')
        Dataset = CombineTable(Dataset);
    end
end
function Dataset = LoadNProcess(Gait_file,window,step,fs,scale,m,r,name)
    Dataset = [];
    for i = 1:length(Gait_file)
        load(['./Gait-Data/',Gait_file{i}]);
        %% Left Signal
        Left = Remove_Time_Localized_Frequency_Components(mean(reshape(val(1,:),3,[])), ...
                                                               fs/3);
        [Left,~] = Feature_Extraction_N_Labeling(Left,Gait_file{i},'L',window/3,step/3,scale,m,r,name);
        %% Right Signal
        Right = Remove_Time_Localized_Frequency_Components(mean(reshape(val(2,:),3,[])), ...
                                                               fs/3);
        [Right,~] = Feature_Extraction_N_Labeling(Right,Gait_file{i},'R',window/3,step/3,scale,m,r,name);
        %% Average Signal
        Ave = Remove_Time_Localized_Frequency_Components(mean(reshape(mean(val),3,[])), ...
                                                               fs/3);
        [Ave,Label] = Feature_Extraction_N_Labeling(Ave,Gait_file{i},'A',window/3,step/3,scale,m,r,name);

        Dataset{i,1} = [Left Right Ave];Dataset{i,1}.Label = Label;
    end
end