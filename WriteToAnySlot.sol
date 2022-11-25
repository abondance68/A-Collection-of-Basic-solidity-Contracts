


/**
 * @notice Solidity storage is like an array of length 2^256 
 * Each slot in the array can store 32 bytes.
 * State vars define which slots will be used to store data.
 * 
 */

// SPDX-License-Identifier:  MIT
pragma solidity 0.8.17; 

// Import this file to use console.log
//import "hardhat/console.sol";

contract WriteToAnySlot { 
            struct MyStruct { 
                uint value;
            }

        // struct stored at slot 0.
        MyStruct public s0 = MyStruct(123); 

        // struct stored at slot 1.
        MyStruct public s1 = MyStruct(456); 

        // struct stored at slot 2.
        MyStruct public s2 = MyStruct(789); 

        function _get(uint i) internal pure returns (MyStruct storage s) { 
            // get struct stored at slot i 
                assembly { 
                s.slot := i 
        }


}


/*
get(0) returns 123.
get(1) returns 456.
get(2) returns 789.
*/

function get(uint i)  external view returns (uint) { 
    // get value inside myStruct stored at slot i 
    return _get(i).value; 
}



function set(uint i, uint x ) external { 
    // set value of MyStruct to x & store it at slot i. 
    _get(i).value = x; 

}

}
