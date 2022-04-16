//Teencoins ICO

//Version of compiler
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract Teencoins_ico {

    // Introducing the maximum nuber of Teencoins available for sale
    uint public max_teencoins = 1000000;

    // Introducing the USD to teencoins conversion rate
    uint public usd_to_teencoins = 1000;

    // Introducing the the total number of teencoins that have been bought by the investors
    uint public total_teencoins_bought = 0;

    // Mapping from the investor address to its equity in Teencoins and USD 
    mapping(address => uint) public equity_teencoins;
    mapping(address => uint) public equity_usd;

    // Checking if an investor can buy Teencoins
    modifier can_buy_teencoins(uint usd_invested) {
        require (usd_invested * usd_to_teencoins + total_teencoins_bought <= max_teencoins);
        _;
    }

    // Getting the equity in Teencoins of an investor
    function equtiy_in_teencoins(address investor) external constant returns (uint) {
        return equity_teencoins[investor];
    }

    // Getting the equity in USD of an investor
    function equtiy_in_usd(address investor) external constant returns (uint) {   
        return equity_usd[investor];
    }

    // Buying Teencoins
    function buy_teencoins(address investor, uint usd_invested) external 
    can_buy_teencoins(usd_invested) {
        uint teencoins_bought = usd_invested * usd_invested;
        equity_teencoins[investor] += teencoins_bought;
        equity_usd[investor] = equity_teencoins[investor] / 1000;
        total_teencoins_bought += teencoins_bought; 
    }

    // Selling Teencoins
    function sell_teencoins(address investor, uint teencoins_sold) external {
        equity_teencoins[investor] -= teencoins_sold;
        equity_usd[investor] = equity_teencoins[investor] / 1000;
        total_teencoins_bought -= teencoins_sold;
    }

} 