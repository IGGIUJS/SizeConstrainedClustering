clc;
clear;
%   'Type' - Defines the type of spectral clustering algorithm
%            that should be used. Choices are:
%      1 - Unnormalized
%      2 - Normalized according to Shi and Malik (2000)
%      3 - Normalized according to Jordan and Weiss (2002)
sigma=1;
type=2;
%% 
% load iris.dat;
% k=3;
% data=iris;
% sizeConsMat=[50,50,50];       %iris
% gnd = [ones(50,1);ones(50,1)*2;ones(50,1)*3];%针对iris数据集的ground truth设置
% 
% load wine.dat;
% k=3;
% data=wine;
% sizeConsMat=[59,71,48];       %wine
% gnd = [ones(59,1);ones(71,1)*2;ones(48,1)*3];%针对wine数据集的ground truth设置

%KM<Kbs<S<Me<SC 不需要归一化
% load balance_scale.dat;
% k=3;
% data=balance_scale;
% sizeConsMat=[49,288,288];        %balance_scale
% gnd = [ones(49,1);ones(288,1)*2;ones(288,1)*3];%针对balance-scale数据集的ground truth设置

% % S<Me<Kbs<SC<KM 归一化
% load ionosphere.dat
% k=2;
% data=ionosphere;
% sizeConsMat=[226,125];        %ionosphere
% gnd=[ones(226,1);ones(125,1)*2;];%针对ionosphere数据集的ground truth设置  

% S<Kbs<Me<KM<SC 归一化后SC达到ACC达到1，不归一化为0.6591也是最高
% load Hill_Valley_without_noise_Testing.mat
% k=2;
% data=Hill_Valley_without_noise_Testing;
% sizeConsMat=[295,311];          %hill_without_noise_testing
% gnd=[ones(295,1);ones(311,1)*2;];%针对Hill_Valley_without_noise_Testing数据集的ground truth设置

% %Kbs<KM<Me=S<SC 不需要归一化
% load movement_libras.mat
% k=15;
% data=movement_libras;
% sizeConsMat=(ones(15,1)*24)';
% gnd=[ones(24,1);ones(24,1)*2;ones(24,1)*3;ones(24,1)*4;ones(24,1)*5;ones(24,1)*6;ones(24,1)*7;...
%      ones(24,1)*8;ones(24,1)*9;ones(24,1)*10;ones(24,1)*11;ones(24,1)*12;ones(24,1)*13;ones(24,1)*14;...
%      ones(24,1)*15;];

%  KM<Me<Kbs<S<SC 归一化
%  load winequality_red.mat
%  k=6;
%  data=winequality_red;
%  sizeConsMat=[10,53,681,638,199,18];        %winequality_red 
%  gnd = [ones(10,1);ones(53,1)*2;ones(681,1)*3;ones(638,1)*4;ones(199,1)*5;ones(18,1)*6;];%wine quailty red
%  
% Kbs<S<SC<Me<KM 不归一化
%  load DataUserModeling.txt
%  k=4;
%  data=DataUserModeling;
%  sizeConsMat=[24,88,83,63];
%  gnd=[ones(24,1);ones(88,1)*2;ones(83,1)*3;ones(63,1)*4;];    %针对DataUserModeling的ground truth设置

% load ecoli.dat
% k=8;
% data=ecoli;
% sizeConsMat=[143,77,2,2,35,20,5,52]; 
% gnd=[ones(143,1);ones(77,1)*2;ones(2,1)*3;ones(2,1)*4;ones(35,1)*5;ones(20,1)*6;ones(5,1)*7;ones(52,1)*8;];

% load subset_1_normal.mat
% k=10;
% data=subset_1_normal;
% sizeConsMat=[9830,10000,9611,9756,10000,9964,10000,9725,10000,10000];
% gnd=[ones(9830,1);ones(10000,1)*2;ones(9611,1)*3;ones(9756,1)*4;ones(10000,1)*5;ones(9964,1)*6;ones(10000,1)*7;ones(9725,1)*8;ones(10000,1)*9;ones(10000,1)*10;];
% 

