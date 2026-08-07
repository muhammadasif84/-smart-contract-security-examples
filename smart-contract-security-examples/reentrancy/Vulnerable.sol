// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title VulnerableBank
/// @notice DO NOT USE IN PRODUCTION
/// @dev Demonstrates reentrancy vulnerability
/// Full guide: https://blockhertz.com/blog/reentrancy-attack-solidity-smart-contract-2026

contract VulnerableBank {
    mapping(address => uint256) public balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must deposit ETH");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // ❌ VULNERABLE: External call before state update
    // Attacker can re-enter before balance is set to 0
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");

        // ❌ Sends ETH BEFORE updating balance
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        // ❌ Balance updated AFTER sending — too late
        balances[msg.sender] = 0;

        emit Withdrawal(msg.sender, amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
