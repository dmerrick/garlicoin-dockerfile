FROM ubuntu:16.04

# Headless
ENV DEBIAN_FRONTEND noninteractive

# Release information
ENV GARLICOIN_ARCHIVE  Garlicoin-x86_64-unknown-linux-gnu.tar.gz
ENV GARLICOIN_RELEASE  https://github.com/GarlicoinOrg/Garlicoin/releases/download/20180121185844-arm-linux-gnueabihf/$GARLICOIN_ARCHIVE
ENV GARLICOIN_DIR      /opt/garlicoin
ENV GARLICOIN_DATA_DIR /root/.garlicoin

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
  # for cpuminer
  automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ \
  && rm -rf /var/cache/apk/*

# Download and install the Garlicoin release
RUN cd /tmp \
  && wget ${GARLICOIN_RELEASE} \
  && tar xvf ${GARLICOIN_ARCHIVE} --strip 1 \
  && mkdir -p ${GARLICOIN_DIR} \
  && cp -r bin ${GARLICOIN_DIR} \
  && rm -rf /tmp

# Add to PATH
ENV PATH $GARLICOIN_DIR/bin:$PATH

# Download build, and install cpuminer
RUN cd /tmp \
  && git clone https://github.com/tpruvot/cpuminer-multi.git \
  && cd cpuminer-multi && ./build.sh && make install \
  && rm -rf /tmp

# Expose RPC and P2P ports
ENV RPC_PORT 42068
ENV P2P_PORT 42069
EXPOSE ${RPC_PORT} ${P2P_PORT}

# Run the daemon script
COPY init.sh ${GARLICOIN_DIR}
WORKDIR ${GARLICOIN_DIR}
CMD [ "./init.sh" ]
