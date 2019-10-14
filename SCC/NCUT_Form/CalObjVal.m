function tr = CalObjVal(idx,DVec,L)
% calculate object value of Normalized Cut of Shi and Malik (2000)
% the value is computed by "A tutorial on Spectral Clustering" 5.3
    
    label=unique(idx);
    nClass=length(label);
    nLength=length(idx);
    volSubset=zeros(nClass,1);
    H=zeros(nLength,nClass);
    
    for i=1:nClass
        subsetId=find(idx==i);
        for j=subsetId'
            volSubset(i)=volSubset(i)+DVec(j);
        end
        H(subsetId,i)=1/sqrt(volSubset(i));
    end
    
    tr=trace(H'*L*H);
%     for i=1:nClass
%         for j=1:nLength
%             H(i,j)=
%         end
%     end
    
    
end