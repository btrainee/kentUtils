FROM ubuntu:14.04
RUN apt-get update &&\
    apt-get install -y software-properties-common
RUN apt-get install -y build-essential wget curl git autoconf automake && \
    apt-get install -y gcc g++ bison make cmake perl && \
    apt-get install -y zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev && \
    apt-get install -y libssl-dev libtool libncurses5-dev liblpsolve55-dev rsync librsync-dev && \
    apt-get install -y python python-dev python-pip && \
    apt-get install -y libz-dev libssl-dev openssl libpng12-dev mysql-client libmysqlclient-dev 
RUN apt-get install -y --reinstall ca-certificates
RUN update-ca-certificates
RUN apt-get -y autoremove
RUN git config --global http.sslverify false

# Install kentUtils
ENV INSTALL_DIR "/opt/programs"
RUN mkdir -p ${INSTALL_DIR}
WORKDIR ${INSTALL_DIR}
RUN git clone https://github.com/ENCODE-DCC/kentUtils.git  && \
    cd kentUtils && \
    make && \
    cp -rp bin/* /usr/local/bin && \
    cd .. && rm -rf kentUtils

# Create UCSC public MySQL server configuration
RUN echo "db.host=genome-mysql.cse.ucsc.edu\ndb.user=genomep\ndb.password=password" > /root/.hg.conf
