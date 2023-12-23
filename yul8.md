```solidity
//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

contract AssemblyVar{
    function assemError(uint x) public pure {
      assembly {
        if gt(x , 10) {
            revert(0,0)
        }
      }
    }
}
```
