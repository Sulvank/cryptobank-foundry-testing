# 🏦 CryptoBank - Solidity Smart Contract for Ether Banking

## 📝 Overview

**CryptoBank** is a smart contract that simulates a simple multi-user bank, allowing users to deposit and withdraw Ether securely. The system enforces balance limits and ensures that users can only manage their own funds.

> [!NOTE]  
> This contract is developed using **Solidity 0.8.28** and tested with **Foundry** for full security and performance.

### 🔹 Key Features:
- ✅ **Multi-user support** with independent balances.
- ✅ **Ether deposits and withdrawals** per user.
- ✅ **Maximum balance limit** enforced per user.
- ✅ **Only users can manage their own funds.**
- ✅ **Admin-controlled balance limit adjustment.**

---

## ✨ Features

### 💸 Ether Deposit System
- Any address can deposit Ether into the bank.
- Deposits are tracked per user.
- Deposits exceeding the `maxBalance` limit are rejected.

### 🏧 Secure Withdrawals
- Users can only withdraw the Ether they have deposited.
- Withdrawals revert if the user’s balance is insufficient.
- Transfers are done via `.call{value: amount}` for flexibility.

### 🔒 Admin Control
- The admin address can update the `maxBalance`.
- Admin checks are enforced using a modifier.

---

## 📖 Contract Summary

### Core Functions

| 🔧 Function                         | 📋 Description                                                   |
|------------------------------------|------------------------------------------------------------------|
| `depositEther()`                   | Allows any user to deposit Ether if under the max balance limit. |
| `withdrawEther(uint256 amount)`    | Lets users withdraw their own deposited Ether.                   |
| `modifyMaxBalance(uint256 value)`  | Allows admin to update the balance cap for all users.            |

---

## ⚙️ Prerequisites

### 🛠️ Tools Required:
- **🖥️ Foundry**: Smart contract toolkit for building & testing. [Install Guide](https://book.getfoundry.sh/getting-started/installation)
- **🔗 GitHub**: For version control and CI integration.
- **Metamask / Hardhat / Remix** (optional): For manual interaction.

### 🌐 Environment:
- Solidity: `0.8.28`
- Framework: [Foundry](https://github.com/foundry-rs/foundry)

---

## 🚀 How to Use the Project

### 🧪 Running the Test Suite

```bash
forge install
forge build
forge test -vvvv
```

To check coverage:

```bash
forge coverage
```

### 🔍 Running a Single Test

```bash
forge test -m testWithdrawEther -vvvv
```

---

## 📜 Events

| Event              | Description                                |
|--------------------|--------------------------------------------|
| `EtherDeposit`     | Emitted when a user deposits Ether.        |
| `EtherWithDraw`    | Emitted when a user withdraws Ether.       |

---

## 🛠️ Extending the Contract

### 🔍 Possible Improvements
- 🧑‍⚖️ Role-based access control with OpenZeppelin.
- 📈 Interest or rewards on deposits.
- 🧾 Transaction history per user.
- 🌉 Integration with frontend dApp (React + Ethers.js).
- 🔐 ReentrancyGuard or security audits for production deployment.

> [!CAUTION]  
> Always audit your smart contracts before deploying to mainnet.

---

## 📜 License

This project is licensed under the **LGPL-3.0-only** License.

---

### 🚀 CryptoBank: a secure, tested Ether vault for multi-user use cases!
