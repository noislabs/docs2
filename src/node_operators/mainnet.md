# Mainnet

## Basic info

- Chain ID: `nois-1`
- Demon: `unois`

## Genesis

- Time: March 28th 15:00 UTC
- URL:
  <https://raw.githubusercontent.com/noislabs/networks/nois1.final.1/nois-1/genesis.json>
- Checksum (sha256):
  `5332fb6477a2d273fd7e5a13bceb213e2a9d408a698c49ab34e8b78736e58cac`

## Binary

- Build `noisd` from <https://github.com/noislabs/noisd>
- Tag: v1.0.5
- `noisd version` should show 1.0.2
Running a node is similar to most other cosmos-sdk chains. but you can follow this tutorial made by one of Nois validators [here](https://github.com/obajay/StateSync-snapshots/tree/main/Projects/Nois)

## Explorers, p2p, RPCs, Rest and GRPC endpoints

Check the list in chain registry [here](https://github.com/cosmos/chain-registry/blob/master/nois/chain.json) 

## Contracts

#### nois-drand

```yaml
- Name: nois-drand
  Address: nois19w26q6n44xqepduudfz2xls4pc5lltpn6rxu34g0jshxu3rdujzsj7dgu8
  Code ID: "20"
  Git Asset Name: nois_drand
  Instantiation Message: '{"incentive_point_price":"3000","incentive_denom":"unois","min_round":808287,"manager":"nois1p9tw323xdjp5q3yzuecfahmgrpufmm89z93wpk"}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.15.4
  Config:
    gateway: nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp
    incentive_denom: unois
    incentive_point_price: "3000"
    manager: nois1p9tw323xdjp5q3yzuecfahmgrpufmm89z93wpk
    min_round: 808287
```

#### nois-icecube

```yaml
- Name: nois-icecube
  Address: nois1gwnfyx82rwgc4y9r8vx6nr9v35dwezw3dadw6h39mad9amg7shnsler5f0
  Code ID: "6"
  Git Asset Name: nois_icecube
  Instantiation Message: '{"manager":"nois1p9tw323xdjp5q3yzuecfahmgrpufmm89z93wpk"}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.11.0
```

#### nois-sink

```yaml
- Name: nois-sink
  Address: nois10c0ppz0n57hqrmfp7g7lqs6k4xk9rxhvcfkqt83r8mars2lc57mq0f6cty
  Code ID: "5"
  Git Asset Name: nois_sink
  Instantiation Message: "{}"
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.11.0
```

#### nois-gateway

```yaml
- Name: nois-gateway
  Address: nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp
  Code ID: "21"
  Git Asset Name: nois_gateway
  Instantiation Message: '{"manager":"nois1p9tw323xdjp5q3yzuecfahmgrpufmm89z93wpk","price":{"denom":"unois","amount":"50000000"},"payment_code_id":7,"sink":"nois10c0ppz0n57hqrmfp7g7lqs6k4xk9rxhvcfkqt83r8mars2lc57mq0f6cty"}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.15.4
  Config:
    drand: nois19w26q6n44xqepduudfz2xls4pc5lltpn6rxu34g0jshxu3rdujzsj7dgu8
    manager: nois1p9tw323xdjp5q3yzuecfahmgrpufmm89z93wpk
    payment_code_id: 7
    payment_initial_funds: null
    price:
      amount: "1000000"
      denom: unois
    sink: nois10c0ppz0n57hqrmfp7g7lqs6k4xk9rxhvcfkqt83r8mars2lc57mq0f6cty
```

### Proxies

| Chain                    | proxy address                                                      | manager/owner        | 
| -------------------------| -------------------------------------------------------------------| -------------------- | 
| Aura                     | aura1r3zgdsn3dcze07a4r60rxxx7ppvkxfshn9np0pwtkgarrld0786s72jtjt    |  Aura team           | 
| Juno                     | juno1qr84ktm57q5t02u04ddk5r8s79axdzglad6tfdd9g2xgt4hkh6jsgeq9x2    | Nois team            | 
| Juno                     | juno1avjq06m3l03pl2k8ecvpdhkzrld8s3x48qvhp8merhfjh753vvdskqqs74    | Gelotto              | 
| Injective                | inj1w9g3sk7lk8k0pdtctygupt6f3te7x4thvzz57a                         | Injective Governance | 
| Archway                  | archway10f3aasgsnpv84ymjyld50jayc4ecu267sdpjamauwm8nvxlzex9qj4dkwr | Architech            | 
| Stargaze                 | stars1mw5y55f53mnara7g3pn2pylxl8dpauscyn83c68442hz9nwktzrq8tjzyf   | Stargaze Governance  | 
| Osmosis                  | osmo1tvzr8ur0ynjhqftxpkl4qwel8ly7erhy6cu6ks426xmzf92vk6eqfp9wcl    | Nois team            | 
| Sei                      | sei1vxlzhn6qvf95syha2tgr0ct23sk5359s2vqzylgthuyy7kd7ql5qcxa4r0     | Parker               | 

## IBC channels

Right now the following IBC channels are supported:

| Protocol | Other chain             | Channel (nois-1) | Channel (other chain) | Description             |
| -------- | ----------------------- | ---------------- | --------------------- | ----------------------- |
| ICS-20   | Aura (xstaxy-1)         | [channel-16]     | channel-3             | aura-nois transfer      |
| ICS-20   | Injective (injective-1) | [channel-17]     | channel-138           | injective-nois transfer |
| ICS-20   | Juno (juno-1)           | [channel-1]      | channel-225           | juno-nois transfer      |
| ICS-20   | Osmosis (osmosis-1)     | [channel-37]     | channel-8277          | osmosis-nois transfer   |
| ICS-20   | Stargaze (stargaze-1)   | [channel-0]      | channel-137           | stars-nois transfer     |
| ICS-20   | Archway (archway-1)     | [channel-21]     | channel-17            | archway-nois transfer   |
| ICS-20   | Sei (pacific-1)         | [channel-43]     | channel-58            | sei-nois transfer       |
| nois-v7  | Aura (xstaxy-1)         | [channel-35]     | channel-8             | Aura team managed       |
| nois-v7  | Juno (juno-1)           | [channel-2]      | channel-243           | Public proxy            |
| nois-v7  | Juno (juno-1)           | [channel-11]     | channel-248           | Gelotto                 |
| nois-v7  | Injective (injective-1) | [channel-20]     | channel-140           | Injective governance    |
| nois-v7  | Archway (archway-1)     | [channel-22]     | channel-19            | Architech proxy         |
| nois-v7  | Stargaze (stargaze-1)   | [channel-38]     | channel-238           | Stargaze governance     |
| nois-v7  | Osmosis (osmosis-1)     | [channel-41]     | channel-11319         | Public proxy            |
| nois-v7  | Sei (pacific-1)         | [channel-44]     | channel-59            | Public proxy            |

[channel-0]:
  https://ibc.nois.network/connections/connection-0/channels/transfer:channel-0
[channel-1]:
  https://ibc.nois.network/connections/connection-2/channels/transfer:channel-1
[channel-2]:
  https://ibc.nois.network/connections/connection-2/channels/wasm.nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp:channel-2
[channel-11]:
  https://ibc.nois.network/connections/connection-2/channels/wasm.nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp:channel-11
[channel-16]:
  https://ibc.nois.network/connections/connection-4/channels/transfer:channel-16
[channel-17]:
  https://ibc.nois.network/connections/connection-6/channels/transfer:channel-17
[channel-20]:
  https://ibc.nois.network/connections/connection-6/channels/wasm.nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp:channel-20
[channel-21]:
  https://ibc.nois.network/connections/connection-9/channels/transfer:channel-21
[channel-22]:
  https://ibc.nois.network/connections/connection-9/channels/wasm.nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp:channel-22
[channel-35]:
  https://ibc.nois.network/connections/connection-4/channels/wasm.nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp:channel-35
[channel-37]:
  https://ibc.nois.network/connections/connection-10/channels/transfer:channel-37
[channel-38]:
  https://ibc.nois.network/connections/connection-0/channels/wasm.nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp:channel-38
[channel-41]:
  https://ibc.nois.network/connections/connection-10/channels/wasm.nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp:channel-41
[channel-43]:
  https://ibc.nois.network/connections/connection-11/channels/transfer:channel-43
[channel-44]:
  https://ibc.nois.network/connections/connection-11/channels/wasm.nois1acyc05v6fgcdgj88nmz2t40aex9nlnptqpwp5hf8hwg7rhce9uuqgqz5wp:channel-44

## IBC denoms

On Nois:

- ustars: `ibc/49BAE4CD2172833F14000627DA87ED8024AD46A38D6ED33F6239F22B5832F958`
- ujuno: `ibc/EFF323CC632EC4F747C61BCE238A758EFDB7699C3226565F7C20DA06509D59A5`
- aarch: `ibc/3A8BF65AFC8F1AC2998A80C5D78C355D058C8C755882E85A9BEC75D4E9F09739`

unois on:

- Stargaze (stargaze-1):
  `ibc/0F181D9F5BB18A8496153C1666E934169515592C135E8E9FCCC355889858EAF9`
- Juno (juno-1):
  `ibc/1D9E14A1F00613ED39E4B8A8763A20C9BE5B5EA0198F2FE47EAE43CD91A0137B`
- Injective (injective-1)
  `ibc/DD9182E8E2B13C89D6B4707C7B43E8DB6193F9FF486AFA0E6CF86B427B0D231A`
- Aura
  `ibc/1FD48481DAA1B05575FE6D3E35929264437B8424A73243B207BCB67401C7F1FD`
- Osmosis
  `ibc/6928AFA9EA721938FED13B051F9DBF1272B16393D20C49EA5E4901BB76D94A90`
