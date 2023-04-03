# Checking CORS

Enabling CORS is important to allow browser-based apps to access the APIs the
same way as non-browser based apps.

## Check CORS with curl

The origin `https://randomness.nois.network/` serves as an example app using the
endpoint here.

```sh
export ENDPOINT="https://rpc-nois.d-stake.xyz:443"

# Regular CORS request
curl -sS -I -H "Origin: https://randomness.nois.network/" \
  "$ENDPOINT/status" | grep -i "access-control-"

# Should return status 200 and include the response header:
# - Access-Control-Allow-Origin

# Preflight request
curl -sS -I -H "Origin: https://randomness.nois.network/" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: X-Requested-With" \
  -X OPTIONS \
  "$ENDPOINT/status" | grep -i "access-control-"

# Should return status 200 and include the response headers:
# - Access-Control-Allow-Origin
# - Access-Control-Allow-Methods
# - Access-Control-Allow-Headers


```
