# B3 Testnet Replica
=============
To use: Then run `make b3-up`.

A number of constants have already been set to align with the b3 testnet:
- Beacon chain API for sepolia
- the sequencer http url, which allows for transactions sent to the replica node to be forwarded to the sequencer, effectively meaning you can use the replica node like a full rpc provider
- the p2p endpoint, which means that the replica can the latest blocks produced from a trusted source

To check on the sync status of the node:

    RPC_URL=http://localhost:7545
	curl $RPC_URL -X POST -H "Content-Type: application/json" --data \
	    '{"jsonrpc":"2.0","method":"optimism_syncStatus","params":[],"id":1}' | jq .


or `bash progress.sh`



Commands:
=========

    make b3-up

    make b3-down

    make b3-clean

# Celestia upgrades
Please refer to celestia docs for network upgrades: https://docs.celestia.org/how-to-guides/participate#network-upgrades
