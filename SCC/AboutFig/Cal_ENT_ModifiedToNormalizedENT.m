%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 原型聚类
function [Normalized_Entropy_Kbs_Mean, Normalized_Entropy_KM_Mean, Normalized_Entropy_Me_Mean, Normalized_Entropy_S_Mean] = Cal_ENT_ModifiedToNormalizedENT(data, flag)
    switch flag
        case 1
                %%
           %Kbs
           Normalized_Entropy_Kbs=[];
           %KM
           Normalized_Entropy_KM=[];
           %Me
           Normalized_Entropy_Me=[];
           %S
           Normalized_Entropy_S=[];
           for i=1:10
               [Normalized_Entropy_Kbs(i)]=0;
               [Normalized_Entropy_KM(i)]=Entropy(data.gnd,data.result_KM{i});
               [Normalized_Entropy_Me(i)]=Entropy(data.gnd,data.result_Me{i});
               [Normalized_Entropy_S(i)]=0;
           end
            %% mean
            %kbs
           Normalized_Entropy_Kbs_Mean=mean(Normalized_Entropy_Kbs); 
            %km
           Normalized_Entropy_KM_Mean=mean(Normalized_Entropy_KM);
            %me
           Normalized_Entropy_Me_Mean=mean(Normalized_Entropy_Me);
            %s
           Normalized_Entropy_S_Mean=mean(Normalized_Entropy_S);
           
        case 2
             %Kbs
           Normalized_Entropy_Kbs=[];
           %KM
           Normalized_Entropy_KM=[];
           %Me
           Normalized_Entropy_Me=[];
           %S
           Normalized_Entropy_S=[];

           for i=1:10
               [Normalized_Entropy_Kbs(i)]=Entropy(data.gnd,data.result_Kbs{i});
               [Normalized_Entropy_KM(i)]=Entropy(data.gnd,data.result_KM{i});
               [Normalized_Entropy_Me(i)]=Entropy(data.gnd,data.result_Me{i});
               [Normalized_Entropy_S(i)]=0;
           end
       
          %% mean
            %kbs
           Normalized_Entropy_Kbs_Mean=mean(Normalized_Entropy_Kbs); 
            %km
           Normalized_Entropy_KM_Mean=mean(Normalized_Entropy_KM);
            %me
           Normalized_Entropy_Me_Mean=mean(Normalized_Entropy_Me);
            %s
           Normalized_Entropy_S_Mean=mean(Normalized_Entropy_S);
        otherwise
            %%
            %Kbs
           Normalized_Entropy_Kbs=[];
           %KM
           Normalized_Entropy_KM=[];
           %Me
           Normalized_Entropy_Me=[];
           %S
           Normalized_Entropy_S=[];

           for i=1:10
               [Normalized_Entropy_Kbs(i)]=Entropy(data.gnd,data.result_Kbs{i});
               [Normalized_Entropy_KM(i)]=Entropy(data.gnd,data.result_KM{i});
               [Normalized_Entropy_Me(i)]=Entropy(data.gnd,data.result_Me{i});
               [Normalized_Entropy_S(i)]=Entropy(data.gnd,data.result_S{i});
           end
       
          %% mean
            %kbs
           Normalized_Entropy_Kbs_Mean=mean(Normalized_Entropy_Kbs); 
            %km
           Normalized_Entropy_KM_Mean=mean(Normalized_Entropy_KM);
            %me
           Normalized_Entropy_Me_Mean=mean(Normalized_Entropy_Me);
            %s
           Normalized_Entropy_S_Mean=mean(Normalized_Entropy_S);
    end
end








%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 谱聚类
% %Kbs
% F_Entropy_SC_Kbs=[];
% F_Purity_SC_Kbs=[];
% F_Fmeasure_SC_Kbs=[];
% F_Accuracy_SC_Kbs=[];
% 
% %KM
% F_Entropy_SC_KM=[];
% F_Purity_SC_KM=[];
% F_Fmeasure_SC_KM=[];
% F_Accuracy_SC_KM=[];
% 
% %Me
% F_Entropy_SC_Me=[];
% F_Purity_SC_Me=[];
% F_Fmeasure_SC_Me=[];
% F_Accuracy_SC_Me=[];
% 
% %S
% F_Entropy_SC_S=[];
% F_Purity_SC_S=[];
% F_Fmeasure_SC_S=[];
% F_Accuracy_SC_S=[];
% for i=1:10
%     [F_Entropy_SC_Kbs(i),F_Purity_SC_Kbs(i),F_Fmeasure_SC_Kbs(i),F_Accuracy_SC_Kbs(i)]=Fmeasure(gnd,result_SC_Kbs{i});
%     [F_Entropy_SC_KM(i),F_Purity_SC_KM(i),F_Fmeasure_SC_KM(i),F_Accuracy_SC_KM(i)]=Fmeasure(gnd,result_SC_KM{i});
%     [F_Entropy_SC_Me(i),F_Purity_SC_Me(i),F_Fmeasure_SC_Me(i),F_Accuracy_SC_Me(i)]=Fmeasure(gnd,result_SC_Me{i});
%     [F_Entropy_SC_S(i),F_Purity_SC_S(i),F_Fmeasure_SC_S(i),F_Accuracy_SC_S(i)]=Fmeasure(gnd,result_SC_S{i});
% end
% 
% %% mean
% %kbs
% F_Entropy_SC_Kbs_Mean=mean(F_Entropy_SC_Kbs);
% F_Purity_SC_Kbs_Mean=mean(F_Purity_SC_Kbs);
% F_Fmeasure_SC_Kbs_Mean=mean(F_Fmeasure_SC_Kbs);
% F_Accuracy_SC_Kbs_Mean=mean(F_Accuracy_SC_Kbs);
% %% 
% %km
% F_Entropy_SC_KM_Mean=mean(F_Entropy_SC_KM);
% F_Purity_SC_KM_Mean=mean(F_Purity_SC_KM);
% F_Fmeasure_SC_KM_Mean=mean(F_Fmeasure_SC_KM);
% F_Accuracy_SC_KM_Mean=mean(F_Accuracy_SC_KM);
% %%
% %me
% F_Entropy_SC_Me_Mean=mean(F_Entropy_SC_Me);
% F_Purity_SC_Me_Mean=mean(F_Purity_SC_Me);
% F_Fmeasure_SC_Me_Mean=mean(F_Fmeasure_SC_Me);
% F_Accuracy_SC_Me_Mean=mean(F_Accuracy_SC_Me);
% %% 
% %s
% F_Entropy_SC_S_Mean=mean(F_Entropy_SC_S);
% F_Purity_SC_S_Mean=mean(F_Purity_SC_S);
% F_Fmeasure_SC_S_Mean=mean(F_Fmeasure_SC_S);
% F_Accuracy_SC_S_Mean=mean(F_Accuracy_SC_S);