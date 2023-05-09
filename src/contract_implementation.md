# Contract implementation

Double dice game example:

[https://github.com/noislabs/nois-dapp-examples](https://github.com/noislabs/nois-dapp-examples)

---

#### Import the nois packages

First thing is to import the packages. Add this to your Cargo.toml under
dependencies.

```rust
// in cargo.toml
[dependencies]
nois = "0.7.0"
```

Note that Rust editions prior to "2021" may require the addition of the 
following option to the `package` section of your Cargo.toml for a 
successful build:

```rust
[package]
resolver = "2"
```

#### Configure the proxy address

We need to add the address of the nois-proxy. One common way to do it is during
the instantiation of the contract.

```rust
// in state.rs
pub const NOIS_PROXY: Item<Addr> = Item::new("nois_proxy");
```

import the **nois-proxy**.

```rust
// in contract.rs
use crate::state::{NOIS_PROXY};
```

Still in the contract.rs add the instantiation msg which validates the
nois-proxy address and stores it

```rust
// in contract.rs
pub fn instantiate(
    deps: DepsMut,
    _env: Env,
    info: MessageInfo,
    msg: InstantiateMsg,
) -> Result<Response, ContractError> {
    // The nois-proxy abstracts the IBC and nois chain away from this application
    let nois_proxy_addr = deps
        .api
        .addr_validate(&msg.nois_proxy)
        .map_err(|_| ContractError::InvalidProxyAddress)?;
    set_contract_version(deps.storage, CONTRACT_NAME, CONTRACT_VERSION)?;
    NOIS_PROXY.save(deps.storage, &nois_proxy_addr)?;
​
    Ok(Response::new()
        .add_attribute("method", "instantiate")
        .add_attribute("owner", info.sender))
}
```

Declare the instantiation msg

```rust
// in msg.rs
pub struct InstantiateMsg {
   pub nois_proxy: String,
}
```

Add the InvalidProxyError in error.rs

```rust
// in errors.rs
#[error("Proxy address is not valid")]
InvalidProxyAddress,T
```

#### Triggering the randomness request

In order to request the randomness we need a function whether internal or
publicly called. For this tutorial we can make a roll dice msg that will in turn
call the getNextRandomness(id) handler. So the RollDice message gets the id as a
parameter

```rust
// in contract.rs
match msg {
        //RollDice should be called by a player who wants to roll the dice
        ExecuteMsg::RollDice { job_id } => execute_roll_dice(deps, env, info, job_id),
    }
```

```rust
// in msg.rs
pub enum ExecuteMsg {
   RollDice {
       /// An ID for this job which allows for gathering the results.
       job_id: String,
   },
}
```

Call the GetNextRandomness(id) from the triggering function

```rust
//execute_roll_dice is the function that will trigger the process of requesting randomness.
//The request from randomness happens by calling the nois-proxy contract
pub fn execute_roll_dice(
    deps: DepsMut,
    _env: Env,
    _info: MessageInfo,
    job_id: String,
) -> Result<Response, ContractError> {
    let nois_proxy = NOIS_PROXY.load(deps.storage)?;

    let response = Response::new().add_message(WasmMsg::Execute {
        contract_addr: nois_proxy.into(),
        //GetNextRandomness requests the randomness from the proxy
        //The job id is needed to know what randomness we are referring to upon reception in the callback
        //In this example, the job_id represents one round of dice rolling.
        msg: to_binary(&ProxyExecuteMsg::GetNextRandomness { job_id })?,
        //In this example the randomness is sent from the gambler, but you may also send the funds from the contract balance
        funds: info.funds, // Just pass on all funds we got
    });
    Ok(response)
}
```

#### Receiving the randomness

The nois-proxy contract sends the callback on the NoisReceive entrypoint.
Therefore, you should add the Receive handler on your ExecuteMsg.

```rust
// in contract.rs
// Adding ExecuteMsg::NoisReceive
 match msg {
        //RollDice should be called by a player who wants to roll the dice
        ExecuteMsg::RollDice { job_id } => execute_roll_dice(deps, env, info, job_id),
        //NoisReceive should be called by the proxy contract. The proxy is forwarding the randomness from the nois chain to this contract.
        ExecuteMsg::NoisReceive { callback } => execute_receive(deps, env, info, callback),
    }
```

and in msg.rs

```rust
// in msg.rs
use nois::NoisCallback;

#[derive(Serialize, Deserialize, Clone, Debug, JsonSchema)]
#[serde(rename_all = "snake_case")]
pub enum ExecuteMsg {
    // job_id for this job which allows for gathering the results.
    RollDice { job_id: String },
    //callback contains the randomness from drand (HexBinary) and job_id
    //callback should only be allowed to be called by the proxy contract
    NoisReceive { callback: NoisCallback },
}
```

In the receive function you can implement whatever you would like to do with the
randomness. You directly use the randomness as a raw hexadecimal or you can
apply some common randomness functionalities that you get from the Nois toolbox
crate.

```rust
// in contract.rs

//The execute_receive function is triggered upon reception of the randomness from the proxy contract
//The callback contains the randomness from drand (HexBinary) and the job_id
pub fn execute_receive(
    deps: DepsMut,
    _env: Env,
    info: MessageInfo,
    callback: NoisCallback,
) -> Result<Response, ContractError> {
    //load proxy address from store
    let proxy = NOIS_PROXY.load(deps.storage)?;
    //callback should only be allowed to be called by the proxy contract
    //otherwise anyone can cut the randomness workflow and cheat the randomness by sending the randomness directly to this contract
    ensure_eq!(info.sender, proxy, ContractError::UnauthorizedReceive);

    // In this Dapp we don't need the drand publish time. so we skip it with ..
    let NoisCallback {
        job_id, randomness, ..
    } = callback;

    let randomness: [u8; 32] = randomness
        .to_array()
        .map_err(|_| ContractError::InvalidRandomness)?;
    //ints_in_range provides a list of random numbers following a uniform distribution within a range.
    //in this case it will provide uniformly randomized numbers between 1 and 6
    let double_dice_outcome = ints_in_range(randomness, 2, 1, 6);
    //summing the dice to fit the real double dice probability distribution from 2 to 12
    let double_dice_outcome = double_dice_outcome.iter().sum();

    //Preserve the immutability of the previous rounds.
    //So that the player cannot retry and change history.
    let response = match DOUBLE_DICE_OUTCOME.may_load(deps.storage, &job_id)? {
        None => Response::default(),
        Some(_randomness) => return Err(ContractError::JobIdAlreadyPresent),
    };
    DOUBLE_DICE_OUTCOME.save(deps.storage, &job_id, &double_dice_outcome)?;

    Ok(response)
}
```
