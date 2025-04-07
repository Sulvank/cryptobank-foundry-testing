// Licencia
// SPDX-License-Identifier: LGPL-3.0-only

// Version 
pragma solidity 0.8.28;

// Funtions:
    // 1. Deposit ether
    // 2. Withdraw ether

// Rules:
    // 1. Multiuser
    // 2. Only can deposit ether
    // 3. Only can withdraw your own ether
    // 4. Max balance = 5 ether
    // UserA -> Deposit (5 ether)
    // UserB -> Deposit (2 ether)
    // Bank balance = 7 ether

contract CryptoBank {
    
    // Variable
    uint256 public maxBalance;
    address public admin;
    mapping (address => uint256) public userBalance;

    // Events
    event EtherDeposit(address user_, uint256 etheramount_);
    event EtherWithDraw(address user_, uint256 etheramount_);

    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "You are not allowed");
        _;
    }


    constructor(uint256 maxBalance_, address admin_) {
        maxBalance = maxBalance_;
        admin = admin_;
    }

    // External Functions

    // 1. Deposit
    function depositEther() external payable {
        require(userBalance[msg.sender] + msg.value < maxBalance, "Exceed balance limit");
        userBalance[msg.sender] += msg.value;

        emit EtherDeposit(msg.sender, msg.value);
    }

    // 2.Withdraw
    function withdrawEther(uint256 amount_) external {
        require (amount_ <= userBalance[msg.sender], "Insufficient balance");
        
        // 1.Update state
        userBalance[msg.sender] -= amount_;

        // 2. Transfer Ether
        (bool success,) = msg.sender.call{value: amount_}("");
        require(success, "Transfer failed");

        emit EtherWithDraw(msg.sender, amount_);
    }


    // 3. Modify maxBalance
    function modifyMaxBalance(uint256 newMaxBalance_) external onlyAdmin  {
        maxBalance = newMaxBalance_;
    }
}