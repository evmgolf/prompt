# prompt - shell scripting in solidity

## Installation
`forge install https://github.com/evmgolf/prompt`

## Development
Create a contract inheriting from `prompt/IO.sol` and implement `handleInput`.

See [src/example](src/example) for example scripts.

## Usage
prompt [forge arguments..] -- {ContractOrPath} [-c] [-j] [shell arguments...]

### Example
`prompt -f $ETH_RPC_URL -- Pay -c -j help`

```
[
  "address - prints msg.sender",
  "balance [address=msg.sender] - prints the balance of the address",
  "pay [to] [amount]"
]
> 
```
