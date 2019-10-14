%基于图的聚类图表统计
clc;clear;
EcoliSpectral=load('ecoli_10_sigma0.3_unnormalized.mat');
DUMSpectral=load('DUM_10_sigma0.05_unnormalized.mat');
IrisSpectral=load('Iris_sigma2430844_unnormalized.mat');
MovementLibrasSpectral=load('MovementLibras_sigma0.28_unnormalized.mat');
WineSpectral=load('Wine_sigma26424_unnormalized.mat');
WineQualitySpectral=load('WineQuality_sigma2.8_unnormalized.mat');

totalEL=getTotalSpectral(EcoliSpectral);
totalDUM=getTotalSpectral(DUMSpectral);
totalIris=getTotalSpectral(IrisSpectral);
totalML=getTotalSpectral(MovementLibrasSpectral);
totalWine=getTotalSpectral(WineSpectral);
totalWQ=getTotalSpectral(WineQualitySpectral);

%Iris
subFigIris=subplot(3,2,1);
bar(totalIris);
title('Iris');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%Wine
subFigWine=subplot(3,2,2);
bar(totalWine);
title('Wine');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%DUM
subFigDUM=subplot(3,2,3);
bar(totalDUM);
title('Data User Modeling');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%MovementLibras
subFigML=subplot(3,2,4);
bar(totalML);
title('Movement Libras');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%Ecoli
subFigEL=subplot(3,2,5);
bar(totalEL);
title('Ecoli');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});
%Wine Quality
subFigWQ=subplot(3,2,6);
bar(totalWQ);
title('Wine Quality Red');
set(gca,'XTickLabel',{'ENT','ACC','FMI','JCI'});

hl=legend('SCN1','NC','Ours','SCN2','Location','northoutside');
set(hl,'Orientation','horizon');