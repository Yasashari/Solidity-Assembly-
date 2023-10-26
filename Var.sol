//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

contract AssemblyVar{

    function yul_let() public pure returns(uint z) {
        assembly{
            let x := 123
            z :=456
        }
    }
}
