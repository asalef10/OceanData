pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./DataAssetTypes.sol";

contract DataAsset is Ownable {
    event AssetCreated(
        uint256 Id,
        address owner,
        uint256 price,
        DataAssetTypes.DDO dataDDO
    );
    event AssetPurchased(uint256 tokenId, address buyer, address seller);

    uint8 constant TOKEN_DECIMALS = 18;
    mapping(uint256 => mapping(address => bool)) buyersData;
    IERC20 public USDC_TOKEN;
    address private factoryAddress;
    
    mapping(uint256 => DataAssetTypes.DataNFT) public dataNFTs;

    constructor(address _factoryAddress,address _USDC_TOKEN_ADDRESS) {
        USDC_TOKEN = IERC20(_USDC_TOKEN_ADDRESS);
        factoryAddress = _factoryAddress;
    }

    modifier tokenExists(uint256 tokenId) {
        require(dataNFTs[tokenId].owner != address(0), "Token does not exist");
        _;
    }

    function CreateAsset(
        uint256 tokenId,
        DataAssetTypes.DataNFT calldata dataNFT
    ) external {
        require(dataNFTs[tokenId].owner == address(0), "Token already exists");

        dataNFTs[tokenId] = dataNFT;

        emit AssetCreated(
            dataNFT.Id,
            dataNFT.owner,
            dataNFT.price,
            dataNFT.dataDDO
        );
    }

    function PurchaseAsset(uint256 tokenId)
        external
        payable
        tokenExists(tokenId)
    {
        (uint256 finalPrice, uint256 feeAmount) = _calculateFinalPrice(tokenId);

        address ownerData = dataNFTs[tokenId].owner;

        bool feeTransferred = USDC_TOKEN.transferFrom(
            msg.sender,
            factoryAddress,
            feeAmount
        );
        require(feeTransferred, "Fee transfer failed");

        bool priceTransferred = USDC_TOKEN.transferFrom(
            msg.sender,
            ownerData,
            finalPrice
        );
        require(priceTransferred, "Price transfer failed");
        buyersData[tokenId][msg.sender] = true;
        emit AssetPurchased(tokenId, msg.sender, dataNFTs[tokenId].owner);
    }

    function GetDataDDO(uint256 tokenId)
        external
        view
        tokenExists(tokenId)
        returns (string[] memory)
    {
        require(buyersData[tokenId][msg.sender], "Unauthorized access");

        string[] memory ddoInfo = new string[](2);
        ddoInfo[0] = dataNFTs[tokenId].dataDDO.metadata;
        ddoInfo[1] = dataNFTs[tokenId].dataDDO.encryptedFileURL;
        return ddoInfo;
    }

    function _calculateFinalPrice(uint256 tokenId)
        private
        view
        tokenExists(tokenId)
        returns (uint256 finalPrice, uint256 feeAmount)
    {
        uint256 assetPrice = dataNFTs[tokenId].price;
        uint256 calculatedAmount = assetPrice * (10**uint256(TOKEN_DECIMALS));

        feeAmount = (calculatedAmount * 10) / 100;
        finalPrice = calculatedAmount - feeAmount;

        return (finalPrice, feeAmount);
    }
}