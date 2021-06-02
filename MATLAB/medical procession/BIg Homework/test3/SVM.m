
% ʹ��SVM��Ѽ�ӴӺ���ָ�
% ����ͼ���ļ������Ի���



%ʹ��ColorPix�����ͼ��ѡȡ��������Ĵ����Ե��RGB��ֵ
LakeTrainData = [147,168,125;151 173 124;143 159 112;150 168 126;...
    146 165 120;145 161 116;150 171 130;146 112 137;149 169 120;144 160 111];
% ��ͼ��ѡȡ�����д����Ե�Ѽ�ӵ��RGBֵ
DuckTrainData = [81 76 82;212 202 193;177 159 157;129 112 105;167 147 136;...
    237 207 145;226 207 192;95 81 68;198 216 218;197 180 128];
% ���ں��ĵ�Ϊ0��Ѽ�ӵĵ�Ϊ1
group = [zeros(size(LakeTrainData,1),1);ones(size(DuckTrainData,1),1)];
% ѵ���õ�֧�����������
LakeDuckSVM = svmtrain([LakeTrainData;DuckTrainData],group,'kernel_function','polynomial',...
    'polyorder',2);
[m,n,k] = size(Duck); % ͼ����ά����
% ��Duckת��Ϊ˫���ȵ�m*n�У�3�еľ���
Duck1 = double(reshape(Duck,m*n,k));
% ����ѵ���õ���֧��������������ͼ�����ص���з���
IndDuck = svmclassify(LakeDuckSVM,Duck1);
% ���ں��ĵ���߼�����
IndLake = ~IndDuck;
result = reshape([IndLake,IndLake,IndLake],[m,n,k]); % ��ͼƬ��ά����Ӧ
Duck2 = Duck;
Duck2(result)= 255; % ����ĵ��Ϊ��ɫ
figure;
