function W=CalSimilarityMat(data,sigma)
    % CalSimilarityMat 此处显示有关此函数的摘要
    % data：输入的邻接/相似矩阵
    % type：计算拉普拉斯矩阵的方案or在某些算法中的实现形式
    % L返回值：拉普拉斯矩阵
%     W=exp(-(dist(data,data').^2)/(2*(sigma)^2));  
%     M = exp(-M.^2 ./ (2*sigma^2));
%% 大数据下out of memory
    W = squareform(pdist(data));
    W = exp(-W.^2 ./ (2*sigma^2));
%% 欧氏距离向量化写法，大数据下此处仍然out of memory
%     W = sqrt(bsxfun(@plus,sum(data.^2,2),sum(data.^2,2)') - 2*(data*data') );
%     W = exp(-W.^2 ./ (2*sigma^2));
%%
%     for i=1:length(data)
%         for j=1:length(data)
%             Wtest(i,j)=exp(-(dist(data(i,:),data(j,:)').^2)/(2*(sigma)^2));  
%         end
%     end
%% 太慢
% dataLength=length(data);
%         for i=1:dataLength
%             for j=1:dataLength
%                   W(i,j)=(data(i,:)-data(j,:))*(data(i,:)-data(j,:))';
%                     costMat(i,j)=(pdist2(u(i,:),data(j,:),'euclidean'))^2;
%             end
%         end
%         W;
end

