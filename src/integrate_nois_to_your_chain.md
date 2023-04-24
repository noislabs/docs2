## Add Randomness to your Chain

In order to be able to integrate Nois within your blockchain you need to deploy
a nois-proxy which plays the role of an outpost contract. Good news, Nois can be
integrated with any IBC enabled chain and the process is fully permissionless.
The nois-proxy's role when deployed to your chain is to abstract the IBC
complexity out of the randomness consumer DAPP.

#### Steps to integrate Nois to your chain

#### Decide on a nois-proxy strategy
The nois-proxy that you will deploy belongs to you and not to the Nois chain.
Your nois-proxy will have a nois-payment contract at the Nois chain so it can pay for randomness.
You need to decide how much dapps need to pay your proxy in prder for the proxy to forward the request to Nois.
You can set this price in IBCed NOIS or you can even set the native token of your chain, or even Bitcoin or you can set it for free.
Just remember that if you set the price too low some people/dapps can request the randomness from your proxy for a cheap price and end up consuming you $NOIS tokens at the other side (from you nois-payment contract on Nois chain)
You are the manager of your proxy so you can at any point in time withdraw  part or all the funds that your proxy has accumulated.
You can make your proxy part of governance and withdraw the funds to the community pool if you wish.

##### Connect your chain to Nois

By the end of this step you should have an IBC transfer channel between your
Chain and Nois, so that you can pay for randomness with NOIS.

- Configure your relayer software (hermes, go-relayer, ts-relayer) to have Nois
  and your chain (Check the [chain-registry](https://github.com/cosmos/chain-registry/tree/master/nois) for the details)
- Create a Client, a connection, and a transfer channel between both chains.
- Check that the channel has been created. You can do so in this IBC
  [mainnet dashboard](https://ibc.nois.network/connections) or
  [testnet dashboard](https://testnet.ibc.nois.network/)
- Start the relayer and IBC transfer 1 NOIS from Nois chain to your chain and
  check the balance (on destination account) in order to get the IBCed NOIS
  denom. write down the IBC denom as you will need this for a later step.

##### Install the binary of your chain

For this step you can check the docs for your IBC chain. and atthe end of this
step you should be able to run the chain binary. Example:

```sh
junod version
```

##### Navigate to the Nois contract releases link

navigate to this [link](https://github.com/noislabs/nois-contracts/releases) and
you should find a list of releases. scroll to the latest version and expand the
list of artifacts/assets then click and download **nois_proxy.wasm**

##### Store the nois-proxy contract code

```sh
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

| Parameter          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Type       |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------- |
| manager            | You can put your address here. <br>It will allow you to set the proxy parameters, and withdraw any funds held by the proxy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | String     |
| prices             | These are the prices that any Dapp needs to pay the proxy.<br>You can set this in IBCed $NOIS or in any native Coin.<br>You can even leave this to 0 if you want to allow Dapps to request randomness for free.<br>Please note that these are not necessarily the funds that will be sent over to Nois but only the proxy fee.                                                                                                                                                                                                                                                                                                             | Vec\<Coin> |
| withdrawal_address | This is the address to which the proxy funds are sent whenever the manager requests a withdrawal                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | String     |
| test_mode          | Just set this to false.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Boolean    |
| callback_gas_limit | The amount of gas that the callback to the dapp can consume. <br>500000 is a good value if you are not sure.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | number     |
| mode               | This defines the operational mode of the proxy:<br>two modes are available: <br> - **Funded**: In this mode There is no need to make sure that the proxy is sending the NOIS to pay for randomness because someone already filled the payment contract (on Nois chain) of the proxy on behalf of the proxy. This can happen onchain or offchain, automated or manually.<br> - **IbcPay**: In this mode the proxy contract sends IBCed NOIS to the gateway for each beacon request. You need to whether prefill this contract with NOIS or make sure you set the Nois fee on the prices field so that DAPPs will send the fee upon request. | Enum       |

```sh
junod tx wasm instantiate <CODE_ID>
  '{"manager":YOUR_ADDRESS_HERE,
  "prices":
         [
             {"denom":"ujunox","amount":"1000000"},
             {"denom":"ibc/..ibc_NOIS_you_noted_in_a_previous_step","amount":"50000000"}
         ],
  "withdrawal_address":"YOUR_ADDRESS_HERE",
  "callback_gas_limit":500000,
  "test_mode":false,
  "mode":{"ibc_pay":{
         "unois_denom":{
               "ics20_channel":"channel-xx",
               "denom":"ibc/..ibc_NOIS_you_noted_in_a_previous_step"
               }
 }}}'
--label=nois-proxy
--no-admin
--from <your-key>
--chain-id uni-6
--gas=auto
--gas-adjustment 1.4
--gas-prices 0.025ujunox
--broadcast-mode=block
--node=https://rpc.uni.juno.deuslabs.fi:443 -y
```

##### Setup the IBC channel for the wasm relay - Transferring the randomness beacon not the tokens

- choose your relayer software (ts-relayer or hermes or go-relayer).
- You can create a new IBC client and connection or skip if you want to use the
  existing connection (the one that has been created for the token transfer).
- Create an IBC channel where the source is the nois-proxy you have just
  instantiated on your chain and the destination is the nois-gateway on the Nois
  chain (the direction is important). When creating the channel Make sure to use
  the wasm port.
  > ℹ️ If the nois-gateway address is
  > nois1x55xhexprdwfl6nfju53hfxj77nsxlj5c9jzyvjuastl9f3dt6jsx6l9yg then the
  > port will be
  > **wasm**.nois1x55xhexprdwfl6nfju53hfxj77nsxlj5c9jzyvjuastl9f3dt6jsx6l9yg
- Upon channel connection/creation the nois-gateway factory creates a payment
  contract for your proxy on the Nois chain. This payment contract will be your
  balance sheet. So long as the payment contract has enough balance your proxy
  will be able to request randomness beacon. So make sure the payment contract
  does not run out of $NOIS.
- Check that the channel has been created. You can do so in this IBC
  [mainnet dashboard](https://ibc.nois.network/connections) or
  [testnet dashboard](https://testnet.ibc.nois.network/)
- Run the relayer and ask others to run their relayers aswell.
- Congrats 🎉 you can use the proxy on your Dapp to get randomness. You can
  follow _use_nois_randomness_ page for more details.
