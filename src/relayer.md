# IBC relayer

> Relayers transfer packets from a chain to another via IBC. They will ship the
> randomness and tokens between Nois chain and the consumer chains

---

At Nois we have two kind of relaying:

- ICS20 relaying: This is for token transfer between chains. (Relayers don't recevice incentives here yet)
- wasm relaying: This is where the randomness beacon gets requested and sent to
  consumer chains. Relayers will get incentives by relaying this traffic.

You can check the current IBC clients, connections and channels on
[mainnet dashboard](https://ibc.nois.network/connections) or on the
[testnet dashboard](https://testnet.ibc.nois.network/)
