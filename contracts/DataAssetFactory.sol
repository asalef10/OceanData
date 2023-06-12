// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./DataAsset.sol";
import "./DataAssetTypes.sol";

contract DataAssetFactory is Ownable {
    event AssetCreated(DataAsset indexed asset, address indexed owner);

    mapping(address => DataAsset[]) public assetsByOwner;

    function CreateDataAsset(uint256 tokenId) external {
        DataAsset newAsset = new DataAsset();
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
