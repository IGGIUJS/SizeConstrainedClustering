function [ u,re,MSE_best,count] = SizeConsKmeansIntLinPro( data,k,u,sizeConsMat )
%initial some basic parameter
    MSE_best=inf;
    cost=0;
    sumError=0;
    [dataLength,~]=size(data);
%     [~,u]=kmeanspp(data',k);
%     u=u';
    costMat=zeros(k,dataLength);
    re=zeros(dataLength,2);
    count=0;
    preCentroids=u;
%start clustering
    while 1
        clusterCount=1;
        position=0;
    %computing cost matrix
        for i=1:k
            for j=1:dataLength
                  costMat(i,j)=(u(i,:)-data(j,:))*(u(i,:)-data(j,:))';
%                     costMat(i,j)=(pdist2(u(i,:),data(j,:),'euclidean'))^2;
            end
        end     
        [assignment,cost]=SizeConsAssignIntLinPro(costMat,sizeConsMat,count);
        for i=1:k
            clusterData=find(assignment(i,:)==1);          
            re(position+1:position+length(clusterData),1)=clusterCount;
            re(position+1:position+length(clusterData),2)=clusterData';
            position=position+length(clusterData);
            clusterCount=clusterCount+1;
        end

%         MSE=cost/dataLength;

        %computing the average and update the centroids
        for i=1:k
            assignedDataNum=re(find(re(:,1)==i),:);
            assignedDataNum(:,1)=[];                %删除标记了cluster编号的assignedDataNum
                                                    %从而得到某一cluster中data的数据编号
            assignedData=data(assignedDataNum,:);
            u(i,:)=mean(assignedData);
        end
        %聚类后数据标注
        for i=1:length(data)
            result_Me(i) =re(find(re(:,2)==i,1));
        end
        result_Me=result_Me';
        %         calculate MSE
%         assignment=assignment';
%         for i=1:k
%             clusterData=find(assignment(:,i)==1);
%             for j=clusterData'
%                 sumError=sumError+(result_Me(i,:)-data(j,:))*(result_Me(i,:)-data(j,:))';
%             end
%         end
%         MSE=sumError/dataLength;
%         MSE=cost/dataLength;
        MSE=0;
        for i = 1:dataLength
            MSE = MSE + ((data(i,:)-u(result_Me(i),:))*(data(i,:)-u(result_Me(i),:))')/dataLength;
        end
        if (MSE<MSE_best)
            MSE_best = MSE;
        else
            break;
        end
%         if(cost<cost_best)
%             cost_best=cost;
%         else
%             break;
%         end       
        
        
        if norm(preCentroids-u)< 0.0001  %不断迭代直到位置不再变化
           break;
        end
%           if sum(partition~=partition_previous)==0
%               break;
%           end
        preCentroids=u;
        count=count+1;
        fprintf('iteration count is:%d\n',count);
        if count > 100
            break;
        end 
    end
%     markedData=[];
%     for i=1:k
%         currentNum=re(find(re(:,1)==i),:);
%         current=data(currentNum(:,2),:);
%         index=linspace(i,i,length(currentNum))';
%         markedData=[markedData;index,current];
%     end
end

