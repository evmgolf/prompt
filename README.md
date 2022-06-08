# prompt - shell scripting in solidity

## Requirements
forge, python, jq

## Installation
`forge install https://github.com/evmgolf/prompt`

## Development
Create a contract inheriting from `prompt/IO.sol` and implement `handleInput`.

The `prompt` command creates a REPL which calls `handleInput` with lines from `STDIN`, and writes their result to `STDOUT`.

In order to stop execution, the storage variable `running` is set to `false`.

See [src/example](src/example) for example scripts.

### Caveats
The `IO` contract uses bash ffi calls to read/write to fifo pipes.
These calls SHOULD be safe, as all write calls use hexadecimal encoding to avoid shell escaping.
However, this code has not been audited, please exercise due caution.
Additionally, by running the script with `--ffi`, third party libraries will also be able to make `ffi` calls.

## Usage
`prompt [forge arguments..] -- {ContractOrPath} [-c] [-j] [shell arguments...]`

### Flags
- `[shell arguments...]` - Passes arguments to the shell program to be executed immediately.

- `-c` - Continues execution after the shell arguments are executed.

- `-j` - Passes output through the json parser for data URI resolution and pretty printing.

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
