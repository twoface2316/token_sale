pragma solidity ^0.5.16;

import "./DappToken.sol";

contract DappTokensale {
	address payable admin;
	DappToken public tokenContract;
	uint256 public tokenPrice;
	uint256 public tokensSold;

	event Sell(address _buyer, uint256 _amount);

	constructor (DappToken _tokenContract, uint256 _tokenPrice) public{
		//assign admin
		admin = msg.sender;
		//set token contract
		tokenContract = _tokenContract;
		//set token price
		tokenPrice = _tokenPrice;
	}

	
	//multiply
	function multiply(uint x, uint y) internal pure returns (uint z){
		require(y==0 || (z = x * y) / y==x);
	}


	//buy tokens
	function buyTokens(uint256 _numberOfTokens) public payable{
		//require that value is equal to tokens
		require(msg.value == multiply(_numberOfTokens, tokenPrice));
		//require that the contract has enough tokens
		require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
		//require that a transfer is successful
		require(tokenContract.transfer(msg.sender, _numberOfTokens));
		//keep track of number of tokens sold
		tokensSold += _numberOfTokens;
		//emit sell event
		emit Sell(msg.sender, _numberOfTokens);
	}


	//Enging token DappTokenSale
	function endSale() public{
		//require admin
		require(msg.sender == admin);
		//transfer remaining dapp tokens to admin
		require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
		//destroy contract
		selfdestruct(admin);

	}
}