// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataAssetTypes {
    struct DDO {
        string title;
        string description;
        string metadata;
        string encryptedFileURL;
    }

    struct DataNFT {
        uint256 Id;
        address owner;
        uint256 price;
        DDO dataDDO;
    }
}