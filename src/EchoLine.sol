// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {Script} from "forge-std/Script.sol";
import {Filesystem} from "./Filesystem.sol";

contract EchoLine is Script {
  event echo(string);
  bytes filename = "input";
  Filesystem fs;

  constructor () {
    fs = new Filesystem();
  }

  function run() external returns (string memory text) {
    text = string(fs.readLine(filename));
    emit echo(text);
    return text;
  }
}
