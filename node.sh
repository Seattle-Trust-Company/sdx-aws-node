#!/bin/bash


### Constants and Environment Variables

# Set-up Constants
NODE_DIR="./node"
DEFAULT_PWD_FILE="./data/default-password.txt"
GENESIS_PATH="./data/genesis.json"

# SDX Constants
SDX_HTTP_PORT=8000
SDX_PORT=30303
SDX_NET_ID=18930236
SDX_NAT_TYPE="any"

# Grab Environment Variables
SDX_BOOT_ENODE=${ENV_SDX_ENODE}
NODE_IDENT=${ENV_NODE_IDENT}


### Main Execution

# Create Node Directory
if [ ! -d "${NODE_DIR}" ]
then
  echo "Creating ${NODE_DIR}"
  mkdir ${NODE_DIR}
fi

# Create a New Account
if [ ! -d "${NODE_DIR}/keystore" ]
then
  echo "Creating New Account"
  geth account new --datadir ${NODE_DIR} --password ${DEFAULT_PWD_FILE}
fi

# Initialize Node with Genesis Block
if [ ! -d "${NODE_DIR}/geth" ]
then
  echo "Syncing Node with Genesis Block"
  geth --datadir ${NODE_DIR} init ${GENESIS_PATH}
fi

# Print Command for Debugging
echo 'Running Command'
echo "geth --datadir ${NODE_DIR} \
	--identity \"${NODE_IDENT}\" \
	--http \
	--http.port ${SDX_HTTP_PORT} \
	--http.api \"eth,net,web3,personal,miner,admin\" \
	--http.corsdomain \"*\" \
	--port ${SDX_PORT} \
	--networkid ${SDX_NET_ID} \
	--nat \"${SDX_NAT_TYPE}\" \
  --allow-insecure-unlock \
  --bootnodes \"${SDX_BOOT_ENODE}\" \
  --verbosity 6
"

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
  --bootnodes "${SDX_BOOT_ENODE}" \
  --verbosity 6

