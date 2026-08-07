// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title VulnerableToken
/// @notice DO NOT USE IN PRODUCTION
/// @dev Demonstrates missing access control vulnerability
/// Full guide: https://blockhertz.com/blog/access-control-vulnerability-solidity-2026

contract VulnerableToken {
    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // ❌ VULNERABLE: No access control — anyone can mint
    function mint(address to, uint256 amount) external {
        totalSupply += amount;
        balances[to] += amount;
    }

    // ❌ VULNERABLE: No access control — anyone can drain
    function emergencyWithdraw(address to) external {
        uint256 balance = address(this).balance;
        payable(to).transfer(balance);
    }

    // ❌ VULNERABLE: tx.origin used for auth
    function setOwner(address newOwner) external {
        require(tx.origin == owner, "Not owner");
        owner = newOwner;
    }

    // ❌ VULNERABLE: No access control on pause
    function pause() external {
        // pauses entire protocol — anyone can call
    }

    function transfer(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }
}
