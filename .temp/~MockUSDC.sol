// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "c:/Users/Asalef alena/Desktop/ocean/node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockUSDC is ERC20 {
    constructor() ERC20("USD Coin", "USDC") {
        _mint(msg.sender, 1000000 * 10 ** decimals()); // Mint 1 million USDC to the contract deployer
    }
}
