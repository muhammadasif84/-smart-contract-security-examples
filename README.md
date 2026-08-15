# Smart Contract Security Examples

A collection of vulnerable and secure 
Solidity smart contract examples for 
educational purposes.

Built and maintained by the 
[Blockhertz](https://blockhertz.com) team.

---

## Purpose

This repository helps blockchain developers 
understand common smart contract 
vulnerabilities by showing:

- ❌ Vulnerable code (what NOT to do)
- ✅ Secure code (the correct pattern)
- 📖 Explanation of each vulnerability
- 🔧 How to fix it

---

## Vulnerabilities Covered

### 1. Reentrancy Attack
The most common smart contract vulnerability.
Caused the $60M DAO hack in 2016.

📁 `vulnerabilities/reentrancy/`
📖 [Full Guide](https://blockhertz.com/blog/reentrancy-attack-solidity-smart-contract-2026)

### 2. Missing Access Control
Anyone can call privileged functions.
Caused the $611M Poly Network hack.

📁 `vulnerabilities/access-control/`
📖 [Full Guide](https://blockhertz.com/blog/access-control-vulnerability-solidity-2026)

### 3. Integer Overflow/Underflow
Real example: BEC Token hack — $900M (2018)
📖 [Full Guide](https://blockhertz.com/blog/integer-overflow-solidity-2026)
▶️ [Video Demo](https://www.youtube.com/watch?v=vIDQ7nMppDI)

📁 `vulnerabilities/integer-overflow/`

### 4. tx.origin Authentication
Phishing attack via malicious contract.

📁 `vulnerabilities/tx-origin/`
📖 Coming soon

### 5. Front-Running
MEV bots exploit transaction ordering.

📁 `vulnerabilities/front-running/`
📖 Coming soon

---

## Free AI Smart Contract Auditor

Check your contracts for all these 
vulnerabilities automatically in 60 seconds.

🔍 [Try Blockhertz AI Auditor Free](https://blockhertz.com/tools/ai-auditor)

- Paste any Solidity, Rust, Move, or Vyper contract
- Get risk score (0-100)
- See findings by severity
- Get fix recommendations
- No signup required

---

## Other Free Blockhertz Tools

| Tool | Description |
|------|-------------|
| [AI Smart Contract Auditor](https://blockhertz.com/tools/ai-auditor) | Security scan in 60 seconds |
| [AI Architecture Generator](https://blockhertz.com/tools/ai-architect) | C4 diagrams from text |
| [AI Gas Optimizer](https://blockhertz.com/tools/gas-optimizer) | Reduce gas costs automatically |
| [AI Tokenomics Designer](https://blockhertz.com/tools/tokenomics) | Token distribution + PDF report |

---

## Resources

- 📖 [How to Audit a Smart Contract](https://blockhertz.com/blog/how-to-audit-a-smart-contract-complete-security-checklist-2026)
- 📖 [Reentrancy Attack Guide](https://blockhertz.com/blog/reentrancy-attack-solidity-smart-contract-2026)
- 📖 [Solidity Gas Optimization](https://blockhertz.com/blog/solidity-gas-optimization-15-patterns-to-reduce-costs-2026)
- 📖 [SWC Registry](https://swcregistry.io)
- 📖 [Consensys Best Practices](https://consensys.github.io/smart-contract-best-practices)

---

## Contributing

Found a vulnerability example we missed?
Open a PR — contributions welcome!

---

## License

MIT License — free to use for educational purposes.

---

⭐ Star this repo if it helped you!
