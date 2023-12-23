```solidity
//SPDX-License-Identifier:MIT

pragma solidity 0.8.17 ;


contract yul55 {

   struct S{uint16 a ; uint16 b ; uint256 c ;}
   uint public x ;
   mapping(uint=>mapping(uint=>S)) public data  ;


   function setmap(uint key1 , uint key2 ,uint val) public {
       data[key1][key2].c = val ;
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
