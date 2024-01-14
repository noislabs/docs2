# IBC wasm relayer

> In this tutorial we are using the hermes relayer software.
> However, feel free to use other relayer software like Hermes and if you want
> to contribute to the docs by providing the steps for setting up such different
> software let us know on discord

---

Setting up hermes relayer

Install hermes from this [link](https://hermes.informal.systems/quick-start/installation.html)

Confgure hermes

```toml
[global]
log_level = 'info'
[mode]
[mode.clients]
enabled = true
refresh = true
misbehaviour = false
[mode.connections]
enabled = false
[mode.channels]
enabled = false
[mode.packets]
enabled = true
clear_interval = 5
clear_on_start = true
tx_confirmation = false
[rest]
enabled = true
host = '127.0.0.1'
port = 3000
[telemetry]
enabled = true
host = '127.0.0.1'
port = 3001


[[chains]]
id = "nois-testnet-005"
type = "CosmosSdk"
memo_prefix = 'Relayed by Katarina'
rpc_addr = "https://nois-testnet-rpc.polkachu.com:443"
grpc_addr = "https://tnois-grpc.systemd.run:443"
event_source = { mode = 'pull', interval = '1s' }

rpc_timeout = "10s"
account_prefix = "nois"
key_name = "mynoiskey"
key_store_type = "Test"
store_prefix = "ibc"
default_gas = 100000
max_gas = 4000000
gas_multiplier = 1.1
max_msg_num = 30
max_tx_size = 180000
max_grpc_decoding_size = 33554432
clock_drift = "5s"
max_block_time = "30s"
ccv_consumer_chain = false
sequential_batch_tx = false

[chains.trust_threshold]
numerator = "1"
denominator = "3"

[chains.gas_price]
price = 0.1
denom = "unois"

[chains.packet_filter]
policy = "allowall"

[chains.packet_filter.min_fees]

[chains.address_type]
derivation = "cosmos"

##################
#Mainnet
#################

[[chains]]
id = 'nois-1'
address_type = { derivation = 'cosmos' }
memo_prefix = 'Relayed by Katarina'
ccv_consumer_chain = false
event_source = { mode = 'pull', interval = '1s' }

rpc_addr = 'https://nois-rpc.nysa.network:443'
grpc_addr = 'http://nois.grpc.m.stavr.tech:191'

rpc_timeout = '20s'
account_prefix = 'nois'
key_name = 'nois'
store_prefix = 'ibc'
max_tx_size = 180000
max_msg_num=15
max_gas= 4000000
gas_price = { price = 0.5, denom = 'unois' }
gas_multiplier = 1.5
max_block_time = '5s'
clock_drift = '5s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
[chains.packet_filter]
policy = "allowall"

###########################

[[chains]]
id = 'uni-6'
type = "CosmosSdk"
event_source = { mode = 'pull', interval = '1s' }
memo_prefix = 'Relayed by Katarina'

rpc_addr = 'https://juno-testnet-rpc.polkachu.com:443'
grpc_addr = 'http://juno-testnet-grpc.polkachu.com:12690'
#poll_interval= '1s'

rpc_timeout = '10s'
account_prefix = 'juno'
key_name = 'juno'
store_prefix = 'ibc'
max_tx_size = 180000
max_msg_num=30
max_gas= 40000000
gas_price = { price = 0.025, denom = 'ujunox' }
gas_multiplier = 1.2
max_block_time = '15s'
clock_drift = '5s'
trusting_period = '14days'
trust_threshold = { numerator = '1', denominator = '3' }
ccv_consumer_chain = false
sequential_batch_tx = false
[chains.packet_filter]
policy = "allowall"
[chains.address_type]
derivation = "cosmos"

###########################
```

## Relay traffic
```sh
hermes start
```

## Set up a new  client, connection and channels
#### Create ibc clients

```sh
hermes create client --host-chain uni-6 --reference-chain nois-testnet-005 --clock-drift 20s
#Note the client id created by this operation (will be needed later on)
hermes create client --host-chain nois-testnet-005 --reference-chain uni-6 --clock-drift 20s
#Note the client id created by this operation (will be needed later on)
```

#### Create ibc connection

```sh
#07-tendermint-19  is the client id that was generated when creating the client on uni-6
#07-tendermint-14  is the client id that was generated when creating the client on nois-testnet-005
hermes create connection --a-chain nois-1  --a-client 07-tendermint-14  --b-client   07-tendermint-19 
```

#### Create transfer channel

```sh
#change the xxx with the connection-id on uni-6 point to nois
hermes create channel --a-chain uni-6 --a-connection connection-xxx --a-port transfer  --b-port trasnfer
```

#### Create wasm channel

```sh
hermes create channel --a-chain uni-6 --a-connection connection-72 --a-port wasm.juno1blablabla(uni proxy address)  --b-port wasm.noisblabla(nois gateway address)  --channel-version nois-v7
```




