# Using the Nois Toolbox in js

The Nois Toolbox can be compiled to JavaScript via WebAssembly. This way you can
simulate the outputs for every randomness value. The results match those of
CosmWasm contracts using the same tools. The Nois
[Simulator](https://simulator.nois.network/) is a good example for such a
usecase. In order to keep the JS/Wasm interface simple, there is a wrapper in
the module lib/js which takes the randomness inputs in hex format and uses types
and error handling that plays well with JS. JS/Wasm bindings are created using
wasm-bindgen. The JS does not match 100% the contract implementation. The
differences are documented here.

| Contract function                                                               | JS function    | Status     | Note                                                               |
| ------------------------------------------------------------------------------- | -------------- | ---------- | ------------------------------------------------------------------ |
| [nois::coinflip](https://docs.rs/nois/latest/nois/fn.coinflip.html)             | coinflip       | ✅ Ready   | Returns string instead of enum                                     |
| [nois::roll_dice](https://docs.rs/nois/latest/nois/fn.roll_dice.html)           | roll_dice      | ✅ Ready   | ----           
| https://docs.rs/nois/latest/nois/fn.pick.html                                   | pick           | ✅ Ready   | ----           |
| [nois::select_from_weighted](https://docs.rs/nois/latest/nois/fn.select_from_weighted.html)   | select_from_weighted   | ✅ Ready   |---- |
| [nois::int_in_range](https://docs.rs/nois/latest/nois/fn.int_in_range.html)     | int_in_range   | ✅ Ready   | Only supports half-oen range, i.e. the end value is always exluded |
| [nois::ints_in_range](https://docs.rs/nois/latest/nois/fn.ints_in_range.html)   | ints_in_range  | ✅ Ready  | ----                                                               |
| [nois::random_decimal](https://docs.rs/nois/latest/nois/fn.random_decimal.html) | random_decimal | ✅ Ready   | Encodes result Decimal as string                                   |
| [nois::sub_randomness](https://docs.rs/nois/latest/nois/fn.sub_randomness.html) | sub_randomness | ✅ Ready   | Takes a count argument and returns an Array instead of an iterator |
| [[nois::shuffle](nois::shuffle)](https://docs.rs/nois/latest/nois/fn.shuffle.html)  | shuffle    |  ✅ Ready  | ----      |
