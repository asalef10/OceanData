# DataAsset Ethereum Smart Contracts
This repository contains Ethereum smart contracts for the DataAsset project. DataAsset is a decentralized marketplace for data where users can buy and sell access to data.

# Smart Contracts
The main contracts in this project are DataAsset and DataAssetFactory.

* DataAsset: This contract represents a data asset. It includes functionality for creating a new data asset, setting the price, and transferring ownership. Each data asset is an NFT (non-fungible token), represented by a unique token ID.

* DataAssetFactory: This contract is used to deploy new instances of DataAsset. Each user who wants to sell data creates a new DataAsset through this factory contract.

# Installation
To install and compile the contracts, follow these steps:

* 1. Clone this repository:

bash
Copy code
git clone https://github.com/asalef10/OceanData
Install the dependencies:

Copy code
npm install
Compile the contracts:

python
Copy code
truffle compile
Testing
To run the test suite:

bash
Copy code
truffle test
Deployment
To deploy the contracts to a local Ethereum network:

css
Copy code
truffle migrate --network development
For deployment to a live network, please configure the appropriate network settings in truffle-config.js.

Contract Interaction
After deployment, you can interact with the contracts using the Truffle console or a web3.js/ethers.js script. Please refer to the contract ABIs in the build/contracts directory.
