# @file
# @desc  Starts up node
FROM ubuntu-geth
WORKDIR /app
ENV POOL=breakbot
ENV DIR=data/${POOL}
COPY data /app/data
COPY ${DIR}/keystore /app/node/keystore
COPY node.sh /app/
EXPOSE 30303/tcp 30303/udp
EXPOSE 8000/tcp
CMD ./node.sh
