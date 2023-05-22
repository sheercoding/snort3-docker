FROM ubuntu:22.04



# DEB_DEPENDS from VPP's Makefile, added here to be cached
# This must be updated when the list of VPP dependencies change
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	build-essential python3 autotools-dev \
	libdumbnet-dev libluajit-5.1-dev libpcap-dev \
	libpcre3 libpcre3-dev \
	zlib1g-dev pkg-config libhwloc-dev \
	cmake liblzma-dev openssl \
	libssl-dev cpputest libsqlite3-dev \
	libtool uuid-dev git \
	autoconf bison flex \
	libcmocka-dev libnetfilter-queue-dev libunwind-dev \
	libmnl-dev ethtool wget \
	net-tools iputils-ping vim && \
	apt-get clean && \
	echo 'export TERM=xterm-256color' >> ~/.bashrc


ENV BUILT_DIR=/opt
WORKDIR ${BUILT_DIR}

RUN \
	git clone https://github.com/snort3/libdaq.git && \
	cd libdaq && \
	./bootstrap  && \
	./configure && \
	make -j && \
	make install && \
	ldconfig && \
	cd .. && \
	git clone https://github.com/snort3/snort3.git && \
	cd snort3 && \
	./configure_cmake.sh --prefix=/usr/local && \
	cd build/ && \
	make -j && \
	make install && \
	cd ../.. && \
	rm * -rf 

WORKDIR /opt
ADD entrypoint.sh /opt
RUN chmod a+x /opt/entrypoint.sh
# ENTRYPOINT ["/opt/entrypoint.sh"]