## How it works

The following steps are taken to get the randomness:

- A Contract on a CosmWasm and IBC-enabled chain (such as Juno or Stargaze) sends a message to a Nois proxy contract on the same chain. A reply with further information regarding the job is sent to the original contract.
- The proxy contract sends an IBC message to its couter-part on the Nois Network where the job is put in the queue.
- Once the drand beacon of the correct round is released, a network of bots sends it to the Nois Network for verification.
- Upon successful verfication, the pending jobs for the round are processed. For every matching job, an IBC response with the beacon is sent.
- The proxy contract receives the beacon and sends a callback to the original contract.
