// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {Script} from "forge-std/Script.sol";
import {Reader} from "./Reader.sol";

contract EchoLine is Script {
  event echo(string);

  function run() external {
    emit echo(string((new Reader()).readline()));
  }
}
