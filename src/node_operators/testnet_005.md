# Testnet 005

## Basic info

- Chain ID: `nois-testnet-005`
- Demon: `unois`

## Genesis

- URL:
  <https://raw.githubusercontent.com/noislabs/networks/nois-testnet-005/nois-testnet-005/genesis.json>
- Checksum (sha256):
  `1647cabd044110d6beda2fc4a32fb50dfbb5babff74bdf41503c58123ded3389`

## Binary

- Build `noisd` from <https://github.com/noislabs/noisd>
- Tag: v1.0.2
- `noisd version` should show 1.0.2

## p2p

Seed nodes

- `bf07906c7cf0f23606c83be15624be2c67b3929c@139.59.154.47:17356`
- `da81dd66bca4bba509163dbd06b4a6b2e05c2e12@nois-testnet-seed.itrocket.net:21656`
- `ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:17356`
- `6b2af739ac032a96e1e568b1871a1ca6e80ab08e@185.196.21.43:22656`
- `3f472746f46493309650e5a033076689996c8881@nois-testnet.rpc.kjnodes.com:15159`

## RPCs

An incomplete and unchecked list of community provided TendermintRPC endpoints:

| URL                                       | TLS | CORS | tx_index |
| ----------------------------------------- | --- | ---- | -------- |
| https://nois-testnet-rpc.polkachu.com:443 | ✅  | ✅   | ✅       |
| https://nois-testnet.rpc.kjnodes.com:443  | ✅  | ?    | ?        |
| https://rpc.nois.mcbnode.online:443       | ✅  | ✅   | ✅       |
| http://185.198.27.109:26657               | No  | ?    | ?        |
| https://nois-testnet-rpc.itrocket.net:443 | ✅  | ✅   | ✅       |

---

## Contracts

#### nois-drand

```yaml
- Name: nois-drand
  Address: nois14xef285hz5cx5q9hh32p9nztu3cct4g44sxjgx3dmftt2tj2rweqkjextk
  Code ID: "1"
  Git Asset Name: nois_drand
  Instantiation Message: '{"incentive_point_price":"3000","incentive_denom":"unois","min_round":,"manager":"nois1tfg9ptr84t9zshxxf5lkvrd6ej7gxjh75lztve"}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.11.0
  Config:
    gateway: nois1c9l6qcl82u7zkgjduj2snfuv5rz6jzwsumw4nktgytzclazujc6qc05p5j
    incentive_denom: unois
    incentive_point_price: "3000"
    manager: nois1tfg9ptr84t9zshxxf5lkvrd6ej7gxjh75lztve
    min_round: 833618
```

#### nois-icecube

```yaml
- Name: nois-icecube
  Address: nois1gwnfyx82rwgc4y9r8vx6nr9v35dwezw3dadw6h39mad9amg7shnsler5f0
  Code ID: "6"
  Git Asset Name: nois_icecube
  Instantiation Message: '{"manager":"nois1tfg9ptr84t9zshxxf5lkvrd6ej7gxjh75lztve"}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.11.0
```

#### nois-gateway

```yaml
- Name: nois-gateway
  Address: nois1xwde9rzqk5u36fke0r9ddmtwvh43n4fv53c5vc462wz8xlnqjhls6d90xc
  Code ID: "59"
  Git Asset Name: nois_gateway
  Instantiation Message: '{"manager":"nois1tfg9ptr84t9zshxxf5lkvrd6ej7gxjh75lztve","price":{"denom":"unois","amount":"50000000"},"payment_code_id":57,"sink":"nois10c0ppz0n57hqrmfp7g7lqs6k4xk9rxhvcfkqt83r8mars2lc57mq0f6cty"}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.13.8
  Config:
    drand: nois14xef285hz5cx5q9hh32p9nztu3cct4g44sxjgx3dmftt2tj2rweqkjextk
    manager: nois1tfg9ptr84t9zshxxf5lkvrd6ej7gxjh75lztve
    payment_code_id: 58
    payment_initial_funds: "2000000unois"
    price:
      amount: "1000000unois"
      denom: unois
    sink: nois10c0ppz0n57hqrmfp7g7lqs6k4xk9rxhvcfkqt83r8mars2lc57mq0f6cty
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

---

### Proxies

#### uni-6

```yaml
- Chain-id: uni-6
  Address: juno1pjpntyvkxeuxd709jlupuea3xzxlzsfq574kqefv77fr2kcg4mcqvwqedq
  Git Asset Name: nois_proxy
  Instantiation Message: '{"prices":[{"denom":"ujunox","amount":"100"}],"manager":"juno1q6yvx8lxpheqflkcl0qf89czej4akrsfzc6xs2","callback_gas_limit":500000,"test_mode":false,"mode":{"ibc_pay":{"unois_denom":{"ics20_channel":"channel-175","denom":"ibc/717352A5277F3DE916E8FD6B87F4CA6A51F2FBA9CF04ABCFF2DF7202F8A8BC50"}}}}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.13.5
  Config:
    callback_gas_limit: 500000
    manager: juno1q6yvx8lxpheqflkcl0qf89czej4akrsfzc6xs2
    mode:
      ibc_pay:
        unois_denom:
          denom: ibc/717352A5277F3DE916E8FD6B87F4CA6A51F2FBA9CF04ABCFF2DF7202F8A8BC50
          ics20_channel: channel-175
    nois_beacon_price: "50000000"
    nois_beacon_price_updated: "1682353695404898784"
    payment: nois1xgnpkzr86cl7d2mjwdhalyt9md3vyfk5d66r9j4lfvsgkjc6wthse2q53d
    prices:
      - amount: "100"
        denom: ujunox
    test_mode: false
