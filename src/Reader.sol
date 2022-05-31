// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {Test} from "forge-std/Test.sol";
import {Bash} from "bash/Bash.sol";

contract Reader is Test {
  function readline() public returns (bytes memory result){
    Bash bash = new Bash();
    result = bash.run(bytes.concat("head -n1 input|cast --from-utf8"), "");
  }
}
