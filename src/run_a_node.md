# For Node Operators

Here you find information how to run a full node as well as produce blocks. If
you want to run a sentry, most of the instructions are the same.

## Run a full node

We assume you are on some sort of Ubuntu/Debian Linux. Other Linux distributions
and macOS works very similar.

### 1. Update your OS and install dependencies

```sh
sudo apt update
# Maybe also this if you want: sudo apt upgrade -y && reboot
sudo apt install -y make gcc build-essential git jq joe
```

### 2. Install Go

This way: [https://go.dev/doc/install](https://go.dev/doc/install). Both Go 1.20
and 1.19 are supported.

### 3. Clone the noisd repository

```sh
git clone https://github.com/noislabs/noisd.git
cd noisd
git checkout <SOME TAG>
```

The tag to be checked out is available in the [Networks section](./networks.md).

### 4. Build and install the noisd binary

```sh
make install

# Add GOPATH to PATH
export PATH="$PATH:$(go env GOPATH)/bin"
# in zsh: rehash
```

Check the installation:

```sh
noisd version
# Shows version you checked out above
```

### 5. Init (creates folder $HOME/.noisd)

Create initial configuration files. The given argument is the moniker (a
nickname for the node).

```sh
noisd init "random node"
```

### 6. Adapt config

```sh
# Update p2p setting (config.toml)
export MY_EXTERNAL_ADDR="$(curl -sS https://api.ipify.org):26656" # or set explicitely if this API does not return the correct value
sed -i 's/external_address =.*$/external_address = "'$MY_EXTERNAL_ADDR'"/' $HOME/.noisd/config/config.toml
```

### 7. Download the genesis file

See [Networks](./networks.md) for the correct URL.

```sh
wget -O "$HOME/.noisd/config/genesis.json" <GENESIS URL>
```

### 8. Draw the rest of the fucking owl

The rest is similar to running a standard Cosmos node or validator. You can
check the
[Cosmos Hub docs](https://hub.cosmos.network/main/validators/validator-setup.html)
for more details. For the faucet, rpc links, permanent peers and similar details
visit.
