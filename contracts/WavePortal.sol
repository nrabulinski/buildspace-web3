// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
	Wave[] waves;

	struct Wave {
		address waver;
		string message;
		uint timestamp;
	}

	event newWave(address indexed from, uint timestamp, string message);

	constructor() {
		console.log("Hello from a smart contract?");
	}

	function wave(string memory _message) public {
		console.log("%s is waved!", msg.sender);
		waves.push(Wave(msg.sender, _message, block.timestamp));
		emit newWave(msg.sender, block.timestamp, _message);
	}

	function getAllWaves() view public returns (Wave[] memory) {
		return waves;
	}

	function getTotalWaves() view public returns (uint) {
		console.log("We have %d total waves", waves.length);
		return waves.length;
	}
}
