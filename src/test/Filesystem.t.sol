// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import "forge-std/Test.sol";
import {Filesystem} from "../Filesystem.sol";
import {Hexadecimal} from "codec/Hexadecimal.sol";
import {Decimal} from "codec/Decimal.sol";

contract FilesystemTest is Test {
  using Hexadecimal for address;
  using Hexadecimal for bytes;
  using Decimal for uint;

  Filesystem fs;
  bytes filenamePrefix;
  uint testCount;

  constructor () {
    fs = new Filesystem();
    filenamePrefix = "/tmp/a";
  }

  function genFilename() internal returns (bytes memory) {
    return bytes.concat(filenamePrefix, (testCount++).decimal());
  }

  function testWrite(bytes memory text) public {
    bytes memory filename = genFilename();
    fs.write(filename, text.hexadecimal());
    assertEq0(fs.readHexadecimal(filename), text);
  }

  function testReadAddress(address a) public {
    bytes memory filename = genFilename();
    fs.write(filename, a);
    assertEq(fs.readAddress(filename), a);
  }
}
