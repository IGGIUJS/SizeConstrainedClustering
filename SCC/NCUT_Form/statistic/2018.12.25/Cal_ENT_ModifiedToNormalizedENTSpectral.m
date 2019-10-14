%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Æ×¾ÛÀà
%Kbs
Normalized_Entropy_SC_Kbs=[];

%KM
Normalized_Entropy_SC_KM=[];

%Me
Normalized_Entropy_SC_Me=[];

%S
Normalized_Entropy_SC_S=[];
for i=1:10
    [Normalized_Entropy_SC_Kbs(i)]=Entropy(data.gnd,data.result_SC_Kbs{i});
    [Normalized_Entropy_SC_KM(i)]=Entropy(data.gnd,data.result_SC_KM{i});
    [Normalized_Entropy_SC_Me(i)]=Entropy(data.gnd,data.result_SC_Me{i});
    [Normalized_Entropy_SC_S(i)]=Entropy(data.gnd,data.result_SC_S{i});
end

%% mean
%kbs
Normalized_Entropy_SC_Kbs_Mean=mean(Normalized_Entropy_SC_Kbs);
%% 
%km
Normalized_Entropy_SC_KM_Mean=mean(Normalized_Entropy_SC_KM);
%%
%me
Normalized_Entropy_SC_Me_Mean=mean(Normalized_Entropy_SC_Me);
%% 
%s
Normalized_Entropy_SC_S_Mean=mean(Normalized_Entropy_SC_S);