pragma solidity^0.4.0;

contract ERC20{
    function totalSupply() constant returns (uint256 totalSupply);
    function balanceOf(address _owner) constant returns (uint256 balance);
    function transfer(address _to, uint256 _value) returns (bool success);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract SafeMath{
    function  add(uint256 a, uint256 b) internal  returns(uint256){

        return a+b;
        
    }

    function sub(uint256 a, uint256 b) internal returns(uint256){
        require(a >= b);

        return a - b  ;
    }
}


contract owned{

    address internal owner;
    modifier onlyowner{
        require(msg.sender == owner);
          _;

    }
    function delegate(address NewOwner){
        owner = NewOwner;
    }


}


contract mytoken is ERC20, owned, SafeMath{

    mapping(address => uint) balances;
    uint256 public _totalSupply = 1000000000000000000000000;
    string public name = 'Paper';
    string public symbol = 'PP';
    uint8 public decimals = 16;

    constructor() public{
        owner = msg.sender;
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0),msg.sender, _totalSupply);

    }

    function totalSupply() constant returns (uint256 totalSupply){

        return _totalSupply;

    }
    function balanceOf(address _owner) constant returns (uint256 balance){

        return balances[_owner];
    }
    function transfer(address _to, uint256 _value) returns (bool success){
        require( _to != address(0));
        require(balances[msg.sender] >= _value);

        balances[msg.sender] = sub(balances[msg.sender],_value);
        balances[_to] = add(balances[_to],_value);
        return true;

    }

    function whoisowner() constant returns(address){
        return owner;
    }
}
