

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Counter {
     uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

      function  multiplyBy10() public view returns(uint256) { 
        return number*10; 
    }
}


