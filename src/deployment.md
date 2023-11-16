# Deploying the randdrop

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
# This repo contains nois example contracts including the randdrop contract
 git clone https://github.com/noislabs/nois-dapp-examples
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
junod tx wasm store target/wasm32-unknown-unknown/release/randdrop.wasm   \
--from deployment-key \
--chain-id=uni-6  \
--gas-prices 0.025ujunox \
--gas=auto --gas-adjustment 1.4  \
--broadcast-mode=block --node=https://rpc.uni.junonetwork.io:443
```

Instantiate

```sh
junod tx wasm instantiate2 1935 \
'{"manager":"juno1q6yvx8lxpheqflkcl0qf89czej4akrsfzc6xs2", "nois_proxy_address":"juno1pjpntyvkxeuxd709jlupuea3xzxlzsfq574kqefv77fr2kcg4mcqvwqedq","nois_proxy_denom":"ibc/717352A5277F3DE916E8FD6B87F4CA6A51F2FBA9CF04ABCFF2DF7202F8A8BC50","nois_proxy_amount":"50000000","randdrop_denom":"ibc/717352A5277F3DE916E8FD6B87F4CA6A51F2FBA9CF04ABCFF2DF7202F8A8BC50","merkle_root":"73d8ae84dddb8f99f08ecf141d0fb7d65fe8af7a2e4aeb7d6714f985d945851f", "test_mode":true}' 01 \
--label=randdrop --admin juno1q6yvx8lxpheqflkcl0qf89czej4akrsfzc6xs2 -\
-from deployment-key \
--chain-id uni-6 \
--gas=auto --gas-adjustment 1.2 --gas-prices=0.025ujunox \
--broadcast-mode=block --node=https://rpc.uni.junonetwork.io:443
```

### Send the tokens to airdrop to the contract

The before the claiming can start you need to send the tokens to airdrop to the
contract. Otherwise the contract won't be able to give the tokens to users that
want to claim the randdrop

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

Participate in the randdrop by providing the proof

```sh
junod tx wasm execute juno14tfzmpl6kw2e6lyqzsvjgcqu7a9jhsneu0u4nvdv6znulps6xufqwlw2xf \
  '{"participate":{"amount":"74711941","proof":["c683e9ab4d7cffc52606aa3ee171d124ae9a57f05e351e6e2603dfce436487dc","ad23cc14faa5ac312e9d0ce8556adf2eec04aee3cb3c70c33bbb110e55c02da4","80101b58bd9ed6b38a96030ab786dd3e57fa4c54a0c719871239c731e4f3e452","8173ef4c7a10f807526d1c98d9dc3f31c1e1573d91e1a277f0d2402ae9f2a5a6","1a8f1619448c2c5968c4f58cd78fe6fc3dba749de36c13f45ac8d541ae192d20","a5f77a7ce77940a5f68af5ffe3992532d6178f23fdbc1238f5f84fab5cfa7243","a7a1fdeea81e9a4b1a6b58703cc1da3f2dd1ae309734b69bd1caa00e321ee247","477a2f2885e39be7a0c76c4a766c5ffa6a28bae066b58bbb868f9f008e6c4899","50b409286902a470c10d1aac1014182606a587033a120cc71d49ea9974123bc3","723f2b84752aae6f6243f54627d88169bcea8fa9d233accce2779bcab0d6cbfa","3f1dca55c55b0feab7d40629d20e3f4a90dc908d129b628eff4a99219ca0782d","49de319f3d929c6c7e6fd247bd84db8519d45b947afe92d0f7866a6d3fbf6d16","a10acecae9b1c8dc795dee423f56fcc457a6f8ab567c0070eb33b4a6ed5913e2","bda76c1358d096c74780011ebafc99b1af58ed51ee258a4013dd17b90240f63b","471a3872ad818e02be2145a90d9558601311f88ecf556383c4b017627007c7b2","669627ae91df85a1e236fee0b1ae2d65256d471e0307f34215574f54f6e26b8a","e004b23a35d1994359a27f225cf2024f59325e24f4667c7bd6a2230c97d5e3bd"]}}'\
    --from main \
    --chain-id uni-6 \
    --gas=auto --gas-adjustment 1.4 --gas-prices=0.025ujunox \
    --broadcast-mode=block \
    --node=https://rpc.uni.junonetwork.io:443
```

As soon as the randomness is published the relayer will trigger the contract and
give the winner participant their airdrop

#### Claim from the UI

We can't expect every user to use the cli to claim their randdrop so you can
just use a UI like [Nois randdrop UI](https://github.com/noislabs/randdrop-ui)
to get the address from keplr, check the randdrop eligibility, computes the
merkle proof and executes the contract to claim the randdrop
