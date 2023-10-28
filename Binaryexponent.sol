//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

// x**n calculation
contract Binaryexponent {   
    function assembrpower(uint x, uint n , uint b) public pure returns(uint z) {

        assembly {
            switch x 
            case 0 {
                 // case 0  --> 0**0 = 1
            
                 // case 1   -->0**n = 0
                switch n
                case 0 { z:=b }

                default { z:= 0 }
            }

            default{
                switch mod(n,2)
                case 0 {z:=b}

                default{z:=x}

                let half := div(b,2)
                // n=n/2 , n>0 , n=n/2
                for { n := div(n ,2)} n { n := div(n,2) } {
                 let xx := mul(x,x)
                 if iszero(eq(div(xx,x) , x)) {
                    revert(0,0)
                 }  

                 let xxRound :=add(xx , half)

                 if lt(xxRound , xx) {
                    revert(0,0)
                 } 


                 x := div(xxRound, b)

                if mod(n,2) {
                    let zx := mul(z, x)

                if and(iszero(iszero(x)) ,iszero(eq(div(zx,x) , z))) {
                    revert(0,0)
                 }    
                    let zxRound := add(zx , half)

                     if lt(zxRound , zx) {
                     revert(0,0)
                    } 
                    z:= div(zxRound , b)
                }
                 
                }
                
            }
        }
    }

}
