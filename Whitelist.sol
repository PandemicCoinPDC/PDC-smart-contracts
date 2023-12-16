// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract Whitelist is Ownable {
    enum AddressType { Private, Advisor, Airdrop, Team, TechAI, Security, Ecosystem, PhysicalFund, CexReserve }
    mapping(address => AddressType) private whitelist;

    event AddedToWhitelist(address account, AddressType accountType);
    event RemovedFromWhitelist(address account);

    constructor() Ownable(msg.sender) {}

    function addToWhitelist(address account, AddressType accountType) external onlyOwner {
        whitelist[account] = accountType;
        emit AddedToWhitelist(account, accountType);
    }

    function removeFromWhitelist(address account) external onlyOwner {
        delete whitelist[account];
        emit RemovedFromWhitelist(account);
    }

    function getAddressType(address account) external view returns (AddressType) {
        return whitelist[account];
    }

    function isWhitelisted(address account) public view returns (bool) {
        return whitelist[account] != AddressType(0);
    }

}