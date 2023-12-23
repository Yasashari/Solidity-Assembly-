```solidity
//SPDX-License-Identifier:MIT

pragma solidity 0.8.17 ;


contract yul4 {

   uint public x = 2;

   mapping(uint=>mapping(uint=>uint)) public y ;


   function setmap(uint key1 , uint key2 ,uint val) public {
       y[key1][key2] = val ;
   }

   function readslot(uint i) public view returns(bytes32 content) {
                      
       assembly {
                
           content := sload(i)
       }   

   }


   function computeSlot(uint key , uint mapslot) public pure returns(uint slot) {

    slot = uint256(keccak256(abi.encode(key , mapslot))) ;
   }
}
```
