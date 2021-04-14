# @file
# @desc  Starts up node
FROM ubuntu-geth
WORKDIR /app
COPY data /app/data
COPY node/keystore /app/node/keystore
COPY node.sh /app/
EXPOSE 3000/tcp 3000/udp
EXPOSE 8000/tcp
CMD ./node.sh
