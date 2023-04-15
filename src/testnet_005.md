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
- Tag: v1.0.1
- `noisd version` should show 1.0.1

## p2p

Seed nodes

- `bf07906c7cf0f23606c83be15624be2c67b3929c@139.59.154.47:17356`
- `da81dd66bca4bba509163dbd06b4a6b2e05c2e12@nois-testnet-seed.itrocket.net:21656`

## RPCs

An incomplete and unchecked list of community provided TendermintRPC endpoints:

| URL                                       | TLS | CORS | tx_index |
| ----------------------------------------- | --- | ---- | -------- |
| https://nois-testnet-rpc.polkachu.com:443 | ✅  | ✅   | ✅       |
| https://nois-testnet.rpc.kjnodes.com:443  | ✅  | ?    | ?        |
| https://rpc.nois.mcbnode.online:443       | ✅  | ?    | ?        |
| http://185.198.27.109:26657               | No  | ?    | ?        |
| https://nois-testnet-rpc.itrocket.net:443 | ✅  | ✅   | ✅       |

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
  Address: nois1c9l6qcl82u7zkgjduj2snfuv5rz6jzwsumw4nktgytzclazujc6qc05p5j
  Code ID: "44"
  Git Asset Name: nois_gateway
  Instantiation Message:  '{"manager":"nois1tfg9ptr84t9zshxxf5lkvrd6ej7gxjh75lztve","price":{"denom":"unois","amount":"50000000"},"payment_code_id":45,"sink":"nois10c0ppz0n57hqrmfp7g7lqs6k4xk9rxhvcfkqt83r8mars2lc57mq0f6cty"}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.12.0
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

### Proxies

#### nois-sink

```yaml
- Chain-id: uni-6
  Address: juno17ux7ttvateffn206mp470ue8tajlxmwu3qqghp9kd8zmsgle7szsfrsu4f
  Git Asset Name: nois_proxy
  Instantiation Message: '{"prices":[{"denom":"ujunox","amount":"100"}],"withdrawal_address":"juno1q6yvx8lxpheqflkcl0qf89czej4akrsfzc6xs2","callback_gas_limit":500000,"test_mode":false,"mode":{"ibc_pay":{"unois_denom":{"ics20_channel":"channel-175","denom":"ibc/1D9E14A1F00613ED39E4B8A8763A20C9BE5B5EA0198F2FE47EAE43CD91A0137B"}}}}'
  URL: "https://github.com/noislabs/nois-contracts"
  Version: v0.12.0
```
