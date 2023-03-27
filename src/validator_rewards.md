# Validator Rewards

Nois rewards the network's validators by allocating a 6% of the inflation to validators in the active set.
In contrast to staking rewards, every validator receives the same amount and it is not shared with stakers.
This is an attempt to reduce concentration of voting power in a very few validators.

Learn how to query accumulated rewards and how to claim them.

### Querying

```
# query by address
noisd q allocation claimable-rewards nois1r04t9nm22u2wfwpuffgyr8jgxs85ek0clsytvs

# query by operator address
noisd q allocation claimable-rewards noisvaloper1r04t9nm22u2wfwpuffgyr8jgxs85ek0c7sk24y
```

### Claiming Rewards

```
noisd tx allocation claim-rewards --from [validator-key] \
    --chain-id  [chain-id] --gas-prices 0.25unois --gas-adjustment 1.5
```
