```solidity
//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

contract yulChangePointer{
  
  function test(uint testNum) public pure returns(uint data) {
    assembly {
       mstore(0x40 , 0x90)
    }
 
     uint8[3] memory items = [1,2,3] ;

    assembly {
         data :=mload(add(0x90, 0x20))
    }

     
  }

}

```
