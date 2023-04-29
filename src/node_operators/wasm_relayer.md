# IBC wasm relayer

> In this tutorial we are using the ts-relayer by confio as a relayer software.
> However, feel free to use other relayer software like Hermes and if you want
> to contribute to the docs by providing the steps for setting up such different
> software let us know on discord

---

Setting up ts-relayer

Install docker from this [link](https://docs.docker.com/engine/install/ubuntu/)

#### Example uni-6 => nois-testnet-005 relay

```shell
export MNEMONIC='<YOUR_MNEMONICS_HERE>'
export CHAIN_ID=uni-6

#Check #deployment discord channel for this value
export NOIS_PROXY=<NOIS_PROXY_ADDR_ON_CONSUMER_CHAIN>
#example:
#export NOIS_PROXY=juno162vdumcg626zxumvuh9u6vxcakr3rrn804dxfex8qfxnhrldl68ss0lrdn

docker run -d -e "MNEMONIC=$MNEMONIC" \
            noislabs/nois-relayer:$CHAIN_ID-$NOIS_PROXY-prd
```
