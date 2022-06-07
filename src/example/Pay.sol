// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {IO} from "../IO.sol";
import {Hexadecimal} from "codec/Hexadecimal.sol";
import {Decimal} from "codec/Decimal.sol";
import {Tokenizer} from "codec/Tokenizer.sol";

contract Pay is IO {
  using Hexadecimal for address;
  using Hexadecimal for bytes;
  using Decimal for uint;
  using Decimal for bytes;
  using Tokenizer for bytes;

  constructor () IO() {}

  function handleInput (bytes memory input) internal override returns (bytes memory) {
    bytes[] memory words = input.split(" ");

    bytes32 words0 = keccak256(words[0]);
    if (words0 == keccak256(bytes("help"))) {
      return bytes.concat(
        "\"address - prints msg.sender\n",
        "balance [address=msg.sender] - prints the balance of the address\n",
        "pay [to] [amount]\""
      );
    } else if (words0 == keccak256(bytes("address"))) {
      return msg.sender.hexadecimal();
    } else if (words0 == keccak256(bytes("balance"))) {
      address a;
      if (words.length == 1) {
        a = msg.sender;
      } else {
        a = words[1].decodeAddress();
      }
      return a.balance.decimal();
    } else if (words0 == keccak256(bytes("pay"))) {
      address payable to = payable(words[1].decodeAddress());
      uint amount = Decimal.decodeUint(words[2]);
      to.transfer(amount);
    } else {
      running = false;
    }
  }
}

