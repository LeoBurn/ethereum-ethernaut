// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.10;

contract DaoWallet{
    mapping(address => uint ) public balances;

    constructor() public {
        
    }

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(balances[msg.sender]>= _amount);

        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent,"Money Transfer Failed");

        balances[msg.sender] -= _amount;
    }

    function getAccountBalance() public view returns(uint){
        return address(this).balance;
    }
}