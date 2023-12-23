```solidity
//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

contract yulMemory{
  
  function test(uint testNum) public pure returns(uint) {
    assembly {
        let _num := 4
        let _fmp := mload(0x40)
    }
 
     uint8[3] memory items = [1,2,3] ;

    

      return testNum ;
  }

}

```
