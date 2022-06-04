// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {IO} from "../IO.sol";

contract EchoAll is IO {
  constructor () IO() {}

  function handleInput (bytes memory input) internal override returns (bytes memory) {
    return input;
  }
}

