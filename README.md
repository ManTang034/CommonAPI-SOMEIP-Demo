

# CommonAPI C++ SomeIP Demo

CommonAPI环境有两种配置方式：

一是使用dockerfile直接构建镜像，构建完成后直接从Step3开始；

二是从头开始配置，从Step1开始。

## Step 0.快速配置

```shell
docker build -t commonapi-env:22.04 .
```

确认镜像是否存在

```shell
docker images | findstr commonapi-env
```

启动容器测试环境

```shell
docker run -it --rm commonapi-env:22.04 bash
```

## Step 1.前置准备

- 安装gcc、make等工具 

```shell
apt update
apt install build-essential
apt-get install cmake
```

- 安装git、wget、unzip、tree、vim工具

```shell
apt install git
apt-get install wget
apt-get install zip unzip
apt-get install tree
apt install vim
```

- 安装java8的jre环境

```shell
apt install default-jre
```

- 安装vsomeip的依赖库boost

```shell
apt-get install libboost-system-dev libboost-thread-dev libboost-log-dev
```

## Step 2.部署CommonAPI环境

1. 安装vsomeip库

```shell
mkdir /home/vsomeip
cd /home/vsomeip
git clone https://github.com/COVESA/vsomeip.git
cd vsomeip
mkdir build
cmake -DENABLE_SIGNAL_HANDLING=1 ..
make -j$(nproc)
make install
```

2. 安装capicxx-core-runtime库

```shell
mkdir /home/CommonAPI_runtime
cd /home/CommonAPI_runtime
git clone https://github.com/GENIVI/capicxx-core-runtime.git
cd capicxx-core-runtime/
mkdir build
cd build
cmake ..
make -j$(nproc)
make install
```

3. 安装capcxx-someip-runtime库

```shell
mkdir /home/CommonAPI_SOMEIP
cd home/CommonAPI_SOMEIP
git clone https://github.com/GENIVI/capicxx-someip-runtime.git
cd capicxx-someip-runtime/
mkdir build
cd build
cmake -DUSE_INSTALLED_COMMONAPI=OFF ..
make -j$(nproc)
make install
```

4. 安装commonapi-core-generator生成器

```shell
mkdir /home/CommonAPI_generator
cd /home/CommonAPI_generator
mkdir commonapi-core-generator
cd commonapi-core-generator
wget https://github.com/COVESA/capicxx-core-tools/releases/download/3.2.0.1/commonapi_core_generator.zip
unzip commonapi_core_generator.zip
chmod +x ./commonapi-core-generator-linux-x86_64
```

5. 安装commonapi-someip-generator生成器

```shell
cd /home/CommonAPI_generator
mkdir commonapi-someip-generator
cd commonapi-someip-generator
wget https://github.com/COVESA/capicxx-someip-tools/releases/download/3.2.0.1/commonapi_someip_generator.zip
unzip commonapi_someip_generator.zip
chmod +x ./commonapi-someip-generator-linux-x86_64
```

## Step 3.制作demo示例

1. 创建工程目录

```shell
mkdir /home/project
cd /home/project
mkdir fidl src build
touch CMakeLists.txt
cd fidl
touch HelloWorld.fidl HelloWorld.fdepl
cd ../src
touch HelloWorldClient.cpp HelloWorldService.cpp HelloWorldStubImpl.hpp HelloWorldStubImpl.cpp
```

使用tree命令查看project的目录结构

```shell
tree .
.
|-- CMakeLists.txt
|-- build
|-- fidl
|   |-- HelloWorld.fdepl
|   `-- HelloWorld.fidl
`-- src
    |-- HelloWorldClient.cpp
    |-- HelloWorldService.cpp
    |-- HelloWorldStubImpl.cpp
    `-- HelloWorldStubImpl.hpp
```

## Step 4.运行服务端和客户端

进入build目录

```shell
cd /home/project/build/
```

列出程序依赖的所有共享库，以及每个库是否能被找到

```shell
ldd ./HelloWorldClient
```

得到如下内容

```shell
linux-vdso.so.1 (0x00007ffdbdf69000)
        libCommonAPI.so.3.2.4 => /usr/local/lib/libCommonAPI.so.3.2.4 (0x00007f10157c9000)
        libCommonAPI-SomeIP.so.3.2.4 => /usr/local/lib/libCommonAPI-SomeIP.so.3.2.4 (0x00007f1015737000)
        libstdc++.so.6 => /lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f1015506000)
        libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f10154e6000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f10152bd000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f1015835000)
        libvsomeip3.so.3 => not found
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f10151d4000)
```

`libvsomeip3.so.3 => not found`的解决方案，如下

```shell
vim /etc/ld.so.conf.d/vsomeip.conf
```

添加并保存

```
/home/vsomeip/vsomeip/build
```

更新系统的库缓存

```shell
ldconfig
```

运行服务端

```shell
./HelloWorldService
```

运行客户端

```shell
./HelloWorldClient
```

结果如下，可以看到内容为“Hello Bob!”的message成功订阅。

![image-20250627154724899](README.assets/image-20250627154724899.png)

![image-20250627154938508](README.assets/image-20250627154938508.png)



![image-20250627155007932](README.assets/image-20250627155007932.png)