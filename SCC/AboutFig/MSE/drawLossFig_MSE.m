clc;clear;
%%
% Iris
load Iris.mat
hold on;
x=1:3;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止 
normalizedMSE=normalizeData(MSE_all{1}); %a数据y值
% a=(MSE_all{1}); %a数据y值 
% b=[334.4,143.2,297.4,487.2,596.2]; %b数据y值 
plot(x,normalizedMSE,'-xk'); %线性，颜色，标记 axis([0,6,0,700]) %确定x轴与y轴框图大小 

%%
% wine
load WineAdjust.mat
hold on;
x=1:2;
normalizedMSE=normalizeData(MSE_all{1}); %a数据y值
plot(x,normalizedMSE,'-oc');


%%
% wine
load DUM.mat
hold on;
x=1:4;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止 
normalizedMSE=normalizeData(MSE_all{1}); %a数据y值
plot(x,normalizedMSE,'-sk'); %线性，颜色，标记 axis([0,6,0,700]) %确定x轴与y轴框图大小 

%%
% MovementLibras
load MovementLibras.mat
hold on;
x=1:1:7;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止 
normalizedMSE=normalizeData(MSE_all{1}); %a数据y值
plot(x,normalizedMSE,'-dc'); %线性，颜色，标记 axis([0,6,0,700]) %确定x轴与y轴框图大小 

%%
% Ecoli
load Ecoli.mat
hold on;
x=1:1:6;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止 
normalizedMSE=normalizeData(MSE_all{1}); %a数据y值
plot(x,normalizedMSE,'-+r'); %线性，颜色，标记 axis([0,6,0,700]) %确定x轴与y轴框图大小 

%%
clc;clear;
% WineQualityRed
load WineQualityRed.mat
hold on;
x=1:1:5;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止 
normalizedMSE=normalizeData(MSE_all{1}); %a数据y值
plot(x,normalizedMSE,'-pb'); %线性，颜色，标记 axis([0,6,0,700]) %确定x轴与y轴框图大小 

%%
% EMPGA_1
load EMPGA_1.mat
x=1:1:24;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止 
normalizedMSE=normalizeData(MSE_all{1}(1:24)); %a数据y值
plot(x,normalizedMSE,'-hr'); %线性，颜色，标记 axis([0,6,0,700]) %确定x轴与y轴框图大小 

%%
% EMPGA_2
load EMPGA_2.mat
x=1:1:36;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止 
normalizedMSE=normalizeData(MSE_all{1}(1:36)); %a数据y值
plot(x,normalizedMSE,'-*b'); %线性，颜色，标记 axis([0,6,0,700]) %确定x轴与y轴框图大小 

%%
set(gca,'XTick',[0:2:40]) %x轴范围1-6，间隔1 
set(gca,'YTick',[0:0.1:1]) %y轴范围0-700，间隔100 
axis([0,40,0,1]); %参数1，xmin，参数2，xmax，参数3，ymin，参数4，ymax
legend('Iris','Wine','Data User Modeling','Movement Libras','Ecoli','Wine Quality Red','EMGPA1','EMGPA2'); %右上角标注 xlabel('深度') %x轴坐标描述 ylabel('时间（ms）') %y轴坐标描述
