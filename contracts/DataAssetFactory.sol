// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./DataAssetTypes.sol";
import "./DataAsset.sol";

contract DataAssetFactory is Ownable {
    event AssetCreated(DataAsset indexed asset, address indexed owner);
    address USDC_TOKEN_ADDRESS;
    mapping(address => DataAsset[]) public assetsByOwner;

    constructor(address _USDC_TOKEN_ADDRESS) {
        USDC_TOKEN_ADDRESS = _USDC_TOKEN_ADDRESS;
    }

    function CreateDataAsset(uint256 tokenId) external {
        DataAsset newAsset = new DataAsset(address(this), USDC_TOKEN_ADDRESS);
        newAsset.transferOwnership(msg.sender);

        DataAssetTypes.DDO memory dataDDO = DataAssetTypes.DDO({
            title: "Fake Title",
            description: "Fake Description",
            metadata: "Fake Metadata",
            encryptedFileURL: "https://fakeurl.com"
        });

        DataAssetTypes.DataNFT memory dataNFT = DataAssetTypes.DataNFT({
            Id: tokenId,
            owner: msg.sender,
            price: 5,
            dataDDO: dataDDO
        });
        newAsset.CreateAsset(tokenId, dataNFT);

        assetsByOwner[msg.sender].push(newAsset);

        emit AssetCreated(newAsset, msg.sender);
    }

    function GetOwnerAssets(address owner)
        external
        view
        returns (DataAsset[] memory)
    {
        return assetsByOwner[owner];
    }
}
