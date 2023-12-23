```solidity
//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

contract yulChangePointer{
  
  function test(uint testNum) public pure returns(uint data) {
    
    assembly {
       let fmp :=mload(0x40)
       mstore(add(fmp , 0x00) , 0x68656C6C6F)
       data :=mload(fmp)
    }
     
  }

}

```
