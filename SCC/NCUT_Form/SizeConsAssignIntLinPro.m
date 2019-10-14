function [ assignment,cost ] = SizeConsAssignIntLinPro( costMat,sizeConsMat,count )
%      options = optimoptions('intlinprog','Display','off','RelativeGapTolerance',0);
%     options = optimoptions('intlinprog','CutGeneration','advanced','RelativeGapTolerance',0,'RootLPMaxIterations',100000,'LPMaxIterations',100000,'Display','iter');
options = optimoptions('intlinprog','CutGeneration','none','RootLPMaxIterations',1000000,'LPMaxIterations',100000,'MaxTime',18000);
% options = optimoptions('intlinprog','CutGeneration','advanced','RelativeGapTolerance',0);
    C=costMat';
%     k=length(sizeConsMat);
    [m,n]=size(C);
    f=C(:);                     %目标函数系数矩阵（实际为列向量，intlinprog中得组织成列向量才能计算）
%     maxDist=max(f);
         %增加系数y用于约束不等式约束（即sizeConsMat）的取值
      extraCoef=zeros(n*n,1);
      for i=1:n
        extraCoef(n*(i-1)+1:i*n)=sizeConsMat;
      end
%     extraCoef=ones(n*n,1);
    f=[extraCoef;f;];            %合并原始目标系数矩阵与增加的y系数矩阵，成为增广系数矩阵
%     intcon=(1:((m*n)+length(extraCoef)))';            %限定所求X矩阵所有元素为整数
%     intcon=(1:(m*n));
    intcon=(1:length(extraCoef))';
%       intcon=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%关于等式约束条件的构造说明%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                          
% 在Blance-Constraint K-Means算法的数学建模中（我的原始版本的建模，参见V0.0.18之前版本的论文，与老师改过的公式
%的区别在于，我的模型一行表示一个cluster，一列表示一个object，与老师的建模正好相反，而代码是按我的建模写的），
%等式约束条件，用来表示X矩阵（分配矩阵）一列所有元素相加，只能等于1（其现实意义为：一个object只能属于一个cluster，如
%假设200 points分3类，第一列第1个元素为1，则第一列其他2个元素只能为0，即point 1分给了第1类，它不能属于其他类）。
%现对Aeq矩阵做出如下必要说明（仍用上例）：
%   1.所构建的Aeq矩阵，为（200，（200*3））的矩阵，每一行表示X矩阵的一列（一个object）的分配情况，由于目标系数矩阵f
%   为一个600*1的列向量（costMat中的每个元素构成的向量（按行一个一个），每个元素表示点分给不同类的代价），Aeq的列在
%   此处构建中没有特殊含义。
%   2.Aeq中，标1的元素，表示当前计算的为这几个位置，如第1个，第201个，第401个，即在所求分配矩阵中处于x11，x21，x31
%   位置的元素，这几个位置表示的就是第1个object，由于它只能属于一个cluster，所以这三个位置加起来应当为1（即分配
%   矩阵A中，只有一个元素为1，其余为0，即Aeq1*x11+Aeq2*x21+Aeq3*x31=1，可能的一种情况是只有x11为1，其余为0）
%   3.在构造Aeq矩阵时，通过仔细观察矩阵构造，采用了取巧的赋值情况，即使用eye的单位矩阵函数一次性赋值，只要执行k次
%   循环即可，避免了重复赋值效率的降低，体现了Matlab的向量化写法。
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%关于等式约束条件的构造说明%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Aeq=sparse(m,m*n+n*n);
    Aeq=sparse(m+n*3,m*n+n*n);
%       Aeq=sparse(m+n*3,m*n+n*n);
%     for i=1:n
%         Aeq(1:m,1+(i-1)*m:i*m)=eye(m,m);
%         Aeq(m+1:m+n,m*n+1+(i-1)*n:m*n+n*i)=eye(n);
%         Aeq(m+n+i,m*n+1+(i-1)*n:m*n+n*i)=ones(1,n);
%         Aeq(m+2*n+i,1+(i-1)*m:i*m)=ones(1,m);
%         Aeq(m+2*n+i,m*n+1+(i-1)*n:m*n+n*i)=-1*sizeConsMat;
%     end
for i=1:n
    Aeq(1:m,1+(i-1)*m:i*m)=speye(m,m);
    Aeq(m+1:m+n,m*n+1+(i-1)*n:m*n+n*i)=speye(n);
    Aeq(m+n+i,m*n+1+(i-1)*n:m*n+n*i)=ones(1,n);
    Aeq(m+2*n+i,1+(i-1)*m:i*m)=ones(1,m);
    Aeq(m+2*n+i,m*n+1+(i-1)*n:m*n+n*i)=-1*sizeConsMat;
end
Aeq_test=[Aeq(:,m*n+1:end),Aeq(:,1:m*n)];
% tmp1=zeros(1,(m*n)+length(extraCoef));
% tmp1(1)=1;
% tmp1(64)=1;
% tmp2=zeros(1,(m*n)+length(extraCoef));
% tmp2(1+m)=1;
% tmp2(64+m)=1;
% tmp3=zeros(1,(m*n)+length(extraCoef));
% tmp3(1+m*2)=1;
% tmp3(64+m*2)=1;

