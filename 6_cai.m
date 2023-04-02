%% ************清理环境**************
clear
close all
clc

%% **********获取点云数据************
[fileName,pathName]=uigetfile('*.pcd','Input Data-File');   %选择要进行计算的三维点云数据文件路径

if isempty(fileName) || length(fileName) == 1
    fprintf("未选择点云文件！\n");
    return;
end
pc=pcread([pathName,fileName]);   %加载点云数据
disp("读取点云成功!")

%% **********进行下采样************
randomPC = pcdownsample(pc,"random",0.1);       %随机下采样，0.1为百分比
gridPC = pcdownsample(pc,"gridAverage",0.1);   %体素下采样，0.01为体素大小
nonuniformGridPC = pcdownsample(pc,"nonuniformGridSample",10);  %非均匀网格下采样，10位最大点数

%% ***********可视化************
hold on;grid on;rotate3d on;
subplot(1,2,1)
pcshow(pc)
title("原始点云")
subplot(1,2,2)
pcshow(randomPC)
title("随机下采样")

figure;hold on;grid on;rotate3d on;
subplot(1,2,1)
pcshow(pc)
title("原始点云")
subplot(1,2,2)
pcshow(gridPC)
title("体素下采样")

figure;hold on;grid on;rotate3d on;
subplot(1,2,1)
pcshow(pc)
title("原始点云")
subplot(1,2,2)
pcshow(nonuniformGridPC)
title("非均匀网格下采样")

