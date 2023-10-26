//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

contract AssemblyVar{

    function add(uint x , uint y) public pure returns(uint z) {
        assembly {
            z:= add(x , y)
            if lt(z, x) {
                revert(0 , 0)
            }
        }
    }


   function mul(uint x , uint y) public pure returns(uint z){

    assembly {

        switch x 
        case 0 {z := 0}

        default{
             z:=mul(x , y)
        if iszero(eq(div(z , x) , y )){
            revert(0,0)
        }
    }
       
    }
   }


   function Yul_fixed_point_round(uint x , uint b) public pure returns(uint z) {
    
    assembly {
      let halfb := div(b , 2)
      z := add(x , halfb)
      z := mul(div(z , b) , b )
    }
   }


   function sub(uint x , uint y) public pure returns(uint z) {
    assembly {
        z:= sub(x , y)

        if lt(x , y) {
            revert( 0 , 0)
        }
    }

   }


   function fixed_point_mul(uint x , uint y , uint b) public pure returns(uint z) {
    assembly {
        switch x
        case 0 {z:= 0}
        default {
            z:= mul(x , y)
            if  iszero( eq(div(z , x) , y ) ) {
                revert(0, 0)
            }
            z:= div(z , b )
        }
    }
   }   
}
