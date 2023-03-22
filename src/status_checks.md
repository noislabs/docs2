# Status checks

On this page you find various ways to check the status of your node.

## p2p

1. Ensure your external address is set correctly:\
   `curl -sS http://localhost:26657/status | jq .result.node_info.listen_addr`
2. Ensure you have a few dozen peers here:\
   `curl -sS http://localhost:26657/net_info | jq .result.n_peers`
3. Ensure you have a mix of outbound and inbound peers (i.e. both outgoing and incoming connections work:\
   `curl -sS http://localhost:26657/net_info | jq | grep is_outbound`

## Sync

1. Check your height and catching up value:\
   `curl -sS http://localhost:26657/status | jq .result.sync_info`
