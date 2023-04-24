FROM ubuntu

RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get install -y iputils-ping && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd

RUN useradd -ms /bin/bash newuser
RUN adduser newuser sudo
RUN echo 'newuser:newpassword' | chpasswd


CMD ["/usr/sbin/sshd", "-D"]

