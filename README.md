# CommonAPI C++ SOME/IP Demo Project
[![zread](https://img.shields.io/badge/Ask_Zread-_.svg?style=plastic&color=00b0aa&labelColor=000000&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB3aWR0aD0iMTYiIGhlaWdodD0iMTYiIHZpZXdCb3g9IjAgMCAxNiAxNiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuOTYxNTYgMS42MDAxSDIuMjQxNTZDMS44ODgxIDEuNjAwMSAxLjYwMTU2IDEuODg2NjQgMS42MDE1NiAyLjI0MDFWNC45NjAxQzEuNjAxNTYgNS4zMTM1NiAxLjg4ODEgNS42MDAxIDIuMjQxNTYgNS42MDAxSDQuOTYxNTZDNS4zMTUwMiA1LjYwMDEgNS42MDE1NiA1LjMxMzU2IDUuNjAxNTYgNC45NjAxVjIuMjQwMUM1LjYwMTU2IDEuODg2NjQgNS4zMTUwMiAxLjYwMDEgNC45NjE1NiAxLjYwMDFaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik00Ljk2MTU2IDEwLjM5OTlIMi4yNDE1NkMxLjg4ODEgMTAuMzk5OSAxLjYwMTU2IDEwLjY4NjQgMS42MDE1NiAxMS4wMzk5VjEzLjc1OTlDMS42MDE1NiAxNC4xMTM0IDEuODg4MSAxNC4zOTk5IDIuMjQxNTYgMTQuMzk5OUg0Ljk2MTU2QzUuMzE1MDIgMTQuMzk5OSA1LjYwMTU2IDE0LjExMzQgNS42MDE1NiAxMy43NTk5VjExLjAzOTlDNS42MDE1NiAxMC42ODY0IDUuMzE1MDIgMTAuMzk5OSA0Ljk2MTU2IDEwLjM5OTlaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik0xMy43NTg0IDEuNjAwMUgxMS4wMzg0QzEwLjY4NSAxLjYwMDEgMTAuMzk4NCAxLjg4NjY0IDEwLjM5ODQgMi4yNDAxVjQuOTYwMUMxMC4zOTg0IDUuMzEzNTYgMTAuNjg1IDUuNjAwMSAxMS4wMzg0IDUuNjAwMUgxMy43NTg0QzE0LjExMTkgNS42MDAxIDE0LjM5ODQgNS4zMTM1NiAxNC4zOTg0IDQuOTYwMVYyLjI0MDFDMTQuMzk4NCAxLjg4NjY0IDE0LjExMTkgMS42MDAxIDEzLjc1ODQgMS42MDAxWiIgZmlsbD0iI2ZmZiIvPgo8cGF0aCBkPSJNNCAxMkwxMiA0TDQgMTJaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik00IDEyTDEyIDQiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLXdpZHRoPSIxLjUiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPgo8L3N2Zz4K&logoColor=ffffff)](https://zread.ai/ManTang034/CommonAPI-SOMEIP-Demo)

## Overview
This project demonstrates a basic implementation of CommonAPI with SOME/IP communication protocol, showing how to establish communication between a service (server) and client in a Linux environment.
AI Interpretation Link of This Repository: [zread.ai/ManTang034/CommonAPI-SOMEIP-Demo](https://zread.ai/ManTang034/CommonAPI-SOMEIP-Demo/1-overview)

## Environment Configuration
Two setup options available:

1. **Docker-based Setup** (Recommended)
2. **Manual Setup**

## Step 0: Quick Docker Setup -> Step 3
```bash
docker build -t commonapi-env:22.04 .
docker images | grep commonapi-env
docker run -it --rm commonapi-env:22.04 bash
```

## Step 1: Prerequisites Installation
```shell
docker exec -it containerId /bin/bash
```

```shell
apt update && apt install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    tree \
    vim \
    default-jre \
    libboost-system-dev \
    libboost-thread-dev \
    libboost-log-dev
```

## Step 2: CommonAPI Environment Deployment

### 1. Install vsomeip Library

```shell
mkdir -p /home/vsomeip && cd /home/vsomeip
git clone https://github.com/COVESA/vsomeip.git
cd vsomeip && mkdir build && cd build
cmake -DENABLE_SIGNAL_HANDLING=1 ..
make -j$(nproc) && make install
```

### 2. Install capicxx-core-runtime

```shell
mkdir -p /home/CommonAPI_runtime && cd /home/CommonAPI_runtime
git clone https://github.com/GENIVI/capicxx-core-runtime.git
cd capicxx-core-runtime && mkdir build && cd build
cmake .. && make -j$(nproc) && make install
```

### 3. Install capicxx-someip-runtime

```shell
mkdir -p /home/CommonAPI_SOMEIP && cd /home/CommonAPI_SOMEIP
git clone https://github.com/GENIVI/capicxx-someip-runtime.git
cd capicxx-someip-runtime && mkdir build && cd build
cmake -DUSE_INSTALLED_COMMONAPI=OFF ..
make -j$(nproc) && make install
```

### 4. Install CommonAPI Core Generator

```shell
mkdir -p /home/CommonAPI_generator/commonapi-core-generator
cd /home/CommonAPI_generator/commonapi-core-generator
wget https://github.com/COVESA/capicxx-core-tools/releases/download/3.2.0.1/commonapi_core_generator.zip
unzip commonapi_core_generator.zip
chmod +x commonapi-core-generator-linux-x86_64
```

### 5. Install CommonAPI SOME/IP Generator

```shell
mkdir -p /home/CommonAPI_generator/commonapi-someip-generator
cd /home/CommonAPI_generator/commonapi-someip-generator
wget https://github.com/COVESA/capicxx-someip-tools/releases/download/3.2.0.1/commonapi_someip_generator.zip
unzip commonapi_someip_generator.zip
chmod +x commonapi-someip-generator-linux-x86_64
```

## Step 3: Demo Project Setup

### 1. Create Project Structure

```shell
mkdir -p /home/project/{fidl,src,build}
cd /home/project && touch CMakeLists.txt
cd fidl && touch HelloWorld.fidl HelloWorld.fdepl
cd ../src && touch HelloWorldClient.cpp HelloWorldService.cpp HelloWorldStubImpl.{hpp,cpp}
```

### 2. Generate Code

```shell
cd /home/project
/home/CommonAPI_generator/commonapi-core-generator/commonapi-core-generator-linux-x86_64 -sk ./fidl/HelloWorld.fidl
/home/CommonAPI_generator/commonapi-someip-generator/commonapi-someip-generator-linux-x86_64 -ll verbose ./fidl/HelloWorld.fdepl
```

## Step 4: Build and Run

### 1. Build Project

```shell
cd /home/project/build
cmake .. && make
```

### 2. Verify Dependencies

```shell
ldd ./HelloWorldClient
```

### 3. Fix Missing Library (if needed)

```shell
echo "/home/vsomeip/vsomeip/build" | sudo tee /etc/ld.so.conf.d/vsomeip.conf
sudo ldconfig
```

### 4. Run Applications

Terminal 1: Start the service

```shell
./HelloWorldService
```

Terminal 2: Start the client

```shell
./HelloWorldClient
```

### Expected Output

Successful communication will show:

- Service registering and handling requests
- Client connecting and receiving responses
- "Hello Bob!" message exchange


![image-20250627154724899](README.assets/image-20250627154724899.png)

![image-20250627154938508](README.assets/image-20250627154938508.png)



![image-20250627155007932](README.assets/image-20250627155007932.png)

### Reference:
[capicxx-core-tools](https://github.com/COVESA/capicxx-core-tools)\
[CommonAPI C++](https://covesa.github.io/capicxx-core-tools/)\
[CommonAPI C++ SOME/IP binding](https://github.com/COVESA/capicxx-someip-tools/)\
[SOME/IP](https://some-ip.com/)
