// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {Test} from "forge-std/Test.sol";
import {Bash} from "bash/Bash.sol";
import {Decimal} from "codec/Decimal.sol";
import {Hexadecimal} from "codec/Hexadecimal.sol";

contract Filesystem is Test {
  using Decimal for uint;
  using Hexadecimal for address;
  using Hexadecimal for uint;

  bytes public filenamePrefix = "/tmp";
  uint files;
  Bash bash;

  constructor () {
    bash = new Bash();
  }

  function setFilenamePrefix(bytes memory prefix) public {
    filenamePrefix = prefix;
  }

  function exists(bytes memory filename) public returns (bool) {
    return abi.decode(
      bash.run(
        bytes.concat(
          "[ -f ",
          filename,
          " ] && cast --to-uint256 1 || cast --to-uint256 0"
        ),
        ""
      ),
      (bool)
    );
  }

  function write(bytes memory text) public returns (bytes memory filename) {
    filename = bytes.concat(filenamePrefix, "/", uint(keccak256(text)).hexadecimal());
    bash.run(bytes.concat("echo ", text), filename);
  }

  function write(address a) public returns (bytes memory) {
    return write(a.hexadecimal());
  }

  function readHexadecimal(bytes memory filename) public returns (bytes memory){
    return bash.run(bytes.concat("head -n1 ", filename), "");
  }

  function readLine(bytes memory filename) public returns (bytes memory){
    return bash.run(bytes.concat("head -n1 ", filename, "|cast --from-utf8"), "");
  }

  function readAddress(bytes memory filename) public returns (address) {
    return abi.decode(
      bash.run(
        bytes.concat(
          "cast --concat-hex 0x000000000000000000000000 $(head -n1 ",
          filename,
          ")"
        ),
        ""
      ),
      (address)
    );
  }
}
