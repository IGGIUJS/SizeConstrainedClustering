clc;
clear;
% load iris.dat;
% load wine.dat;
% load balance_scale.dat
% load ionosphere.dat
% load Hill_Valley_without_noise_Testing.mat
% load movement_libras.dat
% load winequality_red.mat
% load DataUserModeling.txt
% load winequality_white.mat
% load glass.mat   
% load ecoli.dat
% load subset_1_normal.mat
% load subset_1_all.mat
load subset_1_2_normal.mat
% load Sensorless_drive_diagnosis.mat

%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Clustering Statistic
row=1;
count=1;
%start clustering processing
% sizeConsMat=[50,50,50];       %iris
% sizeConsMat=[59,71,48];       %wine
% sizeConsMat=[49,288,288];     %balance_scale
% sizeConsMat=[226,125];        %ionosphere
% sizeConsMat=[295,311];          %hill_without_noise_testing
% sizeConsMat=(ones(15,1)*24)';
% sizeConsMat=[10,53,681,638,199,18];        %winequality_red 
% sizeConsMat=[24,88,83,63];           %DataUserModeling
% sizeConsMat=[20,163,145,2198,880,175,5]; %winequality_white 太大，对于匈牙利要计算很长时间
% sizeConsMat=[494,46];
% sizeConsMat=[125,125,10,187,353];
% sizeConsMat=[70,76,17,13,9,29];         %glass
% sizeConsMat=[143,77,2,2,35,20,5,52];     %ecoli
% sizeConsMat=[9830,10000,9611,9756,10000,9964,10000,9725,10000,10000]; %subset_1_normal
% sizeConsMat=[9830,10000,9611,9756,10000,9964,10000,9725,10000,10000,9772,9811,10000,10000,10000,9659,9637,9676,9829,9788]; %subset_1_all
sizeConsMat=[19760,20000,19611,19756,20000,19964,20000,19725,20000,20000]; %subset_1_2_normal
% sizeConsMat=[5319,5319,5319,5319,5319,5319,5319,5319,5319,5319,5319]; %Sensorless_drive_diagnosis

% data{count}=iris;
% data{count}=wine;
% data{count}=balance_scale;
% data{count}=ionosphere;
% data{count}=Hill_Valley_without_noise_Testing;
% data{count}=movement_libras;
% data{count}=winequality_red;
% coeff=pca(data{count});
% data{count}=data{count}*coeff(:,1:2);
% data{count}=DataUserModeling;
% data{count}=winequality_white;
% data{count}=round(rand(800,2)*100);
% data{count}=glass;
% data{count}=ecoli;
data{count}=subset_1_2_normal;
% data{count}=Sensorless_drive_diagnosis;

