# Nois Toolbox

> To safely transform and manipulate your randomness, onchain and offchain.

---

Next to providing the randomness, Nois offers a set of tooling to help
developers reshape the received randomness in order to apply it to their custom
use case.

#### Why use the nois-toolbox instead of transforming the randomness yourself?

Sometimes it can be challenging to manipulate randomness and you can end up with
a randomness that follows a different distribution from what is intended or you
can also unintentionally lower the entropy of the original randomness. This is
why Nois provides this well tested, standard and opensource toolbox that
everyone can contribute to and maintain. This way it is in the interest of all
that any bug is quickly fixed and the efforts of 1 project contribute to the
common good.

---

The Nois Toolbox can be compiled to JavaScript via WebAssembly. This way you can
simulate the outputs for every randomness value. The results match exactly those
of CosmWasm contracts using the same tools. The toolbox is available in this
github [repository](https://github.com/noislabs/nois) and two artifacts are
published.

- The rust [crate](https://crates.io/crates/nois)
- The npm [package](https://www.npmjs.com/package/nois)

If you want to use the nois-toolbox in your contract all you have to do is
import the nois crate. If you want to verify, play or simulate the randomness
offchain on a script or a UI on a browser instead you can use the nois npm
package. ​ This table provides an overview of the functions that the toolbox
provides

| Function       | Description                                                                                                                                                                                                                 |
| -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| coinflip       | Returns heads or tails.                                                                                                                                                                                                     |
| roll_dice      | returns a random int between 1-6. For a double(or multi) dice you can use ints_in_range or sub_randomness instead.                                                                                                          |
| decimal        | Returns a random decimal between 0 and 1 (uniform distribution).                                                                                                                                                            |
| ints_in_range  | Provides a list of integers between two numbers. Can be used for a double dice throw                                                                                                                                        |
| int_in_range   | Provides one integer between two numbers. Can be used for a single dice                                                                                                                                                     |
| shuffle        | Shuffles a vector using the Fisher-Yates algorithm. Can be used for an NFT hero creation with many objects/items/skills to randomly shuffle                                                                                 |
| sub_randomness | Generates more more random numbers out of a single round of drand round. This can be needed if for example you want to run many lotteries in parallel using the same randomness round without sacrificing the high entropy. |
