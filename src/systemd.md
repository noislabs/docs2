# Using systemd

You can run noisd as a service for systemd.

## Creading the service file

The following script creates the service file nois.service for systemd. The file
was originally provided by Kolot, thank you!.

```sh
sudo tee /etc/systemd/system/nois.service > /dev/null <<EOF
[Unit]
Description=Nois blockchain
After=network-online.target

[Service]
User=$USER
ExecStart=$(which noisd) start --home $HOME/.noisd
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

## Using the nois service

```sh
# Find the new service file
sudo systemctl daemon-reload

# Check status (should be loaded, inactive and disabled)
sudo systemctl status nois

# Enable (i.e. start automatically)
sudo systemctl enable nois

# Start/Restart
sudo systemctl restart nois

# Watch logs
sudo journalctl -u nois -f -o cat
```
