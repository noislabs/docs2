# Interacting with a DAPP

This document intends to help developers test the example contracts that are
provided by nois Clone the double-dice game code

```shell
git clone https://github.com/noislabs/nois-dapp-examples.git
cd nois-dapp-examples
```

Compile and optimise the code

```shell
RUSTFLAGS="-C link-arg=-s" cargo build --release --target=wasm32-unknown-unknownStoring the contract:
```

Store the contract

```shell
junod tx wasm store \
       target/wasm32-unknown-unknown/release/double_dice_roll.wasm \
       --from <your-key> \
       --chain-id uni-6 \
       --gas=auto \
       --gas-adjustment 1.4  \
       --gas-prices 0.025ujunox \
       --broadcast-mode=block \
       --node=https://rpc.uni.juno.deuslabs.fi:443 -y 
```

Instantiate the contract

```shell
export NOIS_PROXY=juno1tquqqdvlv3fwu5u6evpt7e4ss47zczug8tq4czjucgx8dulkhjxsegfuds
junod tx wasm instantiate CODE_ID_FROM_PREVIOUS_STEP \
       '{"nois_proxy": "'"$NOIS_PROXY"'"}' \
       --label=double-dice \
       --no-admin \
       --from <your-key> \
       --chain-id uni-6 \
       --gas=auto \
       --gas-adjustment 1.4 \
       --fees=1000000ujunox \
       --broadcast-mode=block \
       --node=https://rpc.uni.juno.deuslabs.fi:443 -y 
```

Request randomness (ie. roll the dice)

```shell
export DOUBLE_DICE_ROLL_CONTRACT=juno1e7p6k4c0l52zperyhd6nfx053yrdgjw4k6kunszhk9j0smedgtzs27nrkh

junod tx wasm execute $DOUBLE_DICE_ROLL_CONTRACT \
            '{"roll_dice": {"job_id": "<your-job-id>"}}' \
            --from <your-key> \
            --gas-prices 0.025ujunox \
            --gas=auto \
            --gas-adjustment 1.3 \
            --amount 100ujunox -y
```

Query the randomness

```shell
junod query wasm  contract-state  smart \
            $DOUBLE_DICE_ROLL_CONTRACT  \
            '{"get_history_of_rounds": {}}' \
            --node=https://rpc.uni.juno.deuslabs.fi:443
```
