```solidity
//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

contract AssemblyVar{

    function asseFor() public pure returns(uint z) {
        assembly {
            for {let i:= 0 } lt(i,10) { i:=add(i , 1)} {

                z := add(z , i)

            }
        }
    }


    function asseWhile() public pure returns(uint z) {

        assembly {
            let i:= 0
            for {} lt(i,10) {} {
                i := add(i , 1)
                z := add(z , i)
            }
        }
    }


    function sum(uint n) public pure returns(uint total) {
        
        assembly {
            for {let i:= 1} lt(i , n) { i:=add(i,1)} {

                total := add(total , i)

            }
        }

    }


    function pow2k(uint x , uint n) public pure returns (uint z) {
      
        assembly {
          if mod(n , 2) {
            revert (0,0)
          }

        switch n 

        case 0 { z := 0}
        default { 
            z := x

            for { } gt(n , 1) { } {

                z := mul(z, z)
                n := div(n,2)

            }
         }
            
        }
    }



}
```
