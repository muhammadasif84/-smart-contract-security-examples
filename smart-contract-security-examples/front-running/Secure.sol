// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SecureGame
/// @notice Demonstrates front-running prevention
/// @dev Uses commit-reveal pattern
/// Full guide: coming soon on blockhertz.com/blog

contract SecureGame {
    bytes32 public hashedAnswer;
    address public winner;
    uint256 public reward;

    // Commit-reveal pattern storage
    mapping(address => bytes32) public commits;
    uint256 public commitDeadline;
    uint256 public revealDeadline;

    constructor(bytes32 _hashedAnswer) payable {
        hashedAnswer = _hashedAnswer;
        reward = msg.value;
        commitDeadline = block.timestamp + 1 days;
        revealDeadline = block.timestamp + 2 days;
    }

    // ✅ STEP 1: Commit (hide your answer)
    // Submit hash of (answer + secret salt)
    // Nobody can see your actual answer
    function commit(bytes32 commitment) external {
        require(block.timestamp < commitDeadline, "Commit phase over");
        commits[msg.sender] = commitment;
    }

    // ✅ STEP 2: Reveal (after commit phase)
    // Now reveal your answer + salt
    // Front-running useless — commit already recorded
    function reveal(
        string memory answer,
        bytes32 salt
    ) external {
        require(block.timestamp >= commitDeadline, "Commit phase not over");
        require(block.timestamp < revealDeadline, "Reveal phase over");
        require(winner == address(0), "Already solved");

        // Verify commitment matches
        bytes32 commitment = keccak256(
            abi.encodePacked(answer, salt)
        );
        require(commits[msg.sender] == commitment, "Invalid reveal");

        // Verify answer is correct
        require(
            keccak256(abi.encodePacked(answer)) == hashedAnswer,
            "Wrong answer"
        );

        winner = msg.sender;
        payable(msg.sender).transfer(reward);
    }
}
