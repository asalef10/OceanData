# DataAsset Ethereum Smart Contracts
This repository contains Ethereum smart contracts for the DataAsset project. DataAsset is a decentralized marketplace for data where users can buy and sell access to data.

# Smart Contracts
The main contracts in this project are DataAsset and DataAssetFactory.

* DataAsset: This contract represents a data asset. It includes functionality for creating a new data asset, setting the price, and transferring ownership. Each data asset is an NFT (non-fungible token), represented by a unique token ID.

* DataAssetFactory: This contract is used to deploy new instances of DataAsset. Each user who wants to sell data creates a new DataAsset through this factory contract.

# Installation
To install and compile the contracts, follow these steps:

* 1. Clone this repository:

- git clone https://github.com/asalef10/OceanData

* 2. Install the dependencies:

- npm install

* 3. Compile the contracts:

- truffle compile


# Deployment
- To deploy the contracts to a local Ethereum network:


* truffle migrate --network development

For deployment to a live network, please configure the appropriate network settings in truffle-config.js.

Contract Interaction
After deployment, you can interact with the contracts using the Truffle console or a web3.js/ethers.js script. Please refer to the contract ABIs in the build/contracts directory.
