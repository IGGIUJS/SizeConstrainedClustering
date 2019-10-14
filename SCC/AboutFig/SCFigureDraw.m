%基于原型的聚类图表统计
clc;clear;
Ecoli=load('ecoli.mat');
DUM=load('DUM.mat');
Iris=load('Iris.mat');
MovementLibras=load('MovementLibras.mat');
Wine=load('Wine.mat');
WineQuality=load('WineQuality.mat');
EMPGA_subset_1_normal=load('EMGPA_subset_1_normal.mat');
EMPGA_subset_1and2_normal=load('EMGPA_subset_1and2_normal.mat');

totalEL=getTotal(Ecoli);
totalDUM=getTotal(DUM);
totalIris=getTotal(Iris);
totalML=getTotal(MovementLibras);
totalWine=getTotal(Wine);
totalWQ=getTotal(WineQuality);
totalEMPGA_1=getTotal(EMPGA_subset_1_normal);
totalEMPGA_1and2=getTotal(EMPGA_subset_1and2_normal);

%% Iris
subFigIris=subplot(4,2,1);
bar(totalIris);
title('Iris');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%% Wine
subFigWine=subplot(4,2,2);
bar(totalWine);
title('Wine');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%% DUM
subFigDUM=subplot(4,2,3);
bar(totalDUM);
title('Data User Modeling');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%% MovementLibras
subFigML=subplot(4,2,4);
bar(totalML);
title('Movement Libras');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%% Ecoli
subFigEL=subplot(4,2,5);
bar(totalEL);
title('Ecoli');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%% Wine Quality
subFigWQ=subplot(4,2,6);
bar(totalWQ);
title('Wine Quality Red');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%% EMGPA_subset_1_normal
subFigEMPGA_1=subplot(4,2,7);
bar(totalEMPGA_1);
title('EMGPA1');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%% EMGPA_subset_1and2_normal
subFigEMPGA_1_2=subplot(4,2,8);
bar(totalEMPGA_1and2);
title('EMGPA2');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%%
hl=legend('SCK1','KM','Ours','SCK2','Location','northoutside');
set(hl,'Orientation','horizon');