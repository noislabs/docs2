## Add Randomness to your Chain

In order to be able to integrate Nois wihtin your blockchain you need to deploy
a nois-proxy which plays the role of an outpost contract. Good news, Nois can be
integrated with any IBC enabled chain and the process is fully permissionless.
The nois-proxy's role when deployed to your chain is to abstract the IBC
complexity out of the randomness consumer DAPP.

#### Steps to integrate Nois to your chain

##### Connect your chain to Nois

By the end of this step you should have an IBC transfer channel between your Chain and Nois, so that you can pay for randomness with NOIS.

- Configure your relayer software (hermes, go-relayer, ts-relayer) to have Nois and your chain (Check the chain-registry for the details)
- Create a Client, a connection, and a transfer channel between both chains. You can check that the channels have been created for Nois mainnet here https://ibc.nois.network/ or for testnet here https://testnet.ibc.nois.network/
- Start the relayer and IBC transfer 1 NOIS from Nois chain to your chain and check the balance (on destination account) in order to get the IBCed NOIS denom. write down the IBC denom as you will need this for a later step.


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

instantiation paramaters description:
| Parameter          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | Type      |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| manager            | You can put your address here. It will allow you to set the proxy parameters, and withdraw any funds held by the proxy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | String    |
| prices             | These are the prices that any Dapp needs to pay the proxy.<br>You can set this in IBCed $NOIS or in any native Coin.<br>You can even leave this to 0 if you want to allow Dapps to request randomness for free.<br>Please note that these are not necessarily the funds that will be sent over to Nois but only the proxy fee.                                                                                                                                                                                                                                                                                            | Vec<Coin> |
| withdrawal_address | This is the address to which the proxy funds are sent whenever the manager requests a withdrawal.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | String    |
| test_mode          | Just set this to false.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Boolean   |
| callback_gas_limit | The amount of gas that the callback to the dapp can consume. 500000 is a good value if you are not sure.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | number    |
| mode               | This defines the operational mode of the proxy:<br>two modes are available:<br>- Funded: In this mode. The is no need to make sure that the proxy is sending the NOIS to pay for randomness because someone already filled the payment contract (on Nois chain) of the proxy on behalf of the proxy.<br>  This can happen onchain or offchain, automated or manually.<br>- IbcPay: In this mode the proxy contract sends IBCed NOIS to the gateway for each beacon request. Whether you need to prefill this contract with NOIS or make sure you add that fee on the prices so that DAPPs will send the fee upon request. |           |

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
