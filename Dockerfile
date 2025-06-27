# Base image: Ubuntu 22.04
FROM ubuntu:22.04

# Disable interactive mode to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive
# Set default shell to bash for compatibility
SHELL ["/bin/bash", "-c"]

# Maintainer information (optional)
LABEL maintainer="mantang034@gmai.com" \
    description="CommonAPI & SOME/IP environment setup"

# Step 1: Install basic development tools
RUN apt update && \
    apt install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    default-jre \
    libboost-system-dev \
    libboost-thread-dev \
    libboost-log-dev && \
    # Clean up apt cache to reduce image size
    apt clean && \
    rm -rf /var/lib/apt/lists/*


# Step 2: Install vsomeip library
RUN mkdir -p /home/vsomeip && \
    cd /home/vsomeip && \
    git clone https://github.com/COVESA/vsomeip.git && \
    cd vsomeip && \
    mkdir build && \
    cd build && \
    cmake -DENABLE_SIGNAL_HANDLING=1 .. && \
    make -j$(nproc) && \
    make install


# Step 3: Install capicxx-core-runtime library
RUN mkdir -p /home/CommonAPI_runtime && \
    cd /home/CommonAPI_runtime && \
    git clone https://github.com/GENIVI/capicxx-core-runtime.git && \
    cd capicxx-core-runtime && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install


# Step 4: Install capicxx-someip-runtime library
RUN mkdir -p /home/CommonAPI_SOMEIP && \
    cd /home/CommonAPI_SOMEIP && \
    git clone https://github.com/GENIVI/capicxx-someip-runtime.git && \
    cd capicxx-someip-runtime && \
    mkdir build && \
    cd build && \
    cmake -DUSE_INSTALLED_COMMONAPI=OFF .. && \
    make -j$(nproc) && \
    make install


# Step 5: Install commonapi-core-generator
RUN mkdir -p /home/CommonAPI_generator/commonapi-core-generator && \
    cd /home/CommonAPI_generator/commonapi-core-generator && \
    wget https://github.com/COVESA/capicxx-core-tools/releases/download/3.2.0.1/commonapi_core_generator.zip && \
    unzip commonapi_core_generator.zip && \
    rm commonapi_core_generator.zip && \
    chmod +x ./commonapi-core-generator-linux-x86_64


# Step 6: Install commonapi-someip-generator
RUN cd /home/CommonAPI_generator && \
    mkdir commonapi-someip-generator && \
    cd commonapi-someip-generator && \
    wget https://github.com/COVESA/capicxx-someip-tools/releases/download/3.2.0.1/commonapi_someip_generator.zip && \
    unzip commonapi_someip_generator.zip && \
    rm commonapi_someip_generator.zip && \
    chmod +x ./commonapi-someip-generator-linux-x86_64


# Set working directory
WORKDIR /home/project


# Default command: start bash for interactive use
CMD ["bash"]