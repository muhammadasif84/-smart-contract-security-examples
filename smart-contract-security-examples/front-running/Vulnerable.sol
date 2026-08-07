// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title VulnerableGame
/// @notice DO NOT USE IN PRODUCTION
/// @dev Demonstrates front-running vulnerability
/// Full guide: coming soon on blockhertz.com/blog

contract VulnerableGame {
    bytes32 public hashedAnswer;
    address public winner;
    uint256 public reward;

    constructor(bytes32 _hashedAnswer) payable {
        hashedAnswer = _hashedAnswer;
        reward = msg.value;
    }

    // ❌ VULNERABLE: Front-running attack possible
    // User submits correct answer in mempool
    // MEV bot sees the transaction
    // Bot copies the answer with higher gas
    // Bot's transaction executes first
    // Bot wins the reward
    function submitAnswer(string memory answer) external {
        require(
            keccak256(abi.encodePacked(answer)) == hashedAnswer,
            "Wrong answer"
        );
        require(winner == address(0), "Already solved");

        winner = msg.sender;
        payable(msg.sender).transfer(reward);
    }
}
