// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import "forge-std/Test.sol";
import {Filesystem} from "../Filesystem.sol";
import {Hexadecimal} from "codec/Hexadecimal.sol";

contract FilesystemTest is Test {
  using Hexadecimal for address;
  using Hexadecimal for bytes;
  Filesystem fs;

  constructor () {
    fs = new Filesystem();
  }

  function testWrite(bytes memory text) public {
    emit log_bytes(text);
    bytes memory filename = fs.write(text.hexadecimal());
    assertEq0(fs.readHexadecimal(filename), text);
  }

  function testReadAddress(address a) public {
    bytes memory filename = fs.write(a);
    assertEq(fs.readAddress(filename), a);
  }
}
