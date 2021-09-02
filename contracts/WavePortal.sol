// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
	Wave[] waves;
	mapping(address => uint) public lastWavedAt;
	uint private seed;

	struct Wave {
		address waver;
		string message;
		uint timestamp;
		bool won;
	}

	event newWave(address indexed from, uint timestamp, string message, bool won);

	constructor() payable {
		console.log("Hello from a smart contract?");
	}

	function prize(address sender) private returns (bool) {
		if (lastWavedAt[sender] + 15 minutes >= block.timestamp)
			return false;

		lastWavedAt[sender] = block.timestamp;

		uint randomNumber = uint(keccak256(abi.encode(block.difficulty + block.timestamp + seed)));
		seed = randomNumber;

		if (randomNumber % 10 != 0)
			return false;

		console.log("%s won!", msg.sender);
		uint prizeAmount = 0.001 ether;

		// require(prizeAmount <= address(this).balance, "Not enough money in the contract");
		if (prizeAmount > address(this).balance)
			return false;

		(bool success,) = (msg.sender).call{ value: prizeAmount }("");
		//require(success, "Failed to send the prize");
		if (!success)
			return false;

		return true;
	}

	function wave(string memory _message) public {
		console.log("%s just waved!\n%s", msg.sender, _message);

		bool won = prize(msg.sender);

		waves.push(Wave(msg.sender, _message, block.timestamp, won));
		emit newWave(msg.sender, block.timestamp, _message, won);
	}

	function getAllWaves() view public returns (Wave[] memory) {
		return waves;
	}

	function getTotalWaves() view public returns (uint) {
		console.log("We have %d total waves", waves.length);
		return waves.length;
	}
}
