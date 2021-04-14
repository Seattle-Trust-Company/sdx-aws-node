#!/bin/bash


### Constants and Environment Variables

# Set-up Constants
NODE_DIR="./node"
DEFAULT_PWD_FILE="./data/default-password.txt"
GENESIS_PATH="./data/genesis.json"
NODE_IDENT=${NODE_IDENT}

# SDX Constants
SDX_HTTP_PORT=8000
SDX_PORT=30303
SDX_NET_ID=18930236
SDX_NAT_TYPE="any"

# Create Bootnodes
SDX_BOOT_IP=${SDX_BOOT_IP}
SDX_BOOT_PORT=30303
SDX_BOOT_ENODE_KEY="7c38f8796bac5bbfd7ef54ba98a7990cf3ee1be6e9adf9751338c1a23a2f5772b7eb8b221d412e1a718dee46dfd008a5b56682951961c99bba423780509c0e44"
SDX_BOOT_ENODE="enode://${SDX_BOOT_ENODE_KEY}@${SDX_BOOT_IP}:${SDX_BOOT_PORT}"


### Main Execution

# Create Node Directory with New Account
if [ ! -d "${NODE_DIR}" ]
then
  # Create Directory
  mkdir ${NODE_DIR}

  # Create a New Account
  geth account new --datadir ${NODE_DIR} --password ${DEFAULT_PWD_FILE}

  # Initialize Boot with Genesis Block
  geth --datadir ${NODE_DIR} init ${GENESIS_PATH}
fi
  

# Start-Up Boot Node
geth --datadir ${NODE_DIR} \
	--identity "${NODE_IDENT}" \
	--http \
	--http.port ${SDX_HTTP_PORT} \
	--http.api "eth,net,web3,personal,miner,admin" \
	--http.corsdomain "*" \
	--port ${SDX_PORT} \
	--networkid ${SDX_NET_ID} \
	--nat "${SDX_NAT_TYPE}" \
  --allow-insecure-unlock \
  --bootnodes "${SDX_BOOT_ENODE}"

