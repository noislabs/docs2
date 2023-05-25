# Step By Step Guide to Randdrop

First things first, a randdrop is simply an airdrop with a final touch of
randomness to it. Meaning that not all preeligible wallets will get tokens but
only a random subset that will earn a larger portion of airdrop.

This randdrop aproach is used by Nois to airdrop NOIS tokens to other IBC
blockchains but also any other protocol wishing to make a randdrop using Nois
instead of a standard airdrop can follow this guide to randrop their tokens to
some community.

## How it works

A randdrop contract gets instantiated in any wasm-ibc chain (i.e the chain to
airdrop tokens to). The operator takes a snapshot of the chain in order to get a
state in time with the addresses to airdrop to with the respective amounts. This
snapshot is pretty much a json file like this
[file](https://gist.github.com/kaisbaccour/5a2f102ef476d533a3112b016aa45db4).
Then you merkelise the file, and feed the merkle root to the randdrop contract.
We aimed for a merkle randdrop because it is more elegant, cost efficient, safer
and not spammy. Then the operator communicates the community (twitter for
example) a time in the future for the random drand result and request that
future timestamp on chain from the nois-proxy (the randdrop contract takes care
of this after you feed it the time). When the future timestamp is reach Nois
sends the beacon as callback to the randdrop contract and the claiming can
start. Users can claim by checking the public json file containing what address
are pre-eligible, compute their merkle proof (the webapp UI does that for them)
and sends the proof to the randdrop contract which sends them the randdrop. Only
a subset of accounts are lucky enough (in this case 1/3) to receive the
randdrop. This is interesting because it allows protocols to target with their
airdrop a bigger number of communities/networks without diluting as much the
airdrop amount per account.

## Step by Step

### Get the snapshot

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
to communicate and merkelise

### Generate the merkle root

```sh
 merkle-airdrop-cli generateRoot --file juno-randdrop.json
```

Ouptut: 73d8ae84dddb8f99f08ecf141d0fb7d65fe8af7a2e4aeb7d6714f985d945851f

### Make sure Nois is connected tou your chain

Check if there is a nois-proxy already on your chain to use it for the
randomness. If there is no proxy you can create one yourself by following the
#integrate_nois_to_your_chain_section in these docs. If you have a nois-proxy
you can go ahead and move to the next step

### compile, store and instantiate the randdrop contract

```sh
# This repo contains nois contracts including the randdrop contract
 git clone https://github.com/noislabs/nois-contracts
 cd nois-contracts
```

Compile

```sh
# This command will generate wasm files
 devtools/build_integration_wasm.sh
```

Make sure that you have now a wasm file in this path

```sh
ls target/wasm32-unknown-unknown/release/nois_airdrop.wasm
```

Store

```sh
junod tx wasm store target/wasm32-unknown-unknown/release/nois_airdrop.wasm   \
--from deployment-key \
--chain-id=uni-6  \
--gas-prices 0.025ujunox \
--gas=auto --gas-adjustment 1.4  \
--broadcast-mode=block --node=https://rpc.uni.junonetwork.io:443
```

Instantiate

```sh
junod tx wasm instantiate2 1935 \
'{"manager":"juno1q6yvx8lxpheqflkcl0qf89czej4akrsfzc6xs2", "nois_proxy":"juno1pjpntyvkxeuxd709jlupuea3xzxlzsfq574kqefv77fr2kcg4mcqvwqedq"}' 01 \
--label=nois-airdrop --admin juno1q6yvx8lxpheqflkcl0qf89czej4akrsfzc6xs2 -\
-from deployment-key \
--chain-id uni-6 \
--gas=auto --gas-adjustment 1.2 --gas-prices=0.025ujunox \
--broadcast-mode=block --node=https://rpc.uni.junonetwork.io:443
```

### Register Merkle root in the contract

```sh
junod tx wasm execute juno14tfzmpl6kw2e6lyqzsvjgcqu7a9jhsneu0u4nvdv6znulps6xufqwlw2xf \
  '{"register_merkle_root":{"merkle_root":"73d8ae84dddb8f99f08ecf141d0fb7d65fe8af7a2e4aeb7d6714f985d945851f"}}' \
   --from deployment-key \
   --chain-id uni-6 \
   --gas=auto --gas-adjustment 1.2 --gas-prices=0.025ujunox \
   --broadcast-mode=block \
   --node=https://rpc.uni.junonetwork.io:443
```

### Request a randomness beacon from Nois

The timestamp needs to be in microseconds

```sh
junod tx wasm execute juno14tfzmpl6kw2e6lyqzsvjgcqu7a9jhsneu0u4nvdv6znulps6xufqwlw2xf \
 '{"rand_drop":{"random_beacon_after":1685188901000000000}}' \
 --amount 100ujunox \
  --from deployment-key \
  --chain-id uni-6 \
  --gas=auto --gas-adjustment 1.4 --gas-prices=0.025ujunox \
  --broadcast-mode=block \
  --node=https://rpc.uni.junonetwork.io:443
```

### Send the tokens to airdrop to the contract

The before the claiming can start you need to send the tokens to airdrop to the
contract. Otherwise the contract won't be able to give the tokens to users that
want to claim the randdrop

### Wait for the randomness round to be reached

This step is just waiting until the timestamp that you defined is reached. the
next drand round that is published after that time will be used for the
randdrop. In the meantime You can make a countdown on your frontend for the
users to know when the claiming phase can start

### Claiming phase

#### Claim from the cli

Calculate the merkle proof from the

- **juno-8372000-stakers-between-8-and-80K.json** json
  [file](https://gist.githubusercontent.com/kaisbaccour/963ecaa271796f914cc3d6db7b83369b/raw/6e47adf89d097cedbc94e1f9d0ba7b444e40156b/juno-8372000-stakers-between-8-and-80K.json)
- The address that will claim (needs to be in the file)
- the amount that the address holds (needs to match what's on the file )

```sh
merkle-airdrop-cli generateProofs \
--file juno-randdrop.json \
--address juno1etltrk88jyye62lynfd8e8zhnu0lxd9udsk8fc \
--amount 74711941
```

Output:

```sh
[
  'c683e9ab4d7cffc52606aa3ee171d124ae9a57f05e351e6e2603dfce436487dc',
  'ad23cc14faa5ac312e9d0ce8556adf2eec04aee3cb3c70c33bbb110e55c02da4',
  '80101b58bd9ed6b38a96030ab786dd3e57fa4c54a0c719871239c731e4f3e452',
  '8173ef4c7a10f807526d1c98d9dc3f31c1e1573d91e1a277f0d2402ae9f2a5a6',
  '1a8f1619448c2c5968c4f58cd78fe6fc3dba749de36c13f45ac8d541ae192d20',
  'a5f77a7ce77940a5f68af5ffe3992532d6178f23fdbc1238f5f84fab5cfa7243',
  'a7a1fdeea81e9a4b1a6b58703cc1da3f2dd1ae309734b69bd1caa00e321ee247',
  '477a2f2885e39be7a0c76c4a766c5ffa6a28bae066b58bbb868f9f008e6c4899',
  '50b409286902a470c10d1aac1014182606a587033a120cc71d49ea9974123bc3',
  '723f2b84752aae6f6243f54627d88169bcea8fa9d233accce2779bcab0d6cbfa',
  '3f1dca55c55b0feab7d40629d20e3f4a90dc908d129b628eff4a99219ca0782d',
  '49de319f3d929c6c7e6fd247bd84db8519d45b947afe92d0f7866a6d3fbf6d16',
  'a10acecae9b1c8dc795dee423f56fcc457a6f8ab567c0070eb33b4a6ed5913e2',
  'bda76c1358d096c74780011ebafc99b1af58ed51ee258a4013dd17b90240f63b',
  '471a3872ad818e02be2145a90d9558601311f88ecf556383c4b017627007c7b2',
  '669627ae91df85a1e236fee0b1ae2d65256d471e0307f34215574f54f6e26b8a',
  'e004b23a35d1994359a27f225cf2024f59325e24f4667c7bd6a2230c97d5e3bd'
]
```

Claim the randdrop from the contract by providing the proof

```sh
junod tx wasm execute juno14tfzmpl6kw2e6lyqzsvjgcqu7a9jhsneu0u4nvdv6znulps6xufqwlw2xf \
  '{"claim":{"amount":"74711941","proof":["c683e9ab4d7cffc52606aa3ee171d124ae9a57f05e351e6e2603dfce436487dc","ad23cc14faa5ac312e9d0ce8556adf2eec04aee3cb3c70c33bbb110e55c02da4","80101b58bd9ed6b38a96030ab786dd3e57fa4c54a0c719871239c731e4f3e452","8173ef4c7a10f807526d1c98d9dc3f31c1e1573d91e1a277f0d2402ae9f2a5a6","1a8f1619448c2c5968c4f58cd78fe6fc3dba749de36c13f45ac8d541ae192d20","a5f77a7ce77940a5f68af5ffe3992532d6178f23fdbc1238f5f84fab5cfa7243","a7a1fdeea81e9a4b1a6b58703cc1da3f2dd1ae309734b69bd1caa00e321ee247","477a2f2885e39be7a0c76c4a766c5ffa6a28bae066b58bbb868f9f008e6c4899","50b409286902a470c10d1aac1014182606a587033a120cc71d49ea9974123bc3","723f2b84752aae6f6243f54627d88169bcea8fa9d233accce2779bcab0d6cbfa","3f1dca55c55b0feab7d40629d20e3f4a90dc908d129b628eff4a99219ca0782d","49de319f3d929c6c7e6fd247bd84db8519d45b947afe92d0f7866a6d3fbf6d16","a10acecae9b1c8dc795dee423f56fcc457a6f8ab567c0070eb33b4a6ed5913e2","bda76c1358d096c74780011ebafc99b1af58ed51ee258a4013dd17b90240f63b","471a3872ad818e02be2145a90d9558601311f88ecf556383c4b017627007c7b2","669627ae91df85a1e236fee0b1ae2d65256d471e0307f34215574f54f6e26b8a","e004b23a35d1994359a27f225cf2024f59325e24f4667c7bd6a2230c97d5e3bd"]}}'\
    --from main \
    --chain-id uni-6 \
    --gas=auto --gas-adjustment 1.4 --gas-prices=0.025ujunox \
    --broadcast-mode=block \
    --node=https://rpc.uni.junonetwork.io:443
```

#### Claim from the UI

We can't expect every user to use the cli to claim their randdrop so you can
just use a UI like [Nois randdrop UI](https://github.com/noislabs/randdrop-ui)
to get the address from keplr, check the randdrop eligibility, computes the
merkle proof and executes the contract to claim the randdrop
