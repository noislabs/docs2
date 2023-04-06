## Add Randomness to your Chain

In order to be able to integrate Nois wihtin your blockchain you need to deploy
a nois-proxy which plays the role of an outpost contract. Good news, Nois can be
integrated with any IBC enabled chain and the process is fully permissionless.
The nois-proxy's role when deployed to your chain is to abstract the IBC
complexity out of the randomness consumer DAPP.

#### Steps to integrate Nois to your chain

##### Install the binary of your chain

For this step you can check the docs for your IBC chain. and atthe end of this
step you should be able to run the chain binary. Example:

```shell
junod version
```

##### Navigate to the Nois contract releases link

navigate to this [link](https://github.com/noislabs/nois-contracts/releases) and
you should find a list of releases. scroll to the latest version and expand the
list of artifacts/assets then click and download **nois_proxy.wasm**

##### Store the nois-proxy contract code

```shell
junod tx wasm store \
       nois_proxy.wasm* \
       --from <your-key> \
       --chain-id uni-6 \
       --gas=auto \
       --gas-adjustment 1.4  \
       --gas-prices 0.025ujunox \
       --broadcast-mode=block \
       --node=https://rpc.uni.juno.deuslabs.fi:443 -y
```

##### instantiate the nois-proxy contract code

```shell
junod tx wasm instantiate <CODE_ID> \
       '{"prices":[{"denom":"ujunox","amount":"1000000"}],"withdrawal_address":"juno1decjtp0szudj4flvfa57wvkqenkeuk5pt28j7t","callback_gas_limit":500000,"test_mode":false}' \
       --label=nois-proxy \
       --no-admin \
       --from <your-key> \
       --chain-id uni-6 \
       --gas=auto \
       --gas-adjustment 1.4 \
       --gas-prices 0.025ujunox \
       --broadcast-mode=block \
       --node=https://rpc.uni.juno.deuslabs.fi:443 -y
```

##### Setup the IBC channel

- choose your relayer software (ts-relayer or hermes or go-relayer).
- get some NOIS tokens and your chain's native tokens.
- create an IBC client and connection.
- Create an IBC channel where the source is the nois-proxy on your chain and the
  destination is the nois-gateway on the Nois chain (the direction is
  important). When creating the channel Make sure to use the wasm port.
  > ℹ️ If the nois-gateway address is
  > nois1x55xhexprdwfl6nfju53hfxj77nsxlj5c9jzyvjuastl9f3dt6jsx6l9yg then the
  > port will be
  > **wasm**.nois1x55xhexprdwfl6nfju53hfxj77nsxlj5c9jzyvjuastl9f3dt6jsx6l9yg
- Upon channel connection/creation the nois-gateway factory creates a payment
  contract for your proxy on the Nois chain. This payment contract will be your
  balance sheet. So long as the payment contract has enough balance your proxy
  will be able to request randomness beacon. So make sure the payment contract
  is well fed with $NOIS
- Check that the channel has been created. You can do so in this IBC
  [mainnet dashboard](https://ibc.nois.network/connections) or
  [testnet dashboard](https://testnet.ibc.nois.network/)
- Run the relayer and ask others to run their relayers aswell.
- Congrats 🎉 you can use the proxy on your Dapp to get randomness. You can
  follow _use_nois_randomness_ page for more details.
