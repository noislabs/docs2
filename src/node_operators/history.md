# History settings

There are a few things you might want to set in yout node. Different settings
are required for different use cases, so don't consider them recommendations.

## Relayer-friendly node

Keep state snapshots of the last 24 hours:

```sh
sed -i 's/pruning =.*$/pruning = "custom"/' $HOME/.noisd/config/app.toml \
  && sed -i 's/pruning-keep-recent =.*$/pruning-keep-recent = "34560"/' $HOME/.noisd/config/app.toml \
  && sed -i 's/pruning-keep-every =.*$/pruning-keep-every = "0"/' $HOME/.noisd/config/app.toml \
  && sed -i 's/pruning-interval =.*$/pruning-interval = "100"/' $HOME/.noisd/config/app.toml
```

## Don't store old state

In order to avoid storing snapshots of the state, in
`$HOME/.noisd/config/app.toml` you can set `pruning = "everything"`:

```sh
sed -i 's/pruning =.*$/pruning = "everything"/' $HOME/.noisd/config/app.toml
```
