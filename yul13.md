```solidity
pragma solidity 0.8.17;

contract yulChangePointer{
  
  function test(uint testNum) public pure returns(uint) {
    
    assembly {
       
       mstore(0x40 , 0xd2)
  }

  uint8[3] memory myarray = [1,2,3];

  return testNum ;

}
}
```
