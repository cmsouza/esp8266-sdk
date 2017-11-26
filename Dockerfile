from debian

RUN apt-get update -y && \
    apt-get install \
    autoconf automake bash bison bzip2 flex \
    g++ gawk gcc git gperf help2man libexpat-dev \
    libtool libtool-bin make ncurses-dev python \
    python-dev python-pip python-serial screen \
    sed texinfo unrar-free unzip vim wget -y && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install esptool
RUN echo 'root:root' |chpasswd && groupadd -g 14 usb && useradd -m -s /bin/bash -u1000 -Gusb user

USER user
WORKDIR /home/user/
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
WORKDIR /home/user/esp-open-sdk
RUN make toolchain libhal STANDALONE=n && rm -rfv crosstool-NG/.build

WORKDIR /home/user
RUN echo "export PATH=/home/user/esp-open-sdk/xtensa-lx106-elf/bin:$PATH" >> /home/user/.bashrc && echo "alias ll='ls -lha --color=auto'" >> /home/user/.bashrc
RUN git clone --recursive https://github.com/Superhouse/esp-open-rtos.git