% data{count}=normalizeData(data{count}')';

% try
    for loop=1:1             %跑10次聚类，统计ACC&NMI的平均值
        dataLength=length(data{1});
        for k=length(sizeConsMat)
            [~,u]=kmeanspp(data{count}',k);
            u=u';
%             the original author algorithm
%             tic;
%             [MSE_S(loop),result_S{loop}]=SizeConsHung(data{count},k,u,sizeConsMat);
%             clusterTime_S(loop)=toc;
            %my algorithm
            tic;
            [ ~,tmpResult{loop},MSE_Me(loop),~] = SizeConsKmeansIntLinPro(data{count},k,u,sizeConsMat);
            clusterTime_Me(loop)=toc;
            disp('my algorithm finished!');
%             %kbs algorithm
%             tic;
%             [MSE_Kbs(loop),result_Kbs{loop}]=BalancedKmeansWithKbs(data{count},k,sizeConsMat);
%             clusterTime_Kbs(loop)=toc;
%             disp('kbs finished!');
            %kmeans
            tic;[result_KM{loop},centroid_KM{loop}]=kmeans(data{count},k,'Start',u);clusterTime_KM(loop)=toc;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
%%
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ACC&NMI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         gnd = [ones(50,1);ones(50,1)*2;ones(50,1)*3];%针对iris数据集的ground truth设置
%         gnd = [ones(59,1);ones(71,1)*2;ones(48,1)*3];%针对wine数据集的ground truth设置
%         gnd = [ones(49,1);ones(288,1)*2;ones(288,1)*3];%针对balance-scale数据集的ground truth设置
%         gnd=[ones(226,1);ones(125,1)*2;];%针对ionosphere数据集的ground truth设置
%         gnd=[ones(295,1);ones(311,1)*2;];%针对Hill_Valley_without_noise_Testing数据集的ground truth设置
%         gnd=[ones(24,1);ones(24,1)*2;ones(24,1)*3;ones(24,1)*4;ones(24,1)*5;ones(24,1)*6;ones(24,1)*7;...
%              ones(24,1)*8;ones(24,1)*9;ones(24,1)*10;ones(24,1)*11;ones(24,1)*12;ones(24,1)*13;ones(24,1)*14;...
%              ones(24,1)*15;];
%         gnd = [ones(10,1);ones(53,1)*2;ones(681,1)*3;ones(638,1)*4;ones(199,1)*5;ones(18,1)*6;];%wine quailty red
%         gnd=[ones(24,1);ones(88,1)*2;ones(83,1)*3;ones(63,1)*4;];    %针对DataUserModeling的ground truth设置
%         gnd = [ones(20,1)*1;ones(163,1)*2;ones(1457,1)*3;ones(2198,1)*4;ones(880,1)*5;ones(175,1)*6;ones(5,1)*7;];
%           gnd=[ones(70,1);ones(76,1)*2;ones(17,1)*3;ones(13,1)*4;ones(9,1)*5;ones(29,1)*6;];  %glass
%           gnd=[ones(143,1);ones(77,1)*2;ones(2,1)*3;ones(2,1)*4;ones(35,1)*5;ones(20,1)*6;ones(5,1)*7;ones(52,1)*8;]; %ecoli
%             gnd=[ones(9830,1);ones(10000,1)*2;ones(9611,1)*3;ones(9756,1)*4;ones(10000,1)*5;ones(9964,1)*6;ones(10000,1)*7;ones(9725,1)*8;ones(10000,1)*9;ones(10000,1)*10;];
% gnd=[ones(9830,1);ones(10000,1)*2;ones(9611,1)*3;ones(9756,1)*4;ones(10000,1)*5;ones(9964,1)*6;ones(10000,1)*7;ones(9725,1)*8;ones(10000,1)*9;ones(10000,1)*10;ones(9772,1)*11;ones(9811,1)*12;ones(10000,1)*13;ones(10000,1)*14;ones(10000,1)*15;ones(9659,1)*16;ones(9637,1)*17;ones(9676,1)*18;ones(9829,1)*19;ones(9788,1)*20;];
gnd=[ones(19760,1);ones(20000,1)*2;ones(19611,1)*3;ones(19756,1)*4;ones(20000,1)*5;ones(19964,1)*6;ones(20000,1)*7;ones(19725,1)*8;ones(20000,1)*9;ones(20000,1)*10;];
% gnd=[ones(5319,1);ones(5319,1)*2;ones(5319,1)*3;ones(5319,1)*4;ones(5319,1)*5;ones(5319,1)*6;ones(5319,1)*7;ones(5319,1)*8;ones(5319,1)*9;ones(5319,1)*10;ones(5319,1)*11;]; %Sensorless_drive_diagnosis
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%统计我们算法的ACC及NMI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         调整数据标签的格式以符合调用的其他人实现的evaluation算法(我的算法数据标签标注与其不一致)
        for i=1:length(data{1})
            result_Me{loop}(i) =tmpResult{loop}(find(tmpResult{loop}(:,2)==i,1));
        end
        result_Me{loop}=result_Me{loop}';
%         执行相关估计算法
        result_Me{loop} = bestMap(gnd,result_Me{loop});
        AC_Me(loop) = length(find(gnd == result_Me{loop}))/length(gnd);
        NMI_Me(loop) = MutualInfo(gnd,result_Me{loop});
        ARI_Me(loop)=valid_RandIndex(gnd,result_Me{loop}); 
        Outs_Me=valid_external(gnd,result_Me{loop});
        JC_Me(loop)=Outs_Me(3);
        FMI_Me(loop)=Outs_Me(4);
        clear Outs_Me;
        Ent_Me(loop)=Entropy(gnd,result_Me{loop});
        testNMI_Me(loop)=nmi(gnd,result_Me{loop});
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%统计匈牙利BK算法的ACC及NMI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %         调整数据标签的格式以符合调用的其他人实现的evaluation算法
%         result_S{loop}=result_S{loop}';
% %         执行相关估计算法
%         result_S{loop} = bestMap(gnd,result_S{loop});
%         AC_S(loop) = length(find(gnd == result_S{loop}))/length(gnd);
%         NMI_S(loop) = MutualInfo(gnd,result_S{loop});
%         ARI_S(loop)=valid_RandIndex(gnd,result_S{loop});
%         Outs_S=valid_external(gnd,result_S{loop});
%         JC_S(loop)=Outs_S(3);
%         FMI_S(loop)=Outs_S(4);
%         clear Outs_S;
%         Ent_S(loop)=Entropy(gnd,result_S{loop});
%         testNMI_S(loop)=nmi(gnd,result_S{loop});
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%统计KMeans算法的ACC及NMI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        MSE_KM(loop) = 0;
        for i = 1:dataLength
            MSE_KM(loop) = MSE_KM(loop) + ((data{count}(i,:)-centroid_KM{loop}(result_KM{loop}(i),:))*...
            (data{count}(i,:)-centroid_KM{loop}(result_KM{loop}(i),:))')/dataLength;
        end
        result_KM{loop}=bestMap(gnd,result_KM{loop});
        AC_KM(loop)=length(find(gnd==result_KM{loop}))/length(gnd);
        NMI_KM(loop)=MutualInfo(gnd,result_KM{loop});
        ARI_KM(loop)=valid_RandIndex(gnd,result_KM{loop});
        Outs_KM=valid_external(gnd,result_KM{loop});
        JC_KM(loop)=Outs_KM(3);
        FMI_KM(loop)=Outs_KM(4);
        clear Outs_KM;
        Ent_KM(loop)=Entropy(gnd,result_KM{loop});
        testNMI_KM(loop)=nmi(gnd,result_KM{loop});
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%         %%%%%%%%%%%%%%%%%%%%统计KBS SizeConstraint Clustering算法的ACC及NMI%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         result_Kbs{loop}=bestMap(gnd,result_Kbs{loop});
%         AC_Kbs(loop)=length(find(gnd==result_Kbs{loop}))/length(gnd);
%         NMI_Kbs(loop)=MutualInfo(gnd,result_Kbs{loop});
%         ARI_Kbs(loop)=valid_RandIndex(gnd,result_Kbs{loop});
%         Outs_Kbs=valid_external(gnd,result_Kbs{loop});
%         JC_Kbs(loop)=Outs_Kbs(3);
%         FMI_Kbs(loop)=Outs_Kbs(4);
%         clear Outs_Kbs;
%         Ent_Kbs(loop)=Entropy(gnd,result_Kbs{loop});
%         testNMI_Kbs(loop)=nmi(gnd,result_Kbs{loop});
%%
        loop
    end
%%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ACC&NMI平均值统计%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    AC_Me_Mean=mean(AC_Me);
    NMI_Me_Mean=mean(NMI_Me);
    MSE_Me_Mean=mean(MSE_Me);
    ARI_Me_Mean=mean(ARI_Me);
    JC_Me_Mean=mean(JC_Me);
    FMI_Me_Mean=mean(FMI_Me);
    Ent_Me_Mean=mean(Ent_Me);
    testNMI_Me_Mean=mean(testNMI_Me);
    time_Me=mean(clusterTime_Me);
   
%     AC_S_Mean=mean(AC_S);
%     NMI_S_Mean=mean(NMI_S);
%     MSE_S_Mean=mean(MSE_S);
%     ARI_S_Mean=mean(ARI_S);
%     JC_S_Mean=mean(JC_S);
%     FMI_S_Mean=mean(FMI_S);
%     Ent_S_Mean=mean(Ent_S);
%     testNMI_S_Mean=mean(testNMI_S);
%     time_S=mean(clusterTime_S);
% 
    AC_KM_Mean=mean(AC_KM);
    NMI_KM_Mean=mean(NMI_KM);
    MSE_KM_Mean=mean(MSE_KM);
    ARI_KM_Mean=mean(ARI_KM);
    JC_KM_Mean=mean(JC_KM);
    FMI_KM_Mean=mean(FMI_KM);
    Ent_KM_Mean=mean(Ent_KM);
    testNMI_KM_Mean=mean(testNMI_KM);
    time_KM=mean(clusterTime_KM);
    
%     AC_Kbs_Mean=mean(AC_Kbs);
%     NMI_Kbs_Mean=mean(NMI_Kbs);
%     MSE_Kbs_Mean=mean(MSE_Kbs);
%     ARI_Kbs_Mean=mean(ARI_Kbs);
%     JC_Kbs_Mean=mean(JC_Kbs);
%     FMI_Kbs_Mean=mean(FMI_Kbs);
%     Ent_Kbs_Mean=mean(Ent_Kbs);
%     testNMI_Kbs_Mean=mean(testNMI_Kbs);
%     time_Kbs=mean(clusterTime_Kbs);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ACC&NMI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% catch ErrorInfo 
%     disp(ErrorInfo.identifier);
%     disp(ErrorInfo.message);
% end