```solidity
//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;


contract YulToken{
    // name = Yul Token
    bytes32 constant nameData = 0x59756C20546F6B656E0000000000000000000000000000000000000000000000 ;
    bytes32 constant nameLength = 0x0000000000000000000000000000000000000000000000000000000000000009 ;
    // symbol = "YUL"
    bytes32 constant symbolLength = 0x0000000000000000000000000000000000000000000000000000000000000009 ;
    bytes32 constant symbolData = 0x59554C0000000000000000000000000000000000000000000000000000000000 ;

    uint256 constant maxUint256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff ;
    // keccak256(InsufficientBalance())
    bytes32 constant insufficientBalanceSelector = 0xf4d678b800000000000000000000000000000000000000000000000000000000 ;
    // keccak256(InsufficientAllowance(address,address))
    bytes32 constant insufficientAllowanceSelector = 0xf180d8f900000000000000000000000000000000000000000000000000000000 ;

    // keccak256(Transfer(address,address,uint256))
    bytes32 constant trasnsferHash = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef ;
    bytes32 constant approvalHash = 0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925 ;

    error InsufficientBalance();
    error InsufficientAllowance(address owner, address spender);

    event Transfer(address indexed sender, address indexed reciever , uint256 amount);
    event Approval(address indexed owner , address indexed spender , uint256 amount);

    mapping(address=>uint256) internal _balances;
    mapping(address=>mapping(address=>uint256)) internal _allowances;

    uint256 internal _totalSupply ;


    constructor(){
        assembly {
            mstore(0x00 , caller())
            mstore(0x20 , 0x00)
            let balanceSlot := keccak256(0x00 , 0x40)
            sstore(balanceSlot , maxUint256)

            sstore(0x02 , maxUint256)

            mstore(0x00 , maxUint256)
            log3(0x00,0x20,trasnsferHash,0x00,caller())
        }
    }

   
   function name() public pure returns(string memory) {
     assembly {
        let memptr := mload(0x40)
        mstore(memptr ,0x20)
        mstore(add(memptr , 0x20) , nameLength)
        mstore(add(memptr , 0x40) , nameData)
        return (memptr , 0x60)
     }

   }

   function symbol() public pure returns(string memory){
    assembly {
        let memptr := mload(0x40)
        mstore(memptr , 0x20)
        mstore(add(memptr,0x20),symbolLength)
        mstore(add(memptr,0x40),symbolData)
        return(memptr,0x60)
    }
   }

    function decimals() public pure returns(uint8){
        assembly {
            mstore(0x00 , 18)
            return(0x00, 0x20)
        }
    }


    function balanceOf(address) public view returns(uint256) {
     assembly {

        mstore(0x00 , calldataload(4))
        mstore(0x20 , 0)
        mstore(0x00 , sload(keccak256(0x00, 0x40)))
        return(0x00 , 0x20)
     }

    }


    function totalSupply() public view returns(uint256) {
        assembly {
            mstore(0x00 , sload(0x02))
            return(0x00 , 0x20)
        }
    }


    function transfer(address reciever , uint256 value) public returns(bool) {
        assembly {
            let memptr := mload(0x40)
            mstore(memptr , caller())
            mstore(add(memptr , 0x20) , 0x00)
            let callerBalanceSlot := keccak256(memptr , 0x40)
            let callerBalance := sload(callerBalanceSlot)

            if lt(callerBalance , value) {
                mstore(0x00 , insufficientBalanceSelector)
                revert(0x00 , 0x04)
            }

            if eq(caller() , reciever) {
                revert(0x00 , 0x00)
            }

            let newCallerBalance := sub(callerBalance , value)
            sstore(callerBalanceSlot , newCallerBalance)

            mstore(memptr , reciever)
            mstore(add(memptr, 0x20) , 0x00)
            let recieverBalanceSlot :=keccak256(memptr, 0x40)
            let recieverBalance :=sload(recieverBalanceSlot)

            let newRecieverBalance :=add(recieverBalance , value)

            
            sstore(recieverBalanceSlot , newRecieverBalance)

            mstore(0x00 , value)
            log3(0x00,0x20 ,trasnsferHash , caller(), reciever )
            
            mstore(0x00 , 0x01)
            return(0x00 , 0x20)

        }
    }


    function allowance(address owner, address spender) public view returns(uint256) {
         
         assembly {
            mstore(0x00 , owner)
            mstore(0x20 , 0x01)

            let innerHash := keccak256(0x00 , 0x40)

            mstore(0x00 , spender)
            mstore(0x20 , innerHash)

            let allowanceSlot := keccak256(0x00 , 0x40)

            let allowanceValue := sload(allowanceSlot)

            mstore(0x00 , allowanceValue)
            return(0x00 , 0x20)

         }

    }


    function approve(address spender , uint256 amount) public returns(bool) {
        assembly{
            mstore(0x00 , caller())
            mstore(0x20 , 0x01)

            let innerHash := keccak256(0x00 , 0x40)

            mstore(0x00 , spender)
            mstore(0x20 , innerHash)

            let allowanceSlot := keccak256(0x00 , 0x40)

            sstore(allowanceSlot , amount)

            mstore(0x00 , amount)
            log3(0x00 , 0x20 , approvalHash, caller(), spender)

            mstore(0x00 , 0x01)
            return(0x00 , 0x20)

        }
    }


    function trasnferFrom(address sender , address reciever , uint256 amount) public returns(bool) {
        assembly {
            let memptr := mload(0x40)
            mstore(0x00 , sender)
            mstore(0x20 , 0x01)
            let innerHash := keccak256(0x00, 0x40)

           mstore(0x00 , caller())
           mstore(0x20, innerHash)
           let allowanceSlot := keccak256(0x00 , 0x40)

           let callerAllowance := sload(allowanceSlot)

           if lt(callerAllowance , amount) {
            mstore(memptr , insufficientAllowanceSelector)
            mstore(add(memptr , 0x04) , sender)
            mstore(add(memptr , 0x24) , caller())

            revert(memptr , 0x44)
           }
          
           if lt(callerAllowance , maxUint256){
            sstore(allowanceSlot , sub(callerAllowance , amount))
           }

           mstore(memptr , sender)
           mstore(add(memptr , 0x20) , 0x00)
           let senderBalanceSlot := keccak256(memptr , 0x40)
           let senderBalance := sload(senderBalanceSlot)

           if lt(senderBalance , amount){
            mstore(0x00 , insufficientBalanceSelector)
            revert(0x00 , 0x04)
           }

           sstore(senderBalanceSlot , sub(senderBalance , amount))

           mstore(memptr , reciever)
           mstore(add(memptr , 0x20) , 0x00)
           let recieverBalanceSlot := keccak256(memptr , 0x40)
           let recieverBalance   := sload(recieverBalanceSlot)

           sstore(recieverBalanceSlot , add(recieverBalance , amount))


           mstore(0x00 , amount)
           log3(0x00 , 0x20 , trasnsferHash , sender , reciever)
            
           mstore(0x00 , 0x01)
           return(0x00 , 0x20) 

        }


    }




}

```
