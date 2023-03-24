# History settings

There are a few things you might want to set in yout node.
Different settings are required for different use cases, so don't consider them recommendations.

## 1. Don't store old state

In order to avoid storing snapshots of the state,
in `$HOME/.noisd/config/app.toml` you can set `pruning = "default"`:

```sh
sed -i 's/pruning =.*$/pruning = "everything"/' $HOME/.noisd/config/app.toml
```
