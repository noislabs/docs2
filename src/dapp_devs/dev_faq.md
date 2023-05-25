# Developer FAQ

---

In this page we would like to list some relevant questions developers have asked
in an attempt to gather some good knowledge

### Payment related questions

---

\- "I have funds in NOIS. I am about to deploy a nois-proxy on my chain, How
does the payment work? When we instantiate the proxy, should I send you the
"manager" or contract address? How will the proxy know to debit our account on
the Nois side, if that makes sense?"

\- So as soon as you open a channel between your proxy and the gateway, the
gateway will instantiate a nois-payment contract for your proxy. the proxy will
know by itself from IBC its nois-payment address. because it receives a welcome
packet from the gateway that will update it with the nois price and the
nois-payment contract that the gateway has instantiated for it.

---

\- "If I instantiate the proxy with the prices parameter [1.5juno,50nois], it
would mean that each GetNextRandomness call would cost this much?"

\- Yes! it will cost this OR that not a combination. So it will cost whether
1.5juno or 50 NOIS. But it will cost the Dapp to pay the proxy. So the proxy
gets those funds. You are the manager of the proxy so those are your funds.

---
