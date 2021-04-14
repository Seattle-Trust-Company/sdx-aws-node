# @file
# @desc  Starts up node
FROM ubuntu-geth
WORKDIR /app
COPY data /app/data
COPY node.sh /app/
EXPOSE 30303/tcp 30303/udp
EXPOSE 8000/tcp
CMD ./node.sh
