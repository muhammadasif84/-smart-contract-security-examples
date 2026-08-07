// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/// @title SecureBank
/// @notice Demonstrates reentrancy prevention
/// @dev Uses CEI pattern + ReentrancyGuard
/// Full guide: https://blockhertz.com/blog/reentrancy-attack-solidity-smart-contract-2026

contract SecureBank is ReentrancyGuard {
    mapping(address => uint256) public balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must deposit ETH");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // ✅ SECURE: CEI pattern + nonReentrant modifier
    function withdraw() external nonReentrant {
        uint256 amount = balances[msg.sender];

        // CHECK — verify condition first
        require(amount > 0, "No balance to withdraw");

        // EFFECT — update state before external call
        balances[msg.sender] = 0;

        // INTERACTION — external call last
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        // EVENT — emit after successful call
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
