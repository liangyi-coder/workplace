import pandas as pd
import numpy as np
import statsmodels.api as sm
import math
import matplotlib.pyplot as plt  # 可视化绘制
from sklearn.linear_model import LinearRegression  # 线性回归

#读取train_data中的数据，以第一行为表头，记作train_data
train_data = pd.read_csv('train_data.csv')
#读取test_data中的数据，记作test_data
test_data = pd.read_csv('test_data.csv')

isnan = train_data.isnull()

'''
数据预处理
'''
#将字符型数据转化元组
test = np.array(test_data)
train = np.array(train_data)
isnan =np.array(isnan)
#将train中的数据预处理为数字
for p in train:
    for i in range(len(p)):
        if p[i]=='-' or p[i]=='other' or p[i]=='pd':
            p[i]=-1
        elif p[i]=='ALK-':
            p[i]=-2
        elif p[i]=='F' or p[i]=='puncture':
            p[i]=0
        elif p[i]=='M' or p[i]=='surgery' or p[i]=='I' or p[i]=='+' or p[i]=='1+' or p[i]=='single+' :
            p[i]=1  
        elif p[i]=='II' or p[i]=='2+' or p[i]=='++' :
            p[i]=2
        elif p[i]=='III' or p[i]=='3+' or p[i]=='+++' :
            p[i]=3
        elif p[i]=='IV' or p[i]=='p+' :
            p[i]=4
        elif p[i]=='V' or p[i]=='plus+':
            p[i]=5
        elif p[i]=='1a':
            p[i]=1.25
        elif p[i]=='1b':
            p[i]=1.5
        elif p[i]=='1c':
            p[i]=1.75
        elif p[i]=='2a':
            p[i]=2.25
        elif p[i]=='2b':
            p[i]=2.5
        elif p[i]=='2c':
            p[i]=2.75
        elif p[i]=='3a':
            p[i]=3.25
        elif p[i]=='3b':
            p[i]=3.5
        elif p[i]=='3c':
            p[i]=3.75
        elif p[i]=='few Lesions1+':
            p[i]=5.5
        elif p[i]=='Lesions+' or p[i]=='lesions+':
            p[i]=6
        elif p[i]=='local lesions+':
            p[i]=6.5
        elif p[i]=='Lesions2+' or p[i]=='lesions2+':
            p[i]=7
        elif p[i]=='Lesions3+' or p[i]=='lesions3+':
            p[i]=8
        elif p[i]=='local lesions3+':
            p[i]=8.5
        elif p[i]=='dispersion+':
            p[i]=9
        elif p[i]=='leak+':
            p[i]=10


#将train的数据类型由tuple转化为list
h = train.shape[0]
w = train.shape[1]
train_L = train.tolist()


#补齐train中的缺失
#按照补齐平均值取整来补齐得到train_L

for j in range(1,w):
    smm = 0;
    count = 0;
    for i in range(h):
        if isnan[i,j] == False:
            if type(train_L[i][j]) == str:
                train_L[i][j] = eval(train_L[i][j])
            smm += train_L[i][j]
            count += 1
    avg = math.floor(smm/count)
    for k in range(h):
        if isnan[k,j] == True:
           train_L[k][j]= avg


#使用train_L中的前500个作为训练数据，构建模型,后206用作验证集
train_L = np.delete(train_L,0,axis=1)

train_X = train_L[0:500,0:31]
train_X = np.insert(train_X,0,values=1,axis=1)
train_Y = train_L[0:500,32]

test_X = train_L[500:,0:31]
test_X = np.insert(test_X,0,values=1,axis=1)
test_Y = train_L[0:,32]
LM = LinearRegression()
#得到线性回归的模型
LM.fit(train_X,train_Y)

pre_t = LM.predict(test_X)

#验证得到模型的准确率
def getC_index(pre,y,h):
    #首先得到预测结果中各个患者的生存周期，若p1<p2,记为-1，p1=p2,记为0,p1>p2,记为+1
    #循环遍历比较预测记过
    c1 = [] #C1记录比较预测结果
    c2 = [] #c2记录实际比较结果
    for i in range(h-1):
        for j in range(i+1,h):
            if pre[i]<pre[j]:
                c1.append(-1)
            elif pre[i]==pre[j]:
                c1.append(0)
            else:
                c1.append(1)
            if y[i]<y[j]:
                c2.append(-1)
            elif y[i]==y[j]:
                c2.append(0)
            else:
                c2.append(1)
    #计算C_index的值
    s = 0
    for k in range(h):
        if c1[k]==c2[k]:
            s += 1
    c_index = s/h
    return c_index

c_index = getC_index(pre_t.tolist(),test_Y.tolist(),pre_t.shape[0])
                

#处理test数据集

#将test中的数据数字化
for p in test:
    for i in range(len(p)):
        if p[i]=='-' or p[i]=='other' or p[i]=='pd':
            p[i]=-1
        elif p[i]=='ALK-':
            p[i]=-2
        elif p[i]=='F' or p[i]=='puncture':
            p[i]=0
        elif p[i]=='M' or p[i]=='surgery' or p[i]=='I' or p[i]=='+' or p[i]=='1+' or p[i]=='single+' :
            p[i]=1  
        elif p[i]=='II' or p[i]=='2+' or p[i]=='++' :
            p[i]=2
        elif p[i]=='III' or p[i]=='3+' or p[i]=='+++' :
            p[i]=3
        elif p[i]=='IV' or p[i]=='p+' :
            p[i]=4
        elif p[i]=='V' or p[i]=='plus+':
            p[i]=5
        elif p[i]=='1a':
            p[i]=1.25
        elif p[i]=='1b':
            p[i]=1.5
        elif p[i]=='1c':
            p[i]=1.75
        elif p[i]=='2a':
            p[i]=2.25
        elif p[i]=='2b':
            p[i]=2.5
        elif p[i]=='2c':
            p[i]=2.75
        elif p[i]=='3a':
            p[i]=3.25
        elif p[i]=='3b':
            p[i]=3.5
        elif p[i]=='3c':
            p[i]=3.75
        elif p[i]=='few Lesions1+':
            p[i]=5.5
        elif p[i]=='Lesions+' or p[i]=='lesions+':
            p[i]=6
        elif p[i]=='local lesions+':
            p[i]=6.5
        elif p[i]=='Lesions2+' or p[i]=='lesions2+':
            p[i]=7
        elif p[i]=='Lesions3+' or p[i]=='lesions3+':
            p[i]=8
        elif p[i]=='local lesions3+':
            p[i]=8.5
        elif p[i]=='dispersion+':
            p[i]=9
        elif p[i]=='leak+':
            p[i]=10
        
#补齐test中的缺失为test_L
isnan_t = test_data.isnull()
isnan_t = np.array(isnan_t)
test_L = test.tolist()
h_t = test.shape[0]
w_t = test.shape[1]
#按照补齐平均值取整来补齐得到test_L
for j in range(1,w_t):
    smm = 0;
    count = 0;
    for i in range(h_t):
        if isnan_t[i,j] == False:
            if type(test_L[i][j]) == str: 
                test_L[i][j] = eval(test_L[i][j])
            smm += test_L[i][j]
            count += 1
    avg = math.floor(smm/count)
    for k in range(h_t):
        if isnan_t[k,j] == True:
           test_L[k][j]= avg
#去除序号列，创建测试数据集X
X = np.delete(test_L,0,axis=1)
X = np.insert(X,0,values=1,axis=1)
X = X.tolist()

#使用模型预测
pre = LM.predict(X)

