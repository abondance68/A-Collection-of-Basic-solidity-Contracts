
//SPDX-License-Identifier:MIT

pragma solidity ^0.8.13; 

contract Account {  // This contract simulates basic bank account operations, like deposit & withdraw
  uint public balance; 


  function deposit(uint _amount) public  { 

    uint oldBalance = balance; 
    balance =+ _amount; 

    assert(balance >= oldBalance);

  }

  function withdraw (uint _amount ) public { 
    uint oldBalance = balance; 

    balance -= _amount; 

    assert(balance <=  oldBalance); 

  }

}