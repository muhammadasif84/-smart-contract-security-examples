// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/// @title VulnerableCounter
/// @notice DO NOT USE IN PRODUCTION
/// @dev Demonstrates integer overflow vulnerability
/// Only exists in Solidity < 0.8.0
/// Full guide: coming soon on blockhertz.com/blog

contract VulnerableCounter {
    mapping(address => uint256) public balances;

    // ❌ VULNERABLE: No overflow protection (Solidity 0.6.x)
    // Adding 1 to type(uint256).max wraps to 0
    function deposit(uint256 amount) external {
        // If balances[msg.sender] = type(uint256).max
        // Then balances[msg.sender] + amount overflows to small number
        balances[msg.sender] += amount;
    }

    // ❌ VULNERABLE: Underflow possible
    function withdraw(uint256 amount) external {
        // If amount > balance, wraps to huge number
        balances[msg.sender] -= amount;
    }

    // ❌ VULNERABLE: Overflow in time lock
    function timeLock(uint256 daysToLock) external view returns (uint256) {
        // If daysToLock is huge, block.timestamp + daysToLock overflows
        return block.timestamp + daysToLock;
    }
}
