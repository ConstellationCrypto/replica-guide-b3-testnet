#!/usr/bin/env bash

set -eu

if [ -z "${L1_RPC_URL:-}" ]; then
  echo "Set L1_RPC_URL (Base Sepolia RPC) before starting." >&2
  exit 1
fi

if [ ! -f jwt-secret.txt ]; then
  openssl rand -hex 32 > jwt-secret.txt
fi

if [ ! -f p2p-node-key.txt ]; then
  openssl rand -hex 32 > p2p-node-key.txt
fi

echo "Bringing up B3 testnet replica (op-reth + AltDA)..."
docker compose -f docker-compose-reth.yml up -d

echo "L2 RPC (reth):     http://localhost:${OP_RETH_RPC_PORT:-18545}"
echo "op-node rollup RPC: http://localhost:${OP_NODE_RPC_HOST_PORT:-27545}"
echo "Sync status: RPC_URL=http://localhost:${OP_NODE_RPC_HOST_PORT:-27545} bash progress.sh"
