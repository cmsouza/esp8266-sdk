from debian

RUN apt-get update -y && apt-get install \
    autoconf automake bash bison bzip2 flex \
    g++ gawk gcc git gperf help2man libexpat-dev \
    libtool libtool-bin make minicom ncurses-dev \
    python python-dev python-pip python-serial \
    screen sed texinfo unrar-free unzip vim wget -y

RUN echo 'root:root' |chpasswd 
RUN groupadd -g 14 usb
RUN useradd -m -s /bin/bash -u1000 -Gusb user
USER user

WORKDIR /home/user/
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
WORKDIR /home/user/esp-open-sdk

RUN make toolchain libhal STANDALONE=n

WORKDIR /home/user
RUN echo "export PATH=/home/user/esp-open-sdk/xtensa-lx106-elf/bin:$PATH" >> /home/user/.bashrc
RUN echo "alias ll='ls -lha --color=auto'" >> /home/user/.bashrc

RUN git clone --recursive https://github.com/Superhouse/esp-open-rtos.git

USER root
RUN pip install esptool
USER user
