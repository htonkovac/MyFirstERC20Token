pragma solidity ^0.4.8;
import './ERC20Interface.sol';

contract owned {
    
    address owner;

    
    function owned() {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
}


contract MyFirstToken is owned,ERC20Interface {
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    string public constant name     =  "MyFirstToken";
    string public constant symbol   =  "MTC";
    uint8  public constant decimals =  3;  
    
    uint256 _totalSupply = 1337000;
    mapping( address => uint256 ) balances;
    mapping( address => mapping(address => uint256)) allowed;
    
    
    /* Constructor */
    function MyFirstToken() owned() {
        balances[owner] += _totalSupply;
    }
    
    /* Methods */
    function totalSupply() constant returns (uint256 supply) {
         supply = _totalSupply;
     }
   
    function balanceOf(address _owner) constant returns (uint256 balance) {
          return balances[_owner];
      }
    
    function transfer(address _to, uint256 _value) returns (bool success) {
        success = false;
        if(balances[msg.sender] >= _value && balances[_to]+_value > balances[_to]) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            
            success = true;
        } 
    }
 
    function transferFrom(address _from, address _to, uint _value) returns (bool success) {
        require(balances[_from] >= _value);
        require(allowed[_from][msg.sender] >= _value);
        require(balances[_from]+_value > balances[_from]);
        
        allowed[_from][msg.sender] -= _value;
        balances[_from] -= _value;
        balances[_to] += _value;
        
        return true;
    }
    
    function approve(address _spender, uint256 _value) returns (bool success) {
      allowed[msg.sender][_spender] = _value;  
      
      return true;
    }
    
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

}
