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
  using Hexadecimal for bytes;

  uint files;
  Bash bash;

  constructor () {
    bash = new Bash();
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

  function remove(bytes memory filename) public {
    bash.run(bytes.concat("rm ", filename), "");
  }

  function createPipe(bytes memory filename) public {
    bash.run(bytes.concat("mkfifo ", filename), "");
  }

  function write(bytes memory filename, bytes memory text) public {
    bash.run(bytes.concat("echo ", text.hexadecimal(), "|xxd -r -p"), filename);
  }

  function write(bytes memory filename, address a) public {
    return write(filename, a.hexadecimal());
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
