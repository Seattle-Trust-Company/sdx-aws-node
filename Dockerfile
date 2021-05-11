# @file
# @desc  Starts up node
FROM ubuntu-geth
WORKDIR /app
ENV POOL=babyrays
ENV DIR=data/${POOL}
COPY data /app/data
COPY ${DIR}/keystore /app/node/keystore
COPY node.sh /app/
EXPOSE 30305/tcp 30305/udp
EXPOSE 8002/tcp
CMD ./node.sh
