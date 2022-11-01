

// SPDX-License-Identifier:MIT 

pragma solidity 0.8.17; 

/**
    @title Basic Implementation  of the ERC-20 token standard as defined by the EIP20 
    
*/


import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/utils/math/SafeMath.sol";

contract ERC20Token { 

    using SafeMath for uint256;
    // State Vars
    string public symbol = "GOL" ; 
    string public name = "GOLD Token";
    uint256 public decimals = 18; 
    uint256 public totalSupply = 1000;
    address private owner; 

     mapping (address => uint256) balances; 
    mapping (address => mapping(address => uint256)) allowed;
 

    event Transfer (address indexed from , address indexed to, uint256 value); 
    event Approval(address indexed owner, address indexed recipient, uint256 value);

    constructor(
        // Local Vars
        string memory _symbol,
        string memory _name, 
        uint256 _decimals,
        uint256 _totalSupply
    ) public 
    { 
        name= _name; 
        symbol = _symbol; 
        decimals = _decimals; 
        totalSupply = _totalSupply;
        balances[msg.sender]  = _totalSupply;

        emit Transfer(address(0), msg.sender, _totalSupply) ; 
    }

    /**
    @notice Getter function to check the current balance of an address
    @param  _owner Address  to query the balance of
    @return  Token balance
    */
    function balanceOf(address _owner) public view returns(uint256) { 
        return balances[_owner]; 
    }



    /**
    @notice Getter function to check the amount !of tokens that an owner allowed to a spender. 
    @param _owner The address which owns the funds.
    @return The amount of tokens still available for the spender.
    */
    function allowance( address _owner, address _spender) public view returns (uint256) { 
        return allowed[_owner][_spender]; 
    }

    /** 
    @notice Approve an address to spend the specified amoubnt on behalf of msg.sender
    @dev Please be aware that changing an allowance with this method brings the risk
    that someone may use both the old and the new allowance by unfortunate Tx ordering.
    One possible solution to mitigate this is to first reduce the spendert allowance to zero 
    and then set the desired value afterwards. 
    @param _spender The address which will receive the allowed funds.
    @param _value  The amount tof tokens to be spent.
    @return Sucess boolean
    */
    function approve(address _spender, uint256 _value) public returns (bool) { 
        allowed[msg.sender][_spender] = _value; 
        emit Approval(msg.sender, _spender, _value); 
        return true;
    }



   /** shared logic from Transfer & TransferFrom **/ 
   function _transfer(address _from,  address _to, uint256 _value) internal  { 
       require(balances[_from] >= _value, "Insufficient Balance");
       balances[_from] = balances[_from].sub(_value); 
       balances[_to]   = balances[_to].add(_value); 
       emit Transfer(_from, _to, _value); 
   }

   /** 
    @notice  Transfer tokens to a specified address.
    @param _to The aDdress to transfer to.
    @param _value The amount to be transferred.
    @return Success boolean.
   */
    function _transfer(address _to, uint256 _value) public returns (bool) { 
        _transfer(msg.sender, _to, _value); 
        return true;
    }



    /**
    @notice Tranfer tokens from one address to another address. 
    @param _from  The address which you want the toekns to be transfereed from. 
    @param _value The amount of tokens to be transferred.
    @return success boolean.
    */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) { 
        require(allowed[_from][msg.sender] >= _value, "Insufficient") ;
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value); 
        _transfer(_from, _to, _value); 
        return true; 
    }



}