```

#### injective-888

```yaml
- Chain-id: injective-888
  Address: inj14nendtsz0c40n7xtzwkjmdc8dkuz835jdydxhn
  Git Asset Name: nois_proxy
  Instantiation Message: '{"prices":[{"denom":"inj","amount":"100"},{"denom":"ibc/B0D9A85855FFB4C6472AD514B48C91275453B2AFC501472EE29895C400463E6B","amount":"1000000"}],"manager":"inj1decjtp0szudj4flvfa57wvkqenkeuk5pt28j7t","callback_gas_limit":10000,"test_mode":false,"mode":{"ibc_pay":{"unois_denom":{"ics20_channel":"channel-46","denom":"ibc/B0D9A85855FFB4C6472AD514B48C91275453B2AFC501472EE29895C400463E6B"}}}}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.13.0
  config:
    allowlist_enabled: false
    callback_gas_limit: 500000
    manager: inj1decjtp0szudj4flvfa57wvkqenkeuk5pt28j7t
    max_after: "2003505450748953972"
    min_after: "1688145450748953972"
    mode:
      ibc_pay:
        unois_denom:
          denom: ibc/A190CF3FC762D25A46A49E7CB0E998F4A494C7F64A356DA17C25A2D8B0069D3B
          ics20_channel: channel-46
    nois_beacon_price: "1000000"
    nois_beacon_price_updated: "1688145748393860168"
    payment: nois1umkkrl2c7wfyjtlvy4vun7rrq25v0vx3kmfmyc9x0763z049sr4se2pd4s
    prices:
    - amount: "100"
      denom: inj
    - amount: "1000000"
      denom: ibc/A190CF3FC762D25A46A49E7CB0E998F4A494C7F64A356DA17C25A2D8B0069D3B
    test_mode: false
```

## IBC channels

Right now the following IBC channels are supported:

| Protocol | Other chain               | Channel (nois-testnet-005) | Channel (other chain)    | Description         |
| -------- | ------------------------- | -------------------------- | ------------------------ | ------------------- |
| ICS-20   | Injective (injective-888) | [channel-33]               | channel-74               | inj-nois transfer   |
| ICS-20   | Juno (uni-6)              | [channel-3]                | channel-175              | junox-nois transfer |
| ICS-20   | Neutron (pion-1)          | [channel-40]               | channel-133              | ntrn-nois transfer  |
| ICS-20   | Stargaze (elgafar-1)      | [channel-48]               | channel-485              | stars-nois transfer |
| nois-v7  | Juno (uni-6)              | [channel-17]               | channel-198              | Public proxy        |
| nois-v7  | Injective (injective-888) | [channel-36]               | channel-77               | Public proxy        |
| nois-v7  | Neutron (pion-1)          | [channel-42]               | channel-135              | Public proxy        |
| nois-v7  | Stargaze (elgafar-1)      | [channel-49]               | channel-486              | Public proxy        |

[channel-33]:
  https://testnet.ibc.nois.network/connections/connection-13/channels/transfer:channel-33
[channel-40]:
  https://testnet.ibc.nois.network/connections/connection-17/channels/transfer:channel-40
[channel-3]:
  https://testnet.ibc.nois.network/connections/connection-4/channels/transfer:channel-3
[channel-17]:
  https://testnet.ibc.nois.network/connections/connection-5/channels/wasm.nois1xwde9rzqk5u36fke0r9ddmtwvh43n4fv53c5vc462wz8xlnqjhls6d90xc:channel-17
[channel-36]:
  https://testnet.ibc.nois.network/connections/connection-13/channels/wasm.nois1xwde9rzqk5u36fke0r9ddmtwvh43n4fv53c5vc462wz8xlnqjhls6d90xc:channel-36
[channel-42]:
  https://testnet.ibc.nois.network/connections/connection-17/channels/wasm.nois1xwde9rzqk5u36fke0r9ddmtwvh43n4fv53c5vc462wz8xlnqjhls6d90xc:channel-42
[channel-48]:
https://testnet.ibc.nois.network/connections/connection-23/channels/transfer:channel-48
[channel-49]:
https://testnet.ibc.nois.network/connections/connection-23/channels/wasm.nois1xwde9rzqk5u36fke0r9ddmtwvh43n4fv53c5vc462wz8xlnqjhls6d90xc:channel-49

---

## IBC denoms

On Nois:

unois on:

```yaml
- chain-id: uni-6
  denom: ibc/717352A5277F3DE916E8FD6B87F4CA6A51F2FBA9CF04ABCFF2DF7202F8A8BC50
  channel-id: channel-175
- chain-id: euphoria-2
  denom: ibc/70D9353E4D43D860BF051ECE427C427687EDED77E61EFEF2CFF2839D28E6AE43
  channel-id: [channel-61](https://testnet.ibc.nois.network/connections/connection-2/channels/transfer:channel-8)
- chain-id: injective-888
  denom: ibc/A190CF3FC762D25A46A49E7CB0E998F4A494C7F64A356DA17C25A2D8B0069D3B
  channel-id: [channel-74](https://testnet.ibc.nois.network/connections/connection-13/channels/transfer:channel-33)
- chain-id: pion-1
  denom: ibc/26139E488F510BDA8DDE5614D358A38502BDA061954B8D10ADEFC4EAA58552FF
- chain-id: elgafar-1
  denom: ibc/ACCAF790E082E772691A20B0208FB972AD3A01C2DE0D7E8C479CCABF6C9F39B1
```
