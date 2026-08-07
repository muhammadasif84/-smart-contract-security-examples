// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable2Step.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/// @title SecureToken
/// @notice Demonstrates proper access control
/// @dev Uses OpenZeppelin Ownable2Step + AccessControl
/// Full guide: https://blockhertz.com/blog/access-control-vulnerability-solidity-2026

contract SecureToken is Ownable2Step, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    bool public paused;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Minted(address indexed to, uint256 amount);
    event Paused(address indexed by);
    event EmergencyWithdraw(address indexed to, uint256 amount);

    constructor() Ownable(msg.sender) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
    }

    // ✅ SECURE: Only minters can mint
    function mint(
        address to,
        uint256 amount
    ) external onlyRole(MINTER_ROLE) {
        totalSupply += amount;
        balances[to] += amount;
        emit Minted(to, amount);
    }

    // ✅ SECURE: Only owner can withdraw
    function emergencyWithdraw(
        address to
    ) external onlyOwner {
        uint256 balance = address(this).balance;
        payable(to).transfer(balance);
        emit EmergencyWithdraw(to, balance);
    }

    // ✅ SECURE: Ownable2Step requires acceptance
    // Owner calls transferOwnership()
    // New owner must call acceptOwnership()
    // Prevents accidental lockout

    // ✅ SECURE: Only pausers can pause
    function pause() external onlyRole(PAUSER_ROLE) {
        paused = true;
        emit Paused(msg.sender);
    }

    function transfer(address to, uint256 amount) external {
        require(!paused, "Protocol paused");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }
}
