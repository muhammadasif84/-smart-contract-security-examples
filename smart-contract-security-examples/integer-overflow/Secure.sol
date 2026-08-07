// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SecureCounter
/// @notice Demonstrates integer overflow prevention
/// @dev Solidity 0.8.0+ has built-in overflow protection
/// Full guide: coming soon on blockhertz.com/blog

contract SecureCounter {
    mapping(address => uint256) public balances;

    // ✅ SECURE: Solidity 0.8.0+ auto-reverts on overflow
    function deposit(uint256 amount) external {
        // Automatically reverts if overflow occurs
        balances[msg.sender] += amount;
    }

    // ✅ SECURE: Automatically reverts on underflow
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        // Automatically reverts if underflow occurs
        balances[msg.sender] -= amount;
    }

    // ✅ SECURE: Safe time lock with explicit check
    function timeLock(
        uint256 daysToLock
    ) external view returns (uint256) {
        require(daysToLock <= 365, "Max 1 year lock");
        return block.timestamp + (daysToLock * 1 days);
    }

    // ✅ When you NEED unchecked arithmetic (gas optimization):
    // Only use unchecked when overflow is mathematically impossible
    function safeIncrement(uint256 i) external pure returns (uint256) {
        unchecked {
            // Safe because i < type(uint256).max is guaranteed by caller
            return i + 1;
        }
    }
}
