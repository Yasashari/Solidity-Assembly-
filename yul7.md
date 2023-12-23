```solidity

//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

contract AssemblyVar{

    function assemIf(uint x) public pure returns(uint z) {
        assembly {
           if lt(x , 10) {z := 99}
        }
    }


    function assemSwitch(uint x) public pure returns (uint z) {
        assembly {
            switch x
            case 1 {
                z:=10
            }
            case 2 {
                z:=20
            }

            default {
                z:=100
            }
        }
    }


    function min(uint x , uint y) public pure returns(uint z) {
        z = y ;
        assembly {
            if lt(x , y) {z:=x}
        }

    }

    
    function max(uint x , uint y) public pure returns(uint z) {
       

        assembly {
            switch gt(x , y) 
            case 1 {
                z:= x
            }
            default {
                z:= y
            }
            
        }
    }
  
}

```