% tmp2=zeros(1,(m*n)+length(extraCoef));
% tmp2(1)=1;
% tmp2(3)=1;
% tmp3=zeros(1,(m*n)+length(extraCoef));
% tmp3(1)=1;
% tmp3(3)=1;
% Aeq=[Aeq;tmp1;tmp2;tmp3;];


%     for i=1:n                           %原始矩阵列和为1
%         Aeq(1:m,1+(i-1)*m:i*m)=speye(m,m);
%     end
%     for i=1:n
%         Aeq(m+1:m+n,m*n+1+(i-1)*n:m*n+n*i)=speye(n);
%     end
%     for i=1:n
%         Aeq(m+n+i,m*n+1+(i-1)*n:m*n+n*i)=ones(1,n);
%     end
%     for i=1:n
%         Aeq(m+2*n+i,1+(i-1)*m:i*m)=ones(1,m);
%     end
%     for i=1:n
%         Aeq(m+2*n+i,m*n+1+(i-1)*n:m*n+n*i)=-1*sizeConsMat;
%     end
    %测试instance-level约束
%     tmp=zeros(2,m*n+n*n);
%     tmp(1,1:2)=1;
%     tmp(2,3:4)=1;
%     Aeq=[Aeq;tmp];
    beq_1=ones(m+2*n,1);
    beq_2=zeros(n,1);
%     beq_3=[0;0;0];
%     beq_3=[2;1];
    beq=[beq_1;beq_2;];
%     beq=[beq_1;beq_2;beq_3];
%     beq=[beq_1;beq_2;beq_3];
%     beq=ones(m,1);
%     Aeq=sparse(Aeq);
    
    
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%关于不等式约束条件的构造说明%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %
% % %其构造思想与等式约束条件一致，都是通过两个矩阵（约束矩阵A与所求分配矩阵X）来共同决定等式约束。
% % %现对A矩阵（指的是下文代码中的约束矩阵A，非论文中所提的分配矩阵A，为防止歧义，现特别说明）作为必要说明（按上例）：
% % %   1.IntLinProg函数对于不等式约束，本质上只接受<=的条件，对于>=要对约束方程两边同时乘以-1，转化为<=的形式。
% % %   2.min number of cluster<=a1*x11+a2*x12*...an*xnn<= max number of cluster
% % %     这是矩阵构建使用的核心公式。所以，所构建的A矩阵，一行600个元素，选取其中的200个，如第一行选择1-200，即表明
% % %     在对应的分配矩阵中的，第一行（第一类）200个points的分配情况，要求其个数小于min number of cluster，且大于
% % %     max number of cluster。同理，A矩阵第二行选取201-400，对应的则是分配矩阵中的第二行（第二类）的情况，其余依次
% % %     类推。
% % %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%关于不等式约束条件的构造说明%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     A=zeros(n*2,m*n);
% %     for i=1:n
% %         A(i,1+(i-1)*m:i*m)=ones(1,m)*-1;
% %     end
% %     for i=1:n
% %         A(i+n,1+(i-1)*m:i*m)=ones(1,m);
% %     end
% %     for i=1:n
% %         b(1:n)=sizeConsMat(i)*-1;
% %         b(n+1:n*2)=sizeConsMat(i);
% %     end
%     for i=1:n
%         A(i,1+(i-1)*m:i*m)=ones(1,m)*-1;
%         A(i+n,1+(i-1)*m:i*m)=ones(1,m);
%         b(i)=sizeConsMat(i)*-1;
%         b(n+i)=sizeConsMat(i);
%     end
%     A=sparse(A);

%   上下界限定
    lb=zeros(m*n+length(extraCoef),1);        %lb，low bounds，此处限定为0
    ub_1=ones(length(extraCoef),1);
    ub_2=inf(m*n,1);
    ub=[ub_1;ub_2];
%     tmp1=ones(m*n,1)*inf;
%     tmp2=ones(length(extraCoef),1);         %ub，upper bounds，此处限定为1。由于上面intcon已经限定了整个X矩阵为整数，且此处又限定
                            %了X的上界与下界，所以即X的值只能取0或1，即0-1整数规划     
%     ub=[tmp1;tmp2;];
%   执行0-1整数规划函数intlinprog
    A=[];
    b=[];
    [X,cost]=intlinprog(f,intcon,A,b,Aeq_test,beq,lb,ub,options);
%     [X,cost]=intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);
%     [X,cost]=linprog(f,A,b,Aeq,beq,lb,ub);
    X=round(X);
%     cost=cost-n*maxDist;
    if(isempty(X))
        count
        mException=MException('Error:AssignmentMatrixEmpty',...
            'There is no solution found of Size Constraint Clustering!');
%         pause; 
        throw(mException);
    else
        X=X(length(extraCoef)+1:end);
        assignment=reshape(X,m,n);
        assignment=assignment';
        
        for j=1:n
            len=length(find(assignment(j,:)==1));
            flag = ismember(len,sizeConsMat);
            if(~flag)
                mException=MException('Error:ElementNotEqual');
                throw(mException);
            end
            locate=find(sizeConsMat(:)==len);
            sizeConsMat(locate(1))=[];
        end
    end
end