load Sensorless_drive_diagnosis.mat
k=11;
data=Sensorless_drive_diagnosis;
sizeConsMat=[5319,5319,5319,5319,5319,5319,5319,5319,5319,5319,5319]; %Sensorless_drive_diagnosis
gnd=[ones(5319,1);ones(5319,1)*2;ones(5319,1)*3;ones(5319,1)*4;ones(5319,1)*5;ones(5319,1)*6;ones(5319,1)*7;ones(5319,1)*8;ones(5319,1)*9;ones(5319,1)*10;ones(5319,1)*11;];
%% 
dataLength=length(data);
% data=normalizeData(data')';
centroids=[];
for loop=1:10
%     W=CalSimilarityMat(data,1);
%     W=[
%         1,0.1,0.4,0,0,0;
%         0.1,1,0.1,0.4,0,0;
%         0.4,0.1,1,0,0.1,0.1;
%         0,0.4,0,1,0.5,0;
%         0,0,0.1,0.5,1,0;
%         0,0,0.1,0,0,0
%         ]
    centroids=[];
    tic;[result_SC_Me{loop},objVal_SC_Me(loop),centroids] =spectral_clustering(data,k,centroids,sigma,sizeConsMat,type,1);time_SC_Me(loop)=toc;
%     tic;[result_SC_S{loop},objVal_SC_S(loop)] =spectral_clustering(data,k,sigma,sizeConsMat,type,2);time_SC_S(loop)=toc;
    tic;[result_SC_Kbs{loop},objVal_SC_Kbs(loop),centroids] =spectral_clustering(data,k,centroids,sigma,sizeConsMat,type,3);time_SC_Kbs(loop)=toc;
    tic;[result_SC_KM{loop},objVal_SC_KM(loop),centroids] =spectral_clustering(data,k,centroids,sigma,sizeConsMat,type,4);time_SC_KM(loop)=toc;
 
%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    result_SC_Me{loop}=bestMap(gnd,result_SC_Me{loop});
    AC_SC_Me(loop)=length(find(gnd==result_SC_Me{loop}))/length(gnd);
    NMI_SC_Me(loop)=MutualInfo(gnd,result_SC_Me{loop});
    ARI_SC_Me(loop)=valid_RandIndex(gnd,result_SC_Me{loop});
    Outs_SC_Me=valid_external(gnd,result_SC_Me{loop});
    JC_SC_Me(loop)=Outs_SC_Me(3);
    FMI_SC_Me(loop)=Outs_SC_Me(4);
    clear Outs_SC_Me;
    Ent_SC_Me(loop)=Entropy(gnd,result_SC_Me{loop});
    
%     result_SC_S{loop}=bestMap(gnd,result_SC_S{loop});
%     AC_SC_S(loop)=length(find(gnd==result_SC_S{loop}))/length(gnd);
%     NMI_SC_S(loop)=MutualInfo(gnd,result_SC_S{loop});
%     ARI_SC_S(loop)=valid_RandIndex(gnd,result_SC_S{loop});
%     Outs_SC_S=valid_external(gnd,result_SC_S{loop});
%     JC_SC_S(loop)=Outs_SC_S(3);
%     FMI_SC_S(loop)=Outs_SC_S(4);
%     clear Outs_SC_S;
%     Ent_SC_S(loop)=Entropy(gnd,result_SC_S{loop});
%     
    result_SC_Kbs{loop}=bestMap(gnd,result_SC_Kbs{loop});
    AC_SC_Kbs(loop)=length(find(gnd==result_SC_Kbs{loop}))/length(gnd);
    NMI_SC_Kbs(loop)=MutualInfo(gnd,result_SC_Kbs{loop});
    ARI_SC_Kbs(loop)=valid_RandIndex(gnd,result_SC_Kbs{loop});
    Outs_SC_Kbs=valid_external(gnd,result_SC_Kbs{loop});
    JC_SC_Kbs(loop)=Outs_SC_Kbs(3);
    FMI_SC_Kbs(loop)=Outs_SC_Kbs(4);
    clear Outs_SC_Kbs;
    Ent_SC_Kbs(loop)=Entropy(gnd,result_SC_Kbs{loop});
    
    result_SC_KM{loop}=bestMap(gnd,result_SC_KM{loop});
    AC_SC_KM(loop)=length(find(gnd==result_SC_KM{loop}))/length(gnd);
    NMI_SC_KM(loop)=MutualInfo(gnd,result_SC_KM{loop});
    ARI_SC_KM(loop)=valid_RandIndex(gnd,result_SC_KM{loop});
    Outs_SC_KM=valid_external(gnd,result_SC_KM{loop});
    JC_SC_KM(loop)=Outs_SC_KM(3);
    FMI_SC_KM(loop)=Outs_SC_KM(4);
    clear Outs_SC_KM;
    Ent_SC_KM(loop)=Entropy(gnd,result_SC_KM{loop});
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    loop
end
%     MSE_SC_Mean=mean(MSE_SC);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    time_SC_Me_Me=mean(time_SC_Me);
    objVal_SC_Me_Mean=mean(objVal_SC_Me);
    AC_SC_Me_Mean=mean(AC_SC_Me);
    NMI_SC_Me_Mean=mean(NMI_SC_Me);
    ARI_SC_Me_Mean=mean(ARI_SC_Me);
    JC_SC_Me_Mean=mean(JC_SC_Me);
    FMI_SC_Me_Mean=mean(FMI_SC_Me);
    Ent_SC_Me_Mean=mean(Ent_SC_Me);
    
%     time_SC_S_Mean=mean(time_SC_S);
%     objVal_SC_S_Mean=mean(objVal_SC_S);
%     AC_SC_S_Mean=mean(AC_SC_S);
%     NMI_SC_S_Mean=mean(NMI_SC_S);
%     ARI_SC_S_Mean=mean(ARI_SC_S);
%     JC_SC_S_Mean=mean(JC_SC_S);
%     FMI_SC_S_Mean=mean(FMI_SC_S);
%     Ent_SC_S_Mean=mean(Ent_SC_S);
%     
    time_SC_Kbs_Mean=mean(time_SC_Kbs);
    objVal_SC_Kbs_Mean=mean(objVal_SC_Kbs);
    AC_SC_Kbs_Mean=mean(AC_SC_Kbs);
    NMI_SC_Kbs_Mean=mean(NMI_SC_Kbs);
    ARI_SC_Kbs_Mean=mean(ARI_SC_Kbs);
    JC_SC_Kbs_Mean=mean(JC_SC_Kbs);
    FMI_SC_Kbs_Mean=mean(FMI_SC_Kbs);
    Ent_SC_Kbs_Mean=mean(Ent_SC_Kbs);
    
    time_SC_KM_Mean=mean(time_SC_KM);
    objVal_SC_KM_Mean=mean(objVal_SC_KM);
    AC_SC_KM_Mean=mean(AC_SC_KM);
    NMI_SC_KM_Mean=mean(NMI_SC_KM);
    ARI_SC_KM_Mean=mean(ARI_SC_KM);
    JC_SC_KM_Mean=mean(JC_SC_KM);
    FMI_SC_KM_Mean=mean(FMI_SC_KM);
    Ent_SC_KM_Mean=mean(Ent_SC_KM);



% figure;
% plot(data(idx==1,1),data(idx==1,2),'r.','MarkerSize',12)
% hold on
% plot(data(idx==2,1),data(idx==2,2),'m.','MarkerSize',12)
% plot(data(idx==3,1),data(idx==3,2),'c.','MarkerSize',12)
% plot(data(idx==4,1),data(idx==4,2),'g.','MarkerSize',12)
% plot(data(idx==5,1),data(idx==5,2),'y.','MarkerSize',12)

