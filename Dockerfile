FROM debian:jessie-slim
LABEL maintainer="Erik Rogers <erik.rogers@live.com>"

# Headless
ENV DEBIAN_FRONTEND noninteractive

# Release information
ENV GARLICOIN_PACKAGE Garlicoin-x86_64-unknown-linux-gnu
ENV GARLICOIN_ARCHIVE $GARLICOIN_PACKAGE.tar.gz
ENV GARLICOIN_RELEASE https://github.com/GarlicoinOrg/Garlicoin/releases/download/20180121185844-arm-linux-gnueabihf/$GARLICOIN_ARCHIVE

ENV GARLICOIN_DIR /opt/garlicoin

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
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

# Set data directory path
ENV GARLICOIN_DATA_DIR /mnt/garlicoin

# Copy scripts
COPY start-daemon.sh ${GARLICOIN_DIR}

# Set executable flag
RUN chmod +x ${GARLICOIN_DIR}/*.sh

# Expose RPC and P2P ports
ENV RPC_PORT 42068
ENV P2P_PORT 42069

EXPOSE ${RPC_PORT} ${P2P_PORT}

# Run the daemon script
WORKDIR ${GARLICOIN_DIR}
CMD [ "./start-daemon.sh" ]
