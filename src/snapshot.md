# Randdrop Snapshot

### Export the snapshot

The goal of this step is to get a list of addresses to make eligible for the
randdrop. In this example we're going to airddrop to juno-1 network delegators

- First you need to install junod
- Run and sync a junod node
- make a snapshot (i.e get the state ofthe chain at a specific height). ps: I
  did this step with 60GB of memory (RAM+SWAP) and it can take few hours
  tofinish

```sh
junod export --height 8372000  > juno-8372000.json
```

This step will leave you with a big **juno-8372000.json** file that contains all
the state. Let's filter it out to get only the juno stakers.

### Process the snapshot

Get the stakers list

```sh
cat juno-8372000.json \
| jq '[.app_state.staking.delegations | group_by(.delegator_address) | map({address: .[0].delegator_address, amount: (map(.shares | tonumber) | add)})][0]' \
| jq 'sort_by(-.amount)' \
> juno-8372000-stakers.json
```

now we are left with this **juno-8372000-stakers.json**
[file](https://gist.githubusercontent.com/kaisbaccour/fb33926ffd88f8169ba9135e413330e2/raw/9c1d839fa56d9b92997fdf56aa31ce53643dae66/juno-8372000-stakers.json)
that holds juno stakers and the amount they have staked at block height
**8372000**.

We want to filter out accounts that have less than \$4USD (at the time of
writing juno is worth \$0.5 so let's filter out all wallets with less than 8juno
staked). Also there might be wallets with huge amounts, let's say that we want
to make a max cap on \$40K airddrop so wallets with $40K staked or more will get
the same amount

```sh
cat juno-8372000-stakers.json \
|jq '[.[] | select(.amount >= 8000000)]' \
| jq 'map(if .amount > 80000000000 then .amount = 80000000000 else . end)'  \
> juno-8372000-stakers-between-8-and-80K.json
```

This leaves us with a **juno-8372000-stakers-between-8-and-80K.json** json
[file](https://gist.githubusercontent.com/kaisbaccour/963ecaa271796f914cc3d6db7b83369b/raw/6e47adf89d097cedbc94e1f9d0ba7b444e40156b/juno-8372000-stakers-between-8-and-80K.json).

Now the amounts are in juno so you might wanna multiply them by how much you
want to give on your airdrop token per ujuno.

In this case, we want to airdrop 2,6M NOIS to juno chain. This means we want to
airdrop **0.07340892389** unois per ujuno

```sh
 export CONVERSION_RATE=0.07340892389
 cat juno-8372000-stakers-between-8-and-80K.json \
 | jq --argjson multiplier $CONVERSION_RATE 'map(if .amount | type == "number"   then .amount |= (. * $multiplier | floor)  else .  end)' \
 > juno-randdrop.json
```

This will leave us with the final **juno-randdrop.json**
[file](https://gist.githubusercontent.com/kaisbaccour/5a2f102ef476d533a3112b016aa45db4/raw/aa94b4d6682536ac518d1e98367b6bbc0eac5740/juno-randdrop.json)
to communicate and merkelise in the next section
