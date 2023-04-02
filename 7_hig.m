%将点云转换为深度图像
clear
close all;
clc

%获取点云数据
[fileName,pathName]=uigetfile('*.txt','Input Data-File');   %选择要进行计算的三维点云数据文件路径

if isempty(fileName) || length(fileName) == 1
    fprintf("未选择点云文件！\n");
    return;
end
Data=importdata([pathName,fileName]);   %加载点云数据
Data=Data(:,1:3);     %取数据的一到三列
Data(isnan(Data(:,3))==1,3) = 0;

x = Data(:,1);
y = Data(:,2);
z = Data(:,3);

xMin = min(x);
xMax = max(x);
yMin = min(y);
yMax = max(y);
zMin = min(z);
zMax = max(z);

%将点云投影到xoy平面上，并转换为深度图（这里将z值的高差值作为了深度值）
imageSize = [500,500];      %指定图片的大小
rows = imageSize(1);
cols = imageSize(2);

img = -1./zeros(rows,cols);      %创建一个无穷小数组
dx = (xMax - xMin)/cols;
dy = (yMax - yMin)/rows;
for i=1:size(Data,1)
   tx = Data(i,1);
   ty = Data(i,2);
   tz = Data(i,3);
   detaz = tz - zMin;
   rowIndex = floor((ty-yMin)/dy)+1;
   colIndex = floor((tx-xMin)/dx)+1;
   if rowIndex > rows
       rowIndex = rows;
   end
   
   if colIndex > cols
      colIndex = cols;
   end
   
   if img(rowIndex,colIndex) < detaz
      img(rowIndex,colIndex) = detaz;
   end
end
img = img./(zMax - zMin)*255;        %将数据映射到0到255范围
img = uint8(img);
color = [0 0 0;jet(255)];
cmap = colormap(color);
imwrite(img,cmap,'标准求2txt.png');            %这里指定文件的输出路径
imshow(img,cmap);
