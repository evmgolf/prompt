// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {Script} from "forge-std/Script.sol";
import {Filesystem} from "./Filesystem.sol";

abstract contract IO is Script {
  Filesystem fs;
  bool running = true;

  constructor () {
    fs = new Filesystem();
  }

  function run() external {
    bytes memory inputFile = bytes(vm.envString("INPUT_FILE"));
    bytes memory outputFile = bytes(vm.envString("OUTPUT_FILE"));

    fs.write(outputFile, "");
    while (running) {
      bytes memory input = fs.readLine(inputFile);
      bytes memory output = handleInput(input);
      fs.write(outputFile, output);
    }
  }

  function handleInput(bytes memory input) internal virtual returns (bytes memory);
}
