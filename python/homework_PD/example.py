# -*- coding: utf-8 -*-
"""
Created on Sun Dec 20 19:57:18 2020

@author: liangyi
"""

from lifelines.datasets import load_waltons
from lifelines import KaplanMeierFitter
from lifelines.utils import median_survival_times

#显示数据
df = load_waltons()
print(df.head(),'\n')
print(df['T'].min(), df['T'].max(),'\n')
print(df['E'].value_counts(),'\n')
print(df['group'].value_counts(),'\n')

#拟合曲线
kmf = KaplanMeierFitter()
kmf.fit(df['T'], event_observed=df['E'])

kmf.plot_survival_function()

median_ = kmf.median_survival_time_
median_confidence_interval_ = median_survival_times(kmf.confidence_interval_)
print(median_confidence_interval_)

#对照
groups = df['group']
ix = (groups == 'miR-137')

kmf.fit(df['T'][ix], df['E'][ix], label='miR-137')
ax = kmf.plot()
treatment_median_confidence_interval_ = median_survival_times(kmf.confidence_interval_)
print("带有miR-137病毒存活50%对应的存活时间95%置信区间：'\n'", treatment_median_confidence_interval_, '\n')

kmf.fit(df['T'][~ix], df['E'][~ix], label='control')
#共享一个画布
ax = kmf.plot(ax=ax)

control_median_confidence_interval_ = median_survival_times(kmf.confidence_interval_)
print("未带有miR-137病毒存活50%对应的存活时间95%置信区间：'\n'", control_median_confidence_interval_)