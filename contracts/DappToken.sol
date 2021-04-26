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


	mapping(address => uint256) public balanceOf;

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
}