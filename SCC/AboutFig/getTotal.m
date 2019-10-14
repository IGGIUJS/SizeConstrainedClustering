function [ F_Total ] = getTotal(data)
    flag_Kbs=isfield(data,'MSE_Kbs');
    flag_S=isfield(data,'MSE_S');
    flag=0;
    if ~flag_Kbs
        flag=1;
    else
        if ~flag_S
            flag=2;
        end
    end
    
    switch flag
        case 1
            [Normalized_Entropy_Kbs_Mean, Normalized_Entropy_KM_Mean, Normalized_Entropy_Me_Mean, Normalized_Entropy_S_Mean]=Cal_ENT_ModifiedToNormalizedENT(data, flag);
            AC=[0,data.AC_KM_Mean,data.AC_Me_Mean,0];
            ENT=[0,Normalized_Entropy_KM_Mean,Normalized_Entropy_Me_Mean,0];
            FMI=[0,data.FMI_KM_Mean,data.FMI_Me_Mean,0];
            JCI=[0,data.JC_KM_Mean,data.JC_Me_Mean,0];
            F_Total=[ENT;AC;FMI;JCI;];
        case 2
            [Normalized_Entropy_Kbs_Mean, Normalized_Entropy_KM_Mean, Normalized_Entropy_Me_Mean, Normalized_Entropy_S_Mean]=Cal_ENT_ModifiedToNormalizedENT(data, flag);
            AC=[data.AC_Kbs_Mean,data.AC_KM_Mean,data.AC_Me_Mean,0];
            ENT=[Normalized_Entropy_Kbs_Mean,Normalized_Entropy_KM_Mean,Normalized_Entropy_Me_Mean,0];
            FMI=[data.FMI_Kbs_Mean,data.FMI_KM_Mean,data.FMI_Me_Mean,0];
            JCI=[data.JC_Kbs_Mean,data.JC_KM_Mean,data.JC_Me_Mean,0];
            F_Total=[ENT;AC;FMI;JCI;];
        otherwise
            [Normalized_Entropy_Kbs_Mean, Normalized_Entropy_KM_Mean, Normalized_Entropy_Me_Mean, Normalized_Entropy_S_Mean]=Cal_ENT_ModifiedToNormalizedENT(data, flag);
            AC=[data.AC_Kbs_Mean,data.AC_KM_Mean,data.AC_Me_Mean,data.AC_S_Mean];
            ENT=[Normalized_Entropy_Kbs_Mean,Normalized_Entropy_KM_Mean,Normalized_Entropy_Me_Mean,Normalized_Entropy_S_Mean];
            FMI=[data.FMI_Kbs_Mean,data.FMI_KM_Mean,data.FMI_Me_Mean,data.FMI_S_Mean];
            JCI=[data.JC_Kbs_Mean,data.JC_KM_Mean,data.JC_Me_Mean,data.JC_S_Mean];
            F_Total=[ENT;AC;FMI;JCI;];
    end
end

