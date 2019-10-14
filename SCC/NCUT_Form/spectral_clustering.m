function [idx,objVal,centroids] = spectral_clustering(data, k,centroids,sigma,sizeConsMat,type,algorithm)
%   'type' - Defines the type of spectral clustering algorithm
%            that should be used. Choices are:
%      1 - Unnormalized
%      2 - Normalized according to Shi and Malik (2000) 这个就是normalized cut
%      3 - Normalized according to Jordan and Weiss (2002)
%   'algorithm' - Defines the type of kmeans step that spectral clustering algorithm
%             should be used. Choices are:
%      1 - Ours size constraint kmeans
%      2 - Hungarian size constraint kmenas
%      3 - Kbs size cosntraint kmeans
%      4 - Kmeans
    W=CalSimilarityMat(data,sigma);
%       W=SimGraph_NearestNeighbors(data',15,1,1);
    
%     D = diag(sum(W)); 
%     L = D-W;
    [unnormalizedL,~]=CalLaplacian(W,1);
    switch type
        case 1
            [L,DVec]=CalLaplacian(W,1);
        case 2
            [L,DVec]=CalLaplacian(W,2);
        case 3
            [L,DVec]=CalLaplacian(W,2);
    end
    diff   = eps;
    [X, dummy] = eigs(L, k, diff);
    
    % in case of the Jordan-Weiss algorithm, we need to normalize
    % the eigenvectors row-wise
    if type == 3
        X = bsxfun(@rdivide, X, sqrt(sum(X.^2, 2)));
    end
%     idx=kmeans(X, k, 'start', 'cluster', ...
%                  'EmptyAction', 'singleton');


    
%     [eigVec, eigVal] = eig(L);
%     X=eigVec(:,1:k);

%       MSE=0;
%     idx = kmeans(X, k);

%%
    if isempty(centroids)
        [~,centroids]=kmeanspp(X',k);
        centroids=centroids';
    else
%%
%这个位置之所以写一个没必要的kmeanspp计算，为的是保证时间统计的公平性，为了保证公平，只在第一个方法（ours里计算了centroids，之后的所有算法在
%同一个loop下用的是同一个centroids，但是，如果用同一个centrois在而省去了kmeanspp的计算，这对第一个方法不公平，故计算了一个没必要的kmeanspp用来
%保证时间的公平性,之后进行了clear
    [~,fool]=kmeanspp(X',k);
    fool=fool';
    clear fool;
    end
    
    switch algorithm
        case 1
            [ ~,tmpResult,MSE,~] = SizeConsKmeansIntLinPro(X,k,centroids,sizeConsMat);
            for i=1:length(X)
                cluster_labels(i) =tmpResult(find(tmpResult(:,2)==i,1));
            end
            idx=cluster_labels';
            objVal=CalObjVal(idx,DVec,unnormalizedL);
        case 2
            [~,idx]=SizeConsHung(X,k,centroids,sizeConsMat);
            objVal=CalObjVal(idx,DVec,unnormalizedL);
        case 3
            [~,idx]=SizeConsKmeansWithKbs(X,k,sizeConsMat);
            objVal=CalObjVal(idx,DVec,unnormalizedL);
        case 4
            idx = kmeans(X, k,'Start',centroids); 
            objVal=CalObjVal(idx,DVec,unnormalizedL);
    end  
    
end


