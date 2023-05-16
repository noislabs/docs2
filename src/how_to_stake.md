## How to stake

### Why staking

Staking
$NOIS helps secure the network and allows to earn rewards. Unstaking
$NOIS is
subject to some ubonding time period where you wait for your tokens to be
unstaked (21 days at the time of writing). During this period no rewards are
distributed.

### How and where to stake

You can use one of these web tools to stake NOIS:

- [Restake](https://restake.app/nois)
- [QuickStake](https://quickstake.io/nois-1/staking)
- [nois-stake.d-stake.xyz](https://nois-stake.d-stake.xyz/stake)

### Staking with the CLI

If you are familiar with CLI tools in the Cosmos ecosystem, you can use noisd
like any other chain to delegate, redelegate and unbond. However, please note
that this is only recommended for experienced users. Getting the parameters
wrong may have unintended consequences.

```sh
noisd tx staking delegate {VALIDATOR_ADDRESS} {AMOUN_IN_UNOIS}unois \
  --node "https://rpc.noismain.mcbnode.online:443" \
  --chain-id nois-1 \
  --gas auto --gas-adjustment 1.3 --gas-prices 0.05unois \
  --from {KEY_NAME} \
  --sign-mode amino-json --ledger \
  --broadcast-mode block
```
