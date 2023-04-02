clc;
clear;

% 加载需要去噪的点云
ptCloudIn = pcread('biaozhunqiu.ply');

% 可视化原始点云
figure;
pcshow(ptCloudIn);
title('含有高斯噪声的点云');
xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)');

% 执行第一次去噪
ptCloudOut_1 = pcdenoise(ptCloudIn);

% 可视化去噪后点云(第一次)
figure;
pcshow(ptCloudOut_1);
title('第一次去噪后的点云');
xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)');

[ptCloudOut_2,inlierIndices,outlierIndices] = pcdenoise(ptCloudOut_1);

% 可视化去噪后点云(第二次)
figure;
pcshow(ptCloudOut_2);
title('第二次去噪后的点云');
xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)');

% 提取内点点云并可视化，结果与ptCloudOut_2 一致
cloud_inlier = select(ptCloudOut_1,inlierIndices); % 注意，select()的第一个参数不能设置为最初的ptCloudIn，因为inlierIndices是在ptCloudOut_1的索引
figure;
pcshow(cloud_inlier);
title('第二次去噪后的内点');
xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)');

% 提取外点点云并可视化
cloud_outlier = select(ptCloudOut_1,outlierIndices);  % 注意，select()的第一个参数不能设置为最初的ptCloudIn，因为inlierIndices是在ptCloudOut_1的索引
figure;
pcshow(cloud_outlier);
title('第二次去噪后的外点');
xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)');

figure;
pcshowpair(cloud_outlier,cloud_inlier);
title('内点与外点');
xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)');

% 保存去噪后的点云
pcwrite(biaozhunqiu_2,'ptCloud_inliers.ply','Encoding','binary');		
pcwrite(biaozhunqiu_2,'ptCloud_inliers.pcd','Encoding','binary');	
	