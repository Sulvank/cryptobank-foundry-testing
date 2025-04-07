// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {CryptoBank} from "../src/CryptoBank.sol";

contract CryptoBankTest is Test {
    CryptoBank public cryptobank;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);
    uint256 public maxBalance = 5 ether;

    function setUp() public {
        cryptobank = new CryptoBank(maxBalance, admin);
    }

    function testDepositEther() public {
        uint256 depositAmount_ = 2 ether;
        vm.deal(randomUser, depositAmount_);

        vm.startPrank(randomUser);
        cryptobank.depositEther{value: depositAmount_}();
        vm.stopPrank();

        assertEq(cryptobank.userBalance(randomUser), depositAmount_);
    }

    function testWithdrawEther() public {
        uint256 depositAmount_ = 2 ether;
        vm.deal(randomUser, depositAmount_);

        vm.startPrank(randomUser);
        cryptobank.depositEther{value: depositAmount_}();

        uint256 withdrawAmount_ = 1 ether;
        cryptobank.withdrawEther(withdrawAmount_);
        vm.stopPrank();

        assertEq(cryptobank.userBalance(randomUser), depositAmount_ - withdrawAmount_);
    }

    function testDepositExceedMaxBalanceShouldRevert() public {
        uint256 depositAmount = 6 ether;
        vm.deal(randomUser, depositAmount);

        vm.expectRevert("Exceed balance limit");
        cryptobank.depositEther{value: depositAmount}();
    }

    function testWithdrawExceedBalanceShouldRevert() public {
        uint256 depositAmount = 2 ether;
        vm.deal(randomUser, depositAmount);
        cryptobank.depositEther{value: depositAmount}();

        uint256 withdrawAmount = 3 ether;

        vm.expectRevert("Insufficient balance");
        cryptobank.withdrawEther(withdrawAmount);
    }

    function testOnlyAdminCanSetMaxBalance() public {
        vm.startPrank(randomUser);
        vm.expectRevert("You are not allowed");
        cryptobank.modifyMaxBalance(10 ether);
        vm.stopPrank();
    }

    function testAdminCanSetMaxBalance() public {
        vm.startPrank(admin);
        uint256 newMaxBalance = 10 ether;
        cryptobank.modifyMaxBalance(newMaxBalance);
        vm.stopPrank();

        assertEq(cryptobank.maxBalance(), newMaxBalance);
    }

    function testEmitDepositEvent() public {
        uint256 depositAmount = 2 ether;
        vm.deal(randomUser, depositAmount);

        vm.startPrank(randomUser);
        vm.expectEmit(true, true, false, true);
        emit EtherDeposit(randomUser, depositAmount);
        cryptobank.depositEther{value: depositAmount}();
        vm.stopPrank();
    }

}
