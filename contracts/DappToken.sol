pragma solidity ^0.5.16;

contract DappToken{
	//name
	string public name = "DApp Token";
	//symbol
	string public symbol = "DAPP";
	string public standard = "DApp Token v1.0";

	uint256 public totalSupply;

	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);


	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint256 _value
	);
	

	mapping(address => uint256) public balanceOf;
	//allowance
	mapping(address => mapping(address => uint256)) public allowance;


	constructor (uint256 _initialSupply) public {
		//allocate the initial supply
		balanceOf[msg.sender] = _initialSupply;
		totalSupply = _initialSupply;
	}


	//Transfer
	function transfer(address _to, uint256 _value) public returns (bool success) {
		//Exception if the account doesn't have enough tokens
		require(balanceOf[msg.sender] >= _value);
		//tranfer the balance
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;

		//transfer event
		emit Transfer(msg.sender, _to, _value);

		//returns a boolean
		return true;
	}


	//Delegated transfer


	//approve
	function approve(address _spender, uint256 _value) public returns (bool success){
		//allowance
		allowance[msg.sender][_spender] = _value;


		//approve event
		emit Approval(msg.sender, _spender, _value);

		return true;
	}


	//transferFrom
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
		//require from account has enough tokens
		require(_value <= balanceOf[_from]);
		//require allowance is big enough
		require(_value <= allowance[_from][msg.sender]);		
		
		//change the balance
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;

		//update the allowance
		allowance[_from][msg.sender] -= _value;

		//transfer event
		emit Transfer(_from, _to, _value);
		//return a boolean
		return true;
	}
}