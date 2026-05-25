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

## op-reth replica (AltDA)

Uses [docker-compose-reth.yml](docker-compose-reth.yml) with:

- **op-reth** `public.ecr.aws/i6b2w2n6/op-reth:v2.2.3`
- **op-node** `public.ecr.aws/i6b2w2n6/op-node:1.16.1-celestia-e9ec322-altda` ([AltDA mode](https://docs.optimism.io/builders/chain-operators/features/alt-da-mode))
- **op-alt-da** `public.ecr.aws/i6b2w2n6/op-alt-da:v0.12.0` ([celestiaorg/op-alt-da](https://github.com/celestiaorg/op-alt-da))

Pattern follows [replica-guide-manta-testnet PR #4](https://github.com/ConstellationCrypto/replica-guide-manta-testnet/pull/4).

### Reth datadir snapshot (recommended)

Download and extract into `./b3-testnet-reth-datadir` before the first start:

https://caldera-chain-data-snapshots.s3.us-west-2.amazonaws.com/exported-snapshots/bedrock-b3-testnet/bedrock-b3-testnet-reth-2026-May-14.tar

### Configure op-alt-da

Edit [op-alt-da-config.toml](op-alt-da-config.toml): set Celestia bridge/core gRPC URLs, auth tokens, and `default_key_name` (AWS KMS key). The host needs AWS credentials or an IAM role for `keyring_backend = "awskms"`.

### Run

```bash
export L1_RPC_URL=<base-sepolia-rpc>
make b3-reth-up
# or: docker compose -f docker-compose-reth.yml up -d
```

Rollup sync status (default op-node port `27545`):

```bash
RPC_URL=http://localhost:27545 bash progress.sh
```

    make b3-reth-down

# Celestia upgrades
Please refer to celestia docs for network upgrades: https://docs.celestia.org/how-to-guides/participate#network-upgrades
