function [ F_Total_Spectral ] = getTotalSpectral(data)
Cal_ENT_ModifiedToNormalizedENTSpectral;
AC_Spectral=[data.AC_SC_Kbs_Mean,data.AC_SC_KM_Mean,data.AC_SC_Me_Mean,data.AC_SC_S_Mean];
ENT_Spectral=[Normalized_Entropy_SC_Kbs_Mean,Normalized_Entropy_SC_KM_Mean,Normalized_Entropy_SC_Me_Mean,Normalized_Entropy_SC_S_Mean];
FMI_Spectral=[data.FMI_SC_Kbs_Mean,data.FMI_SC_KM_Mean,data.FMI_SC_Me_Mean,data.FMI_SC_S_Mean];
JCI_Spectral=[data.JC_SC_Kbs_Mean,data.JC_SC_KM_Mean,data.JC_SC_Me_Mean,data.JC_SC_S_Mean];
F_Total_Spectral=[ENT_Spectral;AC_Spectral;FMI_Spectral;JCI_Spectral;];
end

