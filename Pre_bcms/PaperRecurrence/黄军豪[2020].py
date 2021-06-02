'''
Experiment Description: 复现黄军豪在2020年发表的关于BCMS的论文中的深度学习模型
DATA：本地医院的数据
'''
import tensorflow as tf 
import os
from tensorflow.keras import layers, Sequential
batch_size = 100
learning_rate = 0.0001
class_names = ['Her2', 'luminal_A', 'luminal_B', 'TN']#每个分类的名称

#获取train data文件路径
train_data_dir = '/media/ly/liangyi/研究课题——乳腺癌分子分型分类/Data/MRI_minbox/train/'
Her2_train_dir = train_data_dir + 'Her_2/'
luminal_A_train_dir = train_data_dir + 'luminal_A/'
luminal_B_train_dir = train_data_dir + 'luminal_B/'
TN_train_dir = train_data_dir + 'TN/'

Her2_train_names = [Her2_train_dir + filename for filename in os.listdir(Her2_train_dir)]
luminal_A_train_names = [luminal_A_train_dir + filename for filename in os.listdir(luminal_A_train_dir)]
luminal_B_train_names = [luminal_B_train_dir + filename for filename in os.listdir(luminal_B_train_dir)]
TN_train_names = [TN_train_dir + filename for filename in os.listdir(TN_train_dir)]
#训练集中各个分型的数量
num_Her2_train = len(Her2_train_names)
num_luminal_A_train = len(luminal_A_train_names)
num_luminal_B_train = len(luminal_B_train_names)
num_TN_train = len(TN_train_names)
#输出训练数据中各个分型的数量
print(num_Her2_train, num_luminal_A_train, num_luminal_B_train, num_TN_train)

#得到完整的数据路径和标签
train_image_names = Her2_train_names + luminal_A_train_names + luminal_B_train_names + TN_train_names
train_labels = [0] * num_Her2_train + [1] * num_luminal_A_train + [2] * num_luminal_B_train + [3] * num_TN_train
print(len(train_image_names), len(train_labels))
#创建map函数
def _map_loadImage(imagename, label):
    image_string = tf.io.read_file(imagename)
    image_decoded = tf.image.decode_png(image_string, channels=3)
    image_resized = tf.image.resize(image_decoded, [32,32])/255.0
    label = tf.cast(label, dtype=tf.int32)
    return image_resized, label

train_dataset = tf.data.Dataset.from_tensor_slices((train_image_names, train_labels))
train_dataset = train_dataset.map(
    map_func=_map_loadImage,
    num_parallel_calls=tf.data.experimental.AUTOTUNE
)
train_dataset = train_dataset.shuffle(1000).batch(batch_size).prefetch(tf.data.experimental.AUTOTUNE)

print(train_dataset)

#准备验证集
val_data_dir = '/media/ly/liangyi/研究课题——乳腺癌分子分型分类/Data/MRI_minbox/validation/'
Her2_val_dir = val_data_dir + 'Her_2/'
luminal_A_val_dir = val_data_dir + 'luminal_A/'
luminal_B_val_dir = val_data_dir + 'luminal_B/'
TN_val_dir = val_data_dir + 'TN/'

Her2_val_names = [Her2_val_dir + imagename for imagename in os.listdir(Her2_val_dir)]
luminal_A_val_names = [luminal_A_val_dir + imagename for imagename in os.listdir(luminal_A_val_dir)]
luminal_B_val_names = [luminal_B_val_dir + imagename for imagename in os.listdir(luminal_B_val_dir)]
TN_val_names = [TN_val_dir + imagename for imagename in os.listdir(TN_val_dir)]

num_Her2_val = len(Her2_val_names)
num_luminal_A_val = len(luminal_A_val_names)
num_luminal_B_val = len(luminal_B_val_names)
num_TN_val = len(TN_val_names)

print(num_Her2_val, num_luminal_A_val, num_luminal_B_val, num_TN_val)

val_image_names = Her2_val_names + luminal_A_val_names + luminal_B_val_names + TN_val_names
val_labels = [0] * num_Her2_val + [1] * num_luminal_A_val + [2] * num_luminal_B_val + [3] * num_TN_val

print(len(val_image_names), len(val_labels))

val_dataset = tf.data.Dataset.from_tensor_slices((val_image_names, val_labels))
val_dataset = val_dataset.map(_map_loadImage).batch(batch_size)

print(val_dataset)

model = Sequential([
    #unit1
    layers.Conv2D(64, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.Conv2D(64, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.MaxPooling2D( pool_size=[2, 2], strides=2, padding="same"),

    #unit2
    layers.Conv2D(128, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.Conv2D(128, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.MaxPooling2D( pool_size=[2, 2], strides=2, padding="same"),

    #unit3
    layers.Conv2D(256, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.Conv2D(256, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.MaxPooling2D( pool_size=[2, 2], strides=2, padding="same"),

    #unit4
    layers.Conv2D(512, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.Conv2D(512, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.MaxPooling2D( pool_size=[2, 2], strides=2, padding="same"),

    #unit5
    layers.Conv2D(512, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.Conv2D(512, kernel_size=[3, 3], padding="same", activation=tf.nn.relu ),
    layers.MaxPooling2D( pool_size=[2, 2], strides=2, padding="same"),

    #unint6
    layers.Flatten(),
    layers.Dense(256, activation=tf.nn.relu),
    layers.Dense(128, activation=tf.nn.relu),
    layers.Dense(64, activation=tf.nn.relu),
    layers.Dense(4, activation=tf.nn.relu)
])


optimizer = tf.keras.optimizers.Adam(lr = learning_rate)

model.build(input_shape=[None, 32, 32, 3])

model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate = 0.001),
    loss = tf.keras.losses.sparse_categorical_crossentropy,
    metrics=[tf.keras.metrics.sparse_categorical_accuracy]
)

model.summary()

model.fit(train_dataset, validation_data=val_dataset, epochs = 30)