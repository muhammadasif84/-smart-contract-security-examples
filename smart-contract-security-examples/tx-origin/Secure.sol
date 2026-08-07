// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

/// @title SecureWallet
/// @notice Demonstrates tx.origin fix
/// @dev Always use msg.sender for authentication
/// Full guide: coming soon on blockhertz.com/blog

contract SecureWallet is Ownable {

    constructor() Ownable(msg.sender) {}

    // ✅ SECURE: msg.sender cannot be spoofed
    // msg.sender = direct caller of this function
    // No malicious contract can fake msg.sender
    function withdraw(
        address payable to,
        uint256 amount
    ) external onlyOwner {
        // onlyOwner uses msg.sender internally
        require(address(this).balance >= amount, "Insufficient balance");
        to.transfer(amount);
    }

    // ✅ RULE: Never use tx.origin for authentication
    // tx.origin = original EOA that initiated the transaction
    // Vulnerable to phishing via malicious intermediate contracts
    // Always use msg.sender instead

    function deposit() external payable {}

    receive() external payable {}
}
