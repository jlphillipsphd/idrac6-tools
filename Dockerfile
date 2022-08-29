FROM ubuntu:trusty
LABEL maintainer="Joshua L. Phillips <https://www.cs.mtsu.edu/~jphillips/>"
LABEL version=2022-08-29

# Install administrative toolchain and graphical tools
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y apt-transport-https ca-certificates && \
    echo "deb https://linux.dell.com/repo/community/ubuntu trusty openmanage" > /etc/apt/sources.list.d/linux.dell.com.sources.list && \
    gpg --keyserver keyserver.ubuntu.com --recv-key 1285491434D8786F && gpg -a --export 1285491434D8786F | apt-key add -

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
       srvadmin-idracadm \
       libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 \
       default-jre:i386 \
       openbox \
       x11vnc \
       xvfb \
       && apt-get clean

ENV PATH="/opt/dell/srvadmin/bin:/opt/dell/srvadmin/sbin:${PATH}"
RUN update-java-alternatives -s java-1.7.0-openjdk-i386
COPY startup.sh /usr/local/bin/.
COPY start-virtual-console.sh /usr/local/bin/.
COPY lib/ /usr/local/lib/

RUN mkdir -p /root/.config/openbox
COPY autostart /root/.config/openbox/.

CMD ["/usr/local/bin/startup.sh"]
