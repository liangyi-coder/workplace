# -*- coding: utf-8 -*-
"""
Created on Mon Apr 26 21:59:07 2021

@author: liangyi
"""
#下面两句指定字体保证汉字不会变框框
#from pylab import mpl  
#mpl.rcParams['font.sans-serif'] = ['SimHei'] 

import numpy as np
import math
import matplotlib.pyplot as plt
import random
'''
函数说明:引入数据
'''
def loadDataSet():
    dataMat = [] #创建数据列表
    labelMat = [] #创建标签列表
    fr = open('testSet.txt') #打开数据文件
    for line in fr.readlines():
        lineArr = line.strip().split() #去除回车，放入lineArr
        dataMat.append([1.0,float(lineArr[0]),float(lineArr[1])])
        labelMat.append(int(lineArr[2]))
    fr.close()
    return dataMat, labelMat



'''
函数说明：LogisticRegression函数
'''
def h_f(THETA,X):
    return 1/(1+math.exp(-(THETA[0]+THETA[1]*X[1]+THETA[2]*X[2])))

'''
函数说明：cost函数
'''
def cost_f(THETA,X,y):
    return -y*math.log(h_f(THETA,X),math.e)-(1-y)*math.log(1-h_f(THETA,X),math.e)

'''
函数说明：代价函数
参数说明：参数，样本集，标签集，样本数量
'''
def J_f(THETA,dataMat,labelMat,m):
    sm = 0
    for i in range(m):
        sm += cost_f(THETA,dataMat[i],labelMat[i])
    sm = sm/m
    return sm

def theta_f(theta_j,THETA,dataMat,labelMat,m,alpha,j):#theta_j代表第j个参(从0开始)
    sm = 0
    for i in range(m):
        sm += dataMat[i][j] * (h_f(THETA,dataMat[i])-labelMat[i])
    sm = alpha * sm
    return theta_j - sm

'''
函数说明：逻辑回归的梯度下降函数
参数说明：初始参数三个，数据集，标签集，样本数量
'''
def Gradient_Descent(theta0_old,theta1_old,theta2_old,alpha,dataMat,labelMat,m):

    
    theta0 = theta0_old #为参数设置初值(0,0,1)
    theta1 = theta1_old
    theta2 = theta2_old
    cost_old = J_f([theta0,theta1,theta2],dataMat,labelMat,m)
    #print(theta0,theta1,theta2,cost_old)
    threshold = 0.000001 #设置阀值
    #alpha = 0.01 #设置步长（学习率）
    
    temp0 = theta_f(theta0,[theta0,theta1,theta2],dataMat,labelMat,m,alpha,0)
    temp1 = theta_f(theta1,[theta0,theta1,theta2],dataMat,labelMat,m,alpha,1)
    temp2 = theta_f(theta2,[theta0,theta1,theta2],dataMat,labelMat,m,alpha,2)
    cost_new = J_f([temp0,temp1,temp2],dataMat,labelMat,m)
    #print(temp0,temp1,temp2,cost_new)
    while abs(cost_old-cost_new)>threshold :
        theta0 = temp0
        theta1 = temp1
        theta2 = temp2
        cost_old = cost_new
        
        temp0 = theta_f(theta0,[theta0,theta1,theta2],dataMat,labelMat,m,alpha,0)
        temp1 = theta_f(theta1,[theta0,theta1,theta2],dataMat,labelMat,m,alpha,1)
        temp2 = theta_f(theta2,[theta0,theta1,theta2],dataMat,labelMat,m,alpha,2)
        cost_new = J_f([temp0,temp2,temp2],dataMat,labelMat,m)
    return [theta0,theta1,theta2]
    

'''
函数说明：改进的梯度下降函数
参数说明：数据集，标签集，样本数量

'''
def imporved_Gradient_Descent(dataMat,labelMat,m):
    Mat = np.c_[dataMat,labelMat] #首先将数据的标签合并
    random.shuffle(dataMat) #对Mat进行随机重新排序
    k = 20 #计算将每轮迭代的次数设置为k,这里因为有100个样本所以平均分成5份
    theta0,theta1,theta2 = 0,0,1 #设置初始的parameters
    #进行梯度下降的迭代计算
    for i in range(0,m,k):
        alpha = 0.01 #+ 0.01/(2**i) #保证每轮梯度下降迭代后alpha都变小
        if i+k < m:
            THETA = Gradient_Descent(theta0, theta1, theta2,alpha,Mat[i:i+k,:-1],Mat[i:i+k,-1],k)
        elif i+k == m:
            break
        else:
            THETA = Gradient_Descent(theta0, theta1, theta2,alpha,Mat[i:m,:-1],Mat[i:m,-1],m-i)
            
        theta0 = THETA[0]
        theta1 = THETA[1]
        theta2 = THETA[2]
        print(theta0,theta1,theta2,i)
    return [theta0,theta1,theta2]


'''
函数说明：根据解出的系数描绘数据集以及分割线
'''
def plotBestFit():
    dataMat, labelMat = loadDataSet()
    dataArr = np.array(dataMat)
    m = np.shape(dataMat)[0]
    xcord1 = []; ycord1 = []
    xcord0 = []; ycord0 = []
    
    for i in range(m):
        if labelMat[i] == 1:
            xcord1.append(dataArr[i,1]);ycord1.append(dataArr[i,2])
        else:
            xcord0.append(dataArr[i,1]);ycord0.append(dataArr[i,2])
    #画出样本点的图
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.scatter(xcord1,ycord1,s = 20,c = 'red',marker = 's',alpha = .5)
    ax.scatter(xcord0,ycord0,s = 20,c = 'green',alpha = .5)
    #画出分割线
    #THETA = Gradient_Descent(0,0,1,dataMat,labelMat,m) #解出一组系数
    THETA = imporved_Gradient_Descent(dataMat,labelMat,m) #解出一组系数
    X = np.arange(-3.0,3.0,0.1)
    Y = (-THETA[0]-THETA[1]*X)/THETA[2]
    ax.plot(X,Y)
    plt.title('BestFitLine')
    plt.xlabel('X1');plt.ylabel('X2')
    plt.show()

if __name__ == '__main__':
    plotBestFit()

