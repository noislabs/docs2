# Step By Step Guide to Randdrop

First things first, a randdrop is simply an airdrop with a final touch of
randomness to it. Meaning that not all preeligible wallets will get tokens but
only a random subset that will earn a larger portion of airdrop.

This randdrop aproach is used by Nois to airdrop NOIS tokens to other IBC
blockchains but also any other protocol wishing to make a randdrop using Nois
instead of a standard airdrop can follow this guide to randrop their tokens to
some community.

## How it works

A randdrop contract gets instantiated in any wasm-ibc chain (i.e the chain to
airdrop tokens to). The operator takes a snapshot of the chain in order to get a
state in time with the addresses to airdrop to with the respective amounts. This
snapshot is pretty much a json file like this
[file](https://gist.github.com/kaisbaccour/5a2f102ef476d533a3112b016aa45db4).
Then you merkelise the file(a tree of cryptographic hashes), and feed the merkle
root to the randdrop contract. Then the operator (person who is in charge of
managing the airdrop) communicates the file to the community (twitter for
example). Users can participate for a chance to win by checking the public json
file containing what addresses are pre-eligible, compute their merkle proof (the
webapp UI does that for them) and send the proof to the randdrop contract which
request a random beacon from Nois. Upon reception of the randomness, an account
has 1/3 of probability to receive the randdrop. This is interesting because it
allows protocols to target with their airdrop a bigger number of
communities/networks without diluting as much the airdrop amount per account.

### Why Merkle trees

We aimed for a merkle randdrop because it is more elegant, cost efficient, safer
and not spammy. When doing merkle randdrop you don't send tokens to all wallets,
instead users who are interested will come to claim your token. This is good for
many reasons:

- Legals: Companies in certain countries don't have to justify this token that
  they didn't even want to claim.
- Gas fees: Users will claim their tokens so the operator doesn't have to spend
  a big amount to airdrop to all these users
- performance and efficiency: The computation is done offchain on the browser of
  the user to calculate the merkle proof, and the contract doens't have to hold
  the data containing who gets what airdrop, instead the contract only holds the
  merkle root which is just a small hash.
- No waste: Tokens that are not claimed can be used for another airdrop to other
  community users who want it. so you can targer a larger community

### Why randdrop not airdrop

- With randdrop you can target even larger communities without diluting as much
  the claimed token. because a smaller subset withing a community gets a larger
  amount.
- It is more fun when there is the surprise effect.

## Step by Step

- You need to export and process the snapshot
- you need to deploy the contract

You can find the details for each step in the next pages
