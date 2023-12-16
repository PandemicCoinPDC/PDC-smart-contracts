// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract Tokens is ERC20,Ownable {

    bool private _paused;

    event TokenMinted(address account, uint256 amount);
    event OwnershipTransfered(address from, address to);

    constructor(uint256 initialSupply) ERC20("Airdrop Token", "ATH") Ownable(msg.sender){
        _mint(msg.sender, initialSupply);
        emit TokenMinted(msg.sender, initialSupply);
    }

    function mint(uint256 _tokens) public onlyOwner {
        emit TokenMinted(msg.sender, _tokens);
        _mint(msg.sender, _tokens);
    }

    function transferOwnership(address newOwner) public override onlyOwner {
        emit OwnershipTransfered(msg.sender, newOwner);
        transferOwnership(newOwner);
    }

    function pause() public onlyOwner {
        _paused = true;
    }

    function unpause() public onlyOwner {
        _paused = false;
    }

    function transfer(address to, uint256 value) public override whenNotPaused returns (bool) {
        super.transfer(to, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public override  whenNotPaused returns (bool){
        super.transferFrom(from, to, value);
        return true;
    }

    modifier whenNotPaused() {
        require(!_paused, "Paused");
        _;
    }
}