// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Tokens } from"./Tokens.sol";
import { SafeMath } from "@openzeppelin/contracts/utils/math/SafeMath.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract TokenSale is Ownable {
    using SafeMath for uint256;

    Tokens public token;
    uint256 public tokenPrice;
    uint256 public tokensSold;
    uint256 public buyingStartTime;

    event TokensPurchased(address buyer, uint256 amount);

    constructor(Tokens _token, uint256 _tokenPrice, uint256 _buyingStartTime) Ownable(msg.sender){
        token = _token;
        tokenPrice = _tokenPrice;
        buyingStartTime = _buyingStartTime;
    }

    function buyTokens(uint256 numberOfTokens) external payable {
        require(block.timestamp > buyingStartTime,"You can not buy before start");
        require(msg.value == numberOfTokens.mul(tokenPrice), "Not enough amount");
        require(token.balanceOf(address(this)) >= numberOfTokens, "Not enough balance of smart contract");

        token.transfer(msg.sender, numberOfTokens);
        tokensSold = tokensSold.add(numberOfTokens);

        emit TokensPurchased(msg.sender, numberOfTokens);
    }

    function withdrawEther() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}