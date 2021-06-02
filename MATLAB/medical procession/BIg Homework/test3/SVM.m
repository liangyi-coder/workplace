
% 使用SVM将鸭子从湖面分割
% 导入图像文件引导对话框



%使用ColorPix软件从图上选取几个湖面的代表性点的RGB的值
LakeTrainData = [147,168,125;151 173 124;143 159 112;150 168 126;...
    146 165 120;145 161 116;150 171 130;146 112 137;149 169 120;144 160 111];
% 从图中选取几个有代表性的鸭子点的RGB值
DuckTrainData = [81 76 82;212 202 193;177 159 157;129 112 105;167 147 136;...
    237 207 145;226 207 192;95 81 68;198 216 218;197 180 128];
% 属于湖的点为0，鸭子的点为1
group = [zeros(size(LakeTrainData,1),1);ones(size(DuckTrainData,1),1)];
% 训练得到支持向量分类机
LakeDuckSVM = svmtrain([LakeTrainData;DuckTrainData],group,'kernel_function','polynomial',...
    'polyorder',2);
[m,n,k] = size(Duck); % 图像三维矩阵
% 将Duck转化为双精度的m*n行，3列的矩阵
Duck1 = double(reshape(Duck,m*n,k));
% 根据训练得到的支持向量机对整个图像像素点进行分类
IndDuck = svmclassify(LakeDuckSVM,Duck1);
% 属于湖的点的逻辑数组
IndLake = ~IndDuck;
result = reshape([IndLake,IndLake,IndLake],[m,n,k]); % 与图片的维数对应
Duck2 = Duck;
Duck2(result)= 255; % 湖面的点变为白色
figure;
