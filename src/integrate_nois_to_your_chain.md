## Add Randomness to your Chain

In order to be able to integrate Nois wihtin your blockchain you need to deploy
a nois-proxy which plays the role of an outpost contract. Good news, Nois can be
integrated with any IBC enabled chain and the process is fully permissionless.
The nois-proxy's role when deployed to your chain is to abstract the IBC
complexity out of the randomness consumer DAPP.

#### Steps to integrate Nois to your chain

##### Install the binary of your chain

For this step you can

##### Navigate to the contract releases link

navigate to this [link](https://github.com/noislabs/nois-contracts/releases) and
you should find a list of releases. scroll to the latest version and expand the
list of artifacts then click to download **nois_proxy.wasm**

##### Store the nois-proxy contract code

```shell

```

##### instantiate the nois-proxy contract code

```shell

```

##### Setup the IBC channel

```shell

```